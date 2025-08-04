import 'package:freezed_annotation/freezed_annotation.dart';

part 'User.freezed.dart';
part 'User.g.dart'; // ← JSON 대응용

@freezed
class User with _$User {
  const factory User({
    required int id,
    required String email,
    required String nickname,
    String? phoneNumber,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) =>
      _$UserFromJson(json);
}