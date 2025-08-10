import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/coin/res/PremiumItem.dart';
import '../../provider/providers.dart';
import '../../state/PremiumState.dart';

class PremiumListScreen extends ConsumerStatefulWidget {
  const PremiumListScreen({super.key});

  @override
  ConsumerState<PremiumListScreen> createState() => _PremiumListScreenState();
}

class _PremiumListScreenState extends ConsumerState<PremiumListScreen> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(premiumViewModelProvider) as PremiumState;
    final compact = ref.watch(appConfigProvider).compact;

    return Scaffold(
      appBar: AppBar(
        title: const Text('프리미엄 리스트'),
        actions: [
          // IconButton(
          //   tooltip: '컴팩트 토글(Provider 예시)',
          //   onPressed: () => ref.read(appConfigProvider.notifier).toggleCompact(),
          //   icon: const Icon(Icons.view_agenda),
          // ),
          IconButton(
            tooltip: '새로고침',
            onPressed: () => ref.read(premiumViewModelProvider.notifier).load(),
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: Builder(
        builder: (_) {
          if (state.isLoading && state.items.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.error != null) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('에러: ${state.error}', textAlign: TextAlign.center),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () => ref.read(premiumViewModelProvider.notifier).load(),
                    child: const Text('다시 시도'),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () => ref.read(premiumViewModelProvider.notifier).load(),
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: state.items.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (_, idx) {
                final item = state.items[idx];
                return _PremiumTile(
                  item: item,
                  compact: compact,
                  onFav: () => ref.read(premiumViewModelProvider.notifier).toggleFavorite(item.symbol),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class _LabelChip extends StatelessWidget {
  const _LabelChip({
    super.key,
    required this.title,
    required this.value,
    required this.color,
  });

  final String title;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        '$title $value',
        style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.w500),
      ),
    );
  }
}

class _PremiumTile extends StatelessWidget {
  const _PremiumTile({
    required this.item,
    required this.onFav,
    required this.compact,
  });

  final PremiumItem item;
  final VoidCallback onFav;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    // Safely coerce values that might be String into num
    final premiumRate = _n(item.premiumRate);
    final changePct = _n(item.priceChangePercent24h);
    final domesticPrice = _n(item.domesticPrice);
    final overseasPrice = _n(item.overseasPrice);
    final overseasPriceInKrw = _n(item.overseasPriceInKrw);
    final priceGap = _n(item.priceGap);

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      dense: compact,
      minVerticalPadding: compact ? 6 : 8,
      leading: CircleAvatar(
        radius: 22,
        backgroundColor: Colors.white,
        child: ClipOval(
          child: CachedNetworkImage(
            imageUrl: (item.imageUrl?.isNotEmpty ?? false) ? item.imageUrl! : '',
            width: 44,
            height: 44,
            fit: BoxFit.cover,
            placeholder: (_, __) => Container(color: Colors.grey.shade200, width: 44, height: 44),
            errorWidget: (_, __, ___) => Icon(Icons.image_not_supported, size: 24, color: Colors.grey.shade400),
          ),
        ),
      ),
      title: Text(
        '${item.symbol} (${item.symbolName ?? ''})',
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: compact
          ? null
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${_k(domesticPrice)}'),
                // Text('${(item.overseasExchange ?? '').toUpperCase()} ${_k(overseasPriceInKrw)}'),
                const SizedBox(height: 6),
                Row(
                  children: [
                    _LabelChip(
                      title: '김프',
                      value: (item.premiumRate == null) ? '--%' : '${premiumRate.toStringAsFixed(2)}%',
                      color: premiumRate >= 0 ? Colors.red : Colors.blue,
                    ),
                    // const SizedBox(width: 6),
                    // _LabelChip(
                    //   title: '가격차',
                    //   value: '${_k(priceGap)}',
                    //   color: Colors.grey.shade700,
                    // ),
                    const SizedBox(width: 6),
                    _LabelChip(
                      title: '24h',
                      value: '${changePct.toStringAsFixed(2)}%',
                      color: changePct >= 0 ? Colors.red : Colors.blue,
                    ),
                  ],
                ),
              ],
            ),
      trailing: IconButton(
        icon: Icon(item.favorite ? Icons.star : Icons.star_border, color: Colors.amber),
        onPressed: onFav,
      ),
    );
  }
}

String _k(num n) {
  if (n.abs() >= 1e12) return '${(n / 1e12).toStringAsFixed(2)}T';
  if (n.abs() >= 1e9) return '${(n / 1e9).toStringAsFixed(2)}B';
  if (n.abs() >= 1e8) return '${(n / 1e8).toStringAsFixed(1)}억';
  if (n.abs() >= 1e4) return '${(n / 1e4).toStringAsFixed(1)}만';
  if (n.abs() >= 1e3) return '${(n / 1e3).toStringAsFixed(1)}K';
  return n.toStringAsFixed(n.truncateToDouble() == n ? 0 : 2);
}

num _n(dynamic v) {
  if (v is num) return v;
  if (v == null) return 0;
  if (v is String) {
    final cleaned = v.replaceAll(',', '').trim();
    final parsed = num.tryParse(cleaned);
    if (parsed != null) return parsed;
  }
  // As a last resort, try parsing the toString()
  final parsed = num.tryParse(v.toString());
  return parsed ?? 0;
}