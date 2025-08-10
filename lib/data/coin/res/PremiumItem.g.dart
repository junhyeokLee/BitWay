// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PremiumItem.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PremiumItemImpl _$$PremiumItemImplFromJson(Map<String, dynamic> json) =>
    _$PremiumItemImpl(
      symbol: json['symbol'] as String,
      symbolName: json['symbolName'] as String?,
      domesticExchange: json['domesticExchange'] as String,
      domesticPrice: json['domesticPrice'] as num,
      overseasExchange: json['overseasExchange'] as String,
      overseasPrice: json['overseasPrice'] as num,
      exchangeRate: json['exchangeRate'] as num,
      premiumRate: json['premiumRate'] as num,
      overseasPriceInKrw: json['overseasPriceInKrw'] as num,
      priceGap: json['priceGap'] as num,
      priceChangePercent24h: json['priceChangePercent24h'] as num,
      volume24h: json['volume24h'] as num,
      volatilityIndex: json['volatilityIndex'] as num,
      imageUrl: json['imageUrl'] as String?,
      sortPriority: (json['sortPriority'] as num?)?.toInt(),
      favorite: json['favorite'] as bool? ?? false,
    );

Map<String, dynamic> _$$PremiumItemImplToJson(_$PremiumItemImpl instance) =>
    <String, dynamic>{
      'symbol': instance.symbol,
      'symbolName': instance.symbolName,
      'domesticExchange': instance.domesticExchange,
      'domesticPrice': instance.domesticPrice,
      'overseasExchange': instance.overseasExchange,
      'overseasPrice': instance.overseasPrice,
      'exchangeRate': instance.exchangeRate,
      'premiumRate': instance.premiumRate,
      'overseasPriceInKrw': instance.overseasPriceInKrw,
      'priceGap': instance.priceGap,
      'priceChangePercent24h': instance.priceChangePercent24h,
      'volume24h': instance.volume24h,
      'volatilityIndex': instance.volatilityIndex,
      'imageUrl': instance.imageUrl,
      'sortPriority': instance.sortPriority,
      'favorite': instance.favorite,
    };
