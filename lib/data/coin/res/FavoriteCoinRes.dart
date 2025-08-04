import 'package:freezed_annotation/freezed_annotation.dart';
part 'FavoriteCoinRes.freezed.dart';
part 'FavoriteCoinRes.g.dart';

@freezed
class FavoriteCoinRes with _$FavoriteCoinRes  {
  const factory FavoriteCoinRes ({
    required int id,
    required String symbol,
    required bool alertEnabled,
  }) = _FavoriteCoinRes;

  factory FavoriteCoinRes.fromJson(Map<String, dynamic> json) => _$FavoriteCoinResFromJson(json);
}
