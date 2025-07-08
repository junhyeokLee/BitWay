import 'dart:convert';
import 'dart:typed_data';
import 'package:bitway/util/text_style.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../util/color.dart';
import '../util/hangul_util.dart' as HangulUtils;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomeScreen2 extends StatefulWidget {
  const HomeScreen2({Key? key}) : super(key: key);

  @override
  State<HomeScreen2> createState() => _HomeScreenState();
}

enum SortType { volume, price, change }

class _HomeScreenState extends State<HomeScreen2> {
  List<dynamic> upbitMarkets = [];
  List<dynamic> _allMarketList = [];
  List<dynamic> _displayList = [];
  String _searchQuery = '';
  bool isLoading = true;
  String? _sortColumn;
  bool? _sortDirection; // true: ascending, false: descending, null: default

  Map<String, String> coinLogos = {};


  // Number formatters
  final numberFormatter = NumberFormat("#,##0.########");
  final volumeFormatter = NumberFormat("#,##0백만");

  @override
  void initState() {
    super.initState();
    fetchUpbitMarketData();
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
      await fetchCoinLogosFromCoinGecko();
    } catch (e) {
      debugPrint('Error fetching market data: $e');
    }
  }

  Future<void> fetchCoinLogosFromCoinGecko() async {
    try {
      final res = await http.get(Uri.parse('https://api.coingecko.com/api/v3/coins/markets?vs_currency=krw&order=market_cap_desc&per_page=250&page=1&sparkline=false'));
      if (res.statusCode == 200) {
        final List<dynamic> marketData = jsonDecode(res.body);
        Map<String, String> logoMap = {};
        for (var coin in marketData) {
          final symbol = (coin['symbol'] ?? '').toString().toUpperCase();
          final image = (coin['image'] ?? '').toString();
          if (symbol.isNotEmpty && image.isNotEmpty) {
            logoMap[symbol] = image;
          }
        }

        setState(() {
          coinLogos = logoMap;
        });
      }
    } catch (e) {
      debugPrint('Error fetching coin logos: $e');
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
              padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 8.0),
              child: Column(
                children: [
                  TextField(
                    style: const TextStyle(color: AppColors.lightText),
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
                  const Divider(
                    height: 1,
                    color: Colors.white70,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: Row(
                children: [
                  Expanded(
                    flex: 6,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text('코인명', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.lightText)),
                    ),
                  ),
                  Expanded(
                    flex: 4,
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

    // Optionally, keep animation if you want to animate on polling update.
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(2),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 5,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            // Container(
                            //   width: 16,
                            //   height: 10,
                            //   margin: const EdgeInsets.only(right: 4),
                            //   decoration: BoxDecoration(
                            //     color: changeRate >= 0.05
                            //         ? AppColors.riseRed.withOpacity(0.7)
                            //         : changeRate <= -0.05
                            //             ? AppColors.fallBlue.withOpacity(0.7)
                            //             : Colors.grey.withOpacity(0.5),
                            //     borderRadius: BorderRadius.circular(2),
                            //   ),
                            //   child: changeRate.abs() > 0.05
                            //       ? Icon(
                            //           changeRate > 0 ? Icons.trending_up : Icons.trending_down,
                            //           size: 10,
                            //           color: Colors.white,
                            //         )
                            //       : SizedBox.shrink(),
                            // ),
                            Padding(
                              padding: const EdgeInsets.only(right: 6.0),
                              child: CircleAvatar(
                                radius: 10,
                                backgroundColor: Colors.transparent,
                                child: coinLogos.containsKey(symbol.toUpperCase())
                                    ? ClipOval(
                                        child: CachedNetworkImage(
                                          imageUrl: coinLogos[symbol.toUpperCase()]!,
                                          width: 20,
                                          height: 20,
                                          fit: BoxFit.cover,
                                          placeholder: (context, url) => SizedBox.shrink(),
                                          errorWidget: (context, url, error) => Icon(Icons.error, size: 12),
                                        ),
                                      )
                                    : Container(
                                        width: 20,
                                        height: 20,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.grey[800],
                                        ),
                                        child: Text(
                                          symbol[0],
                                          style: TextStyle(color: Colors.white, fontSize: 10),
                                        ),
                                      ),
                              ),
                            ),
                            LayoutBuilder(
                              builder: (context, constraints) {
                                String displayText = koreanName.toString();
                                if (displayText.length > 8) {
                                  displayText = displayText.substring(0, 8) + '\n' + displayText.substring(8);
                                }
                                return Text(
                                  displayText,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: true,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.sp,
                                    color: AppColors.lightText,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                        Text(
                          symbol,
                          style: const TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Text(
                    price < 1
                      ? price.toStringAsFixed(7).replaceFirst(RegExp(r'\.?0+$'), '')
                      : price < 10
                        ? price.toStringAsFixed(5).replaceFirst(RegExp(r'\.?0+$'), '')
                        : numberFormatter.format(price),
                    textAlign: TextAlign.right,
                    style: TextStyle(fontWeight: FontWeight.normal, fontSize: 12.sp, color: changeColor),
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
                        style: TextStyle(color: changeColor, fontSize: 12.sp),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    '${volumeFormatter.format(volume / 1000000)}',
                    textAlign: TextAlign.center,
                    style: textStyle.text12R_lightText(),
                  ),
                ),
              ],
            ),
          ),
        ),
         Divider(
          height: 1,
          color: Colors.white.withOpacity(0.08),
        ),
      ],
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
    super.dispose();
  }

}
