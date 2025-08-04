// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FavoriteCoinReq.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FavoriteCoinReqImpl _$$FavoriteCoinReqImplFromJson(
        Map<String, dynamic> json) =>
    _$FavoriteCoinReqImpl(
      email: json['email'] as String,
      symbols:
          (json['symbols'] as List<dynamic>).map((e) => e as String).toList(),
      alertEnabled: json['alertEnabled'] as bool,
    );

Map<String, dynamic> _$$FavoriteCoinReqImplToJson(
        _$FavoriteCoinReqImpl instance) =>
    <String, dynamic>{
      'email': instance.email,
      'symbols': instance.symbols,
      'alertEnabled': instance.alertEnabled,
    };
