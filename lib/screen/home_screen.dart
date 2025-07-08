import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../util/color.dart';
import '../util/hangul_util.dart' as HangulUtils;

import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

enum SortType { volume, price, change }

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> upbitMarkets = [];
  List<dynamic> _allMarketList = [];
  List<dynamic> _displayList = [];
  String _searchQuery = '';
  bool isLoading = true;
  String? _sortColumn;
  bool? _sortDirection; // true: ascending, false: descending, null: default

  IOWebSocketChannel? _channel;

  // Number formatters
  final numberFormatter = NumberFormat("#,##0.########");
  final volumeFormatter = NumberFormat("#,##0백만");

  @override
  void initState() {
    super.initState();
    fetchUpbitMarketData().then((_) => _connectToWebSocket());
  }
  void _connectToWebSocket() {
    if (_allMarketList.isEmpty) return;
    final codes = _allMarketList.map((e) => e['market']).toList();
    final ticket = DateTime.now().millisecondsSinceEpoch.toString();
    final payload = [
      {"ticket": ticket},
      {
        "type": "ticker",
        "codes": codes,
        "isOnlyRealtime": true
      }
    ];

    _channel = IOWebSocketChannel.connect(
      Uri.parse("wss://api.upbit.com/websocket/v1"),
      headers: {"accept-language": "ko"},
    );

    _channel!.sink.add(jsonEncode(payload));

    bool _pendingUpdate = false;
    void triggerUpdate() {
      if (!_pendingUpdate) {
        _pendingUpdate = true;
        Future.delayed(const Duration(milliseconds: 150), () {
          if (mounted) _sortMarketList();
          _pendingUpdate = false;
        });
      }
    }

    _channel!.stream.listen((data) {
      final decoded = jsonDecode(utf8.decode((data as Uint8List)));
      final index = _allMarketList.indexWhere((item) => item['market'] == decoded['code']);
      if (index != -1) {
        final oldPrice = _allMarketList[index]['trade_price'];
        final newPrice = decoded['trade_price'];

        final now = DateTime.now().millisecondsSinceEpoch;
        final lastUpdated = _allMarketList[index]['updatedAt'] ?? 0;
        final priceDiff = (oldPrice - newPrice).abs();
        final priceThreshold = getPriceThreshold(oldPrice);

        if (priceDiff > priceThreshold) {
          _allMarketList[index]['trade_price'] = newPrice;
          _allMarketList[index]['signed_change_rate'] = decoded['signed_change_rate'];
          _allMarketList[index]['acc_trade_price_24h'] = decoded['acc_trade_price_24h'];
          _allMarketList[index]['updatedAt'] = now;
          triggerUpdate();
        }
      }
    }, onDone: () {
      debugPrint('WebSocket closed. Attempting to reconnect in 5 seconds...');
      Future.delayed(const Duration(seconds: 5), () {
        if (mounted) _connectToWebSocket();
      });
    }, onError: (error) {
      debugPrint('WebSocket error: $error. Reconnecting in 5 seconds...');
      Future.delayed(const Duration(seconds: 5), () {
        if (mounted) _connectToWebSocket();
      });
    });
  }

  double getPriceThreshold(double price) {
    if (price >= 1000000) return 1000;
    if (price >= 100000) return 500;
    if (price >= 10000) return 100;
    if (price >= 1000) return 10;
    if (price >= 100) return 1;
    if (price >= 10) return 0.1;
    if (price >= 1) return 0.01;
    return 0.001;
  }

  Future<void> fetchUpbitMarketData() async {
    try {
      final marketRes = await http.get(Uri.parse('https://api.upbit.com/v1/market/all?isDetails=false'));
      if (marketRes.statusCode != 200) {
        throw Exception('Failed to load market data');
      }
      final List<dynamic> markets = jsonDecode(marketRes.body)
          .where((m) => m['market'].toString().startsWith('KRW-'))
          .toList();

      final marketCodes = markets.map((m) => m['market']).toList();
      final marketQuery = marketCodes.join(',');
      final tickerRes = await http.get(Uri.parse('https://api.upbit.com/v1/ticker?markets=$marketQuery'));
      if (tickerRes.statusCode != 200) {
        throw Exception('Failed to load ticker data');
      }
      final List<dynamic> tickers = jsonDecode(tickerRes.body)
          .where((t) => marketCodes.contains(t['market']))
          .toList()
          ..sort((a, b) {
            final aIdx = marketCodes.indexOf(a['market']);
            final bIdx = marketCodes.indexOf(b['market']);
            return aIdx.compareTo(bIdx);
          });

      setState(() {
        upbitMarkets = markets;
        _allMarketList = tickers;
        _displayList = List.from(_allMarketList);
        isLoading = false;
      });
      _sortMarketList();
    } catch (e) {
      debugPrint('Error fetching market data: $e');
    }
  }

  void _onSortColumn(String column) {
    setState(() {
      if (_sortColumn == column) {
        if (_sortDirection == null) {
          _sortDirection = true; // ascending
        } else if (_sortDirection == true) {
          _sortDirection = false; // descending
        } else {
          _sortDirection = null; // reset to default
          _sortColumn = null;
        }
      } else {
        _sortColumn = column;
        _sortDirection = true; // ascending by default
      }
      _sortMarketList();
    });
  }

  void _sortMarketList() {
    // Filter by search query
    List<dynamic> filtered = List.from(_allMarketList);
    if (_searchQuery.isNotEmpty) {
      final query = _searchQuery.toLowerCase();
      filtered = filtered.where((ticker) {
        final marketCode = ticker['market'] ?? '';
        final symbol = marketCode.split('-').length > 1 ? marketCode.split('-')[1] : '';
        final market = upbitMarkets.firstWhere(
          (m) => m['market'] == marketCode,
          orElse: () => {'korean_name': '', 'english_name': ''},
        );
        final koreanName = (market['korean_name'] ?? '').toString();
        final initial = HangulUtils.getInitialSound(koreanName).toLowerCase();
        return koreanName.toLowerCase().contains(query) ||
               symbol.toLowerCase().contains(query) ||
               initial.contains(query);
      }).toList();
    }

    List<dynamic> sorted = List.from(filtered);
    // Default: sort by volume descending if no sort column/direction
    if (_sortColumn == null && _sortDirection == null) {
      sorted.sort((a, b) {
        final aValue = a['acc_trade_price_24h'];
        final bValue = b['acc_trade_price_24h'];
        return Comparable.compare(bValue, aValue); // default: volume descending
      });
    } else if (_sortColumn != null && _sortDirection != null) {
      sorted.sort((a, b) {
        dynamic aValue;
        dynamic bValue;
        switch (_sortColumn) {
          case 'price':
            aValue = a['trade_price'];
            bValue = b['trade_price'];
            break;
          case 'change':
            aValue = a['signed_change_rate'];
            bValue = b['signed_change_rate'];
            break;
          case 'volume':
            aValue = a['acc_trade_price_24h'];
            bValue = b['acc_trade_price_24h'];
            break;
        }
        if (_sortDirection!) {
          return Comparable.compare(aValue, bValue);
        } else {
          return Comparable.compare(bValue, aValue);
        }
      });
    }
    setState(() {
      _displayList = sorted;
    });
  }

  Widget _buildSortIcon(String column) {
    if (_sortColumn == column) {
      if (_sortDirection == true) {
        return Icon(Icons.keyboard_arrow_up, size: 12,color: AppColors.lightText);
      } else if (_sortDirection == false) {
        return Icon(Icons.keyboard_arrow_down, size: 12,color: AppColors.lightText);
      }
    }
    return Icon(Icons.unfold_more, size: 12,color: AppColors.lightText); // default state
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(12),
        child: AppBar(
          elevation: 0,
          backgroundColor: AppColors.background,
          // title: _buildExchangeTabBar(),
          centerTitle: true,
        ),
      ),
      body: RefreshIndicator(
        onRefresh: fetchUpbitMarketData,
        child: _buildCoinList(),
      ),
    );
  }

  Widget _buildExchangeTabBar() {
    return Text(
      '업비트',
      style: TextStyle(
        color: AppColors.lightText,
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
    );
  }

  // Removed _buildExchangeButton and selectedExchange logic as only 업비트 is shown.

  Widget _buildCoinList() {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    // Get 'now' once before building the list for consistency
    final now = DateTime.now().millisecondsSinceEpoch;

    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            // 검색창 추가
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: TextField(
                  style: const TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search, color: Colors.grey),
                    hintText: '코인명/심볼 검색',
                    hintStyle: const TextStyle(color: Colors.grey),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
                  ),
                  onChanged: (value) {
                    // Debounce using Future.microtask to avoid excessive setState
                    _searchQuery = value;
                    Future.microtask(() => _sortMarketList());
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: Row(
                children: [
                  Expanded(
                    flex: 7,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text('코인명', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.lightText)),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: GestureDetector(
                      onTap: () => _onSortColumn('price'),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('현재가', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.lightText)),
                            SizedBox(width: 4),
                            _buildSortIcon('price'),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: GestureDetector(
                      onTap: () => _onSortColumn('change'),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('전일대비', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.lightText)),
                            SizedBox(width: 4),
                            _buildSortIcon('change'),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: GestureDetector(
                      onTap: () => _onSortColumn('volume'),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('거래대금', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.lightText)),
                            SizedBox(width: 4),
                            _buildSortIcon('volume'),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _displayList.length,
              itemBuilder: (context, index) {
                final ticker = _displayList[index];
                final marketCode = ticker['market'];
                final koreanName = upbitMarkets.firstWhere(
                  (m) => m['market'] == marketCode,
                  orElse: () => {'korean_name': marketCode, 'english_name': ''},
                )['korean_name'];

                final symbol = marketCode.split('-')[1];
                final price = ticker['trade_price'] ?? 0;
                final changeRate = ticker['signed_change_rate'] ?? 0;
                final change = changeRate * 100;
                final changeColor = change >= 0 ? AppColors.riseRed : AppColors.fallBlue;
                final volume = ticker['acc_trade_price_24h'] ?? 0;

                // --- 김치 프리미엄 계산 추가 ---
                final binancePrice = ticker['binance_price'] ?? 0;
                final kimchiPriceDiff = price - binancePrice;
                final kimchiPremium = binancePrice > 0 ? (kimchiPriceDiff / binancePrice) * 100 : 0;

                final timeDiff = now - (ticker['updatedAt'] ?? 0);

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                    decoration: BoxDecoration(
                      color: timeDiff < 300
                        ? Colors.white.withOpacity(0.05)
                        : Colors.transparent,
                      borderRadius: BorderRadius.circular(2),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 7,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  koreanName,
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.lightText),
                                ),
                                Text(
                                  symbol,
                                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                                ),
                                // --- 김프 표시 ---
                                Text(
                                  '김프 ${kimchiPremium.toStringAsFixed(2)}% (${numberFormatter.format(kimchiPriceDiff.round())}원)',
                                  style: TextStyle(
                                    color: kimchiPriceDiff >= 0 ? AppColors.riseRed : AppColors.fallBlue,
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            price < 1
                              ? price.toStringAsFixed(7).replaceFirst(RegExp(r'\.?0+$'), '')
                              : price < 10
                                ? price.toStringAsFixed(5).replaceFirst(RegExp(r'\.?0+$'), '')
                                : numberFormatter.format(price),
                            textAlign: TextAlign.right,
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: changeColor),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                change >= 0 ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                                color: changeColor,
                                size: 20,
                              ),
                              Text(
                                '${change.abs().toStringAsFixed(2)}%',
                                style: TextStyle(color: changeColor, fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            '${volumeFormatter.format(volume / 1000000)}',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: AppColors.lightText, fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  String _formatVolume(num volume) {
    return numberFormatter.format(volume);
  }

  @override
  void dispose() {
    _channel?.sink.close(status.goingAway);
    super.dispose();
  }

}
