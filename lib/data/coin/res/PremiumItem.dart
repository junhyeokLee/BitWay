// lib/feature/premium/data/premium_model.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'PremiumItem.freezed.dart';
part 'PremiumItem.g.dart';

@freezed
class PremiumItem with _$PremiumItem {
  const factory PremiumItem({
    required String symbol,
    String? symbolName,
    required String domesticExchange,
    required num domesticPrice,
    required String overseasExchange,
    required num overseasPrice,
    required num exchangeRate,
    required num premiumRate,          // (여기서는 kimp로 간주)
    required num overseasPriceInKrw,
    required num priceGap,
    required num priceChangePercent24h,
    required num volume24h,
    required num volatilityIndex,
    String? imageUrl,
    int? sortPriority,
    @Default(false) bool favorite,
  }) = _PremiumItem;

  factory PremiumItem.fromJson(Map<String, dynamic> json) {
    final sortPriorityNum = _asNum(json['sortPriority']);
    return PremiumItem(
      symbol: json['symbol'] as String? ?? '',
      symbolName: (json['symbolName'] as String?) ?? '',
      domesticExchange: json['domesticExchange'] as String? ?? '',
      domesticPrice: _asNum(json['domesticPrice']),
      overseasExchange: json['overseasExchange'] as String? ?? '',
      overseasPrice: _asNum(json['overseasPrice']),
      exchangeRate: _asNum(json['exchangeRate']),
      premiumRate: _asNum(json['premiumRate']),
      overseasPriceInKrw: _asNum(json['overseasPriceInKrw']),
      priceGap: _asNum(json['priceGap']),
      priceChangePercent24h: _asNum(json['priceChangePercent24h']),
      volume24h: _asNum(json['volume24h']),
      volatilityIndex: _asNum(json['volatilityIndex']),
      imageUrl: (json['imageUrl'] as String?) ?? '',
      sortPriority: sortPriorityNum != 0 ? sortPriorityNum.toInt() : null,
      favorite: json['favorite'] as bool? ?? false,
    );
  }
}

// 정렬 옵션
enum PremiumSort {
  priceDesc('price_desc'),
  price('price'),
  kimpDesc('kimp_desc'),
  kimp('kimp');

  final String query;
  const PremiumSort(this.query);
}
// Helper function for safe num parsing
num _asNum(dynamic v, {num fallback = 0}) {
  if (v is num) return v;
  if (v == null) return fallback;
  if (v is String) {
    final cleaned = v.replaceAll(',', '').trim();
    final parsed = num.tryParse(cleaned);
    if (parsed != null) return parsed;
  }
  // As a last resort, try parsing the toString()
  final parsed = num.tryParse(v.toString());
  return parsed ?? fallback;
}