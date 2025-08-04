// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FavoriteCoinRes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FavoriteCoinResImpl _$$FavoriteCoinResImplFromJson(
        Map<String, dynamic> json) =>
    _$FavoriteCoinResImpl(
      id: (json['id'] as num).toInt(),
      symbol: json['symbol'] as String,
      alertEnabled: json['alertEnabled'] as bool,
    );

Map<String, dynamic> _$$FavoriteCoinResImplToJson(
        _$FavoriteCoinResImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'symbol': instance.symbol,
      'alertEnabled': instance.alertEnabled,
    };
