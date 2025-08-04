import 'package:freezed_annotation/freezed_annotation.dart';
part 'FavoriteCoinReq.freezed.dart';
part 'FavoriteCoinReq.g.dart';

@freezed
class FavoriteCoinReq with _$FavoriteCoinReq  {
  const factory FavoriteCoinReq ({
    required String email,
    required List<String> symbols,
    required bool alertEnabled,
  }) = _FavoriteCoinReq;
  factory FavoriteCoinReq.fromJson(Map<String, dynamic> json) => _$FavoriteCoinReqFromJson(json);
}
