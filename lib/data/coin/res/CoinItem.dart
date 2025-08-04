import 'package:freezed_annotation/freezed_annotation.dart';

part 'CoinItem.freezed.dart';
part 'CoinItem.g.dart';

@freezed
class CoinItem with _$CoinItem {
  const factory CoinItem({
    required String symbol,
    required String symbolName,
    required String imageUrl,
  }) = _CoinItem;

  factory CoinItem.fromJson(Map<String, dynamic> json) =>
      _$CoinItemFromJson(json);
}