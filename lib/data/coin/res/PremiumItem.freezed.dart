// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'PremiumItem.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PremiumItem _$PremiumItemFromJson(Map<String, dynamic> json) {
  return _PremiumItem.fromJson(json);
}

/// @nodoc
mixin _$PremiumItem {
  String get symbol => throw _privateConstructorUsedError;
  String? get symbolName => throw _privateConstructorUsedError;
  String get domesticExchange => throw _privateConstructorUsedError;
  num get domesticPrice => throw _privateConstructorUsedError;
  String get overseasExchange => throw _privateConstructorUsedError;
  num get overseasPrice => throw _privateConstructorUsedError;
  num get exchangeRate => throw _privateConstructorUsedError;
  num get premiumRate => throw _privateConstructorUsedError; // (여기서는 kimp로 간주)
  num get overseasPriceInKrw => throw _privateConstructorUsedError;
  num get priceGap => throw _privateConstructorUsedError;
  num get priceChangePercent24h => throw _privateConstructorUsedError;
  num get volume24h => throw _privateConstructorUsedError;
  num get volatilityIndex => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;
  int? get sortPriority => throw _privateConstructorUsedError;
  bool get favorite => throw _privateConstructorUsedError;

  /// Serializes this PremiumItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PremiumItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PremiumItemCopyWith<PremiumItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PremiumItemCopyWith<$Res> {
  factory $PremiumItemCopyWith(
          PremiumItem value, $Res Function(PremiumItem) then) =
      _$PremiumItemCopyWithImpl<$Res, PremiumItem>;
  @useResult
  $Res call(
      {String symbol,
      String? symbolName,
      String domesticExchange,
      num domesticPrice,
      String overseasExchange,
      num overseasPrice,
      num exchangeRate,
      num premiumRate,
      num overseasPriceInKrw,
      num priceGap,
      num priceChangePercent24h,
      num volume24h,
      num volatilityIndex,
      String? imageUrl,
      int? sortPriority,
      bool favorite});
}

/// @nodoc
class _$PremiumItemCopyWithImpl<$Res, $Val extends PremiumItem>
    implements $PremiumItemCopyWith<$Res> {
  _$PremiumItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PremiumItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? symbol = null,
    Object? symbolName = freezed,
    Object? domesticExchange = null,
    Object? domesticPrice = null,
    Object? overseasExchange = null,
    Object? overseasPrice = null,
    Object? exchangeRate = null,
    Object? premiumRate = null,
    Object? overseasPriceInKrw = null,
    Object? priceGap = null,
    Object? priceChangePercent24h = null,
    Object? volume24h = null,
    Object? volatilityIndex = null,
    Object? imageUrl = freezed,
    Object? sortPriority = freezed,
    Object? favorite = null,
  }) {
    return _then(_value.copyWith(
      symbol: null == symbol
          ? _value.symbol
          : symbol // ignore: cast_nullable_to_non_nullable
              as String,
      symbolName: freezed == symbolName
          ? _value.symbolName
          : symbolName // ignore: cast_nullable_to_non_nullable
              as String?,
      domesticExchange: null == domesticExchange
          ? _value.domesticExchange
          : domesticExchange // ignore: cast_nullable_to_non_nullable
              as String,
      domesticPrice: null == domesticPrice
          ? _value.domesticPrice
          : domesticPrice // ignore: cast_nullable_to_non_nullable
              as num,
      overseasExchange: null == overseasExchange
          ? _value.overseasExchange
          : overseasExchange // ignore: cast_nullable_to_non_nullable
              as String,
      overseasPrice: null == overseasPrice
          ? _value.overseasPrice
          : overseasPrice // ignore: cast_nullable_to_non_nullable
              as num,
      exchangeRate: null == exchangeRate
          ? _value.exchangeRate
          : exchangeRate // ignore: cast_nullable_to_non_nullable
              as num,
      premiumRate: null == premiumRate
          ? _value.premiumRate
          : premiumRate // ignore: cast_nullable_to_non_nullable
              as num,
      overseasPriceInKrw: null == overseasPriceInKrw
          ? _value.overseasPriceInKrw
          : overseasPriceInKrw // ignore: cast_nullable_to_non_nullable
              as num,
      priceGap: null == priceGap
          ? _value.priceGap
          : priceGap // ignore: cast_nullable_to_non_nullable
              as num,
      priceChangePercent24h: null == priceChangePercent24h
          ? _value.priceChangePercent24h
          : priceChangePercent24h // ignore: cast_nullable_to_non_nullable
              as num,
      volume24h: null == volume24h
          ? _value.volume24h
          : volume24h // ignore: cast_nullable_to_non_nullable
              as num,
      volatilityIndex: null == volatilityIndex
          ? _value.volatilityIndex
          : volatilityIndex // ignore: cast_nullable_to_non_nullable
              as num,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      sortPriority: freezed == sortPriority
          ? _value.sortPriority
          : sortPriority // ignore: cast_nullable_to_non_nullable
              as int?,
      favorite: null == favorite
          ? _value.favorite
          : favorite // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PremiumItemImplCopyWith<$Res>
    implements $PremiumItemCopyWith<$Res> {
  factory _$$PremiumItemImplCopyWith(
          _$PremiumItemImpl value, $Res Function(_$PremiumItemImpl) then) =
      __$$PremiumItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String symbol,
      String? symbolName,
      String domesticExchange,
      num domesticPrice,
      String overseasExchange,
      num overseasPrice,
      num exchangeRate,
      num premiumRate,
      num overseasPriceInKrw,
      num priceGap,
      num priceChangePercent24h,
      num volume24h,
      num volatilityIndex,
      String? imageUrl,
      int? sortPriority,
      bool favorite});
}

/// @nodoc
class __$$PremiumItemImplCopyWithImpl<$Res>
    extends _$PremiumItemCopyWithImpl<$Res, _$PremiumItemImpl>
    implements _$$PremiumItemImplCopyWith<$Res> {
  __$$PremiumItemImplCopyWithImpl(
      _$PremiumItemImpl _value, $Res Function(_$PremiumItemImpl) _then)
      : super(_value, _then);

  /// Create a copy of PremiumItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? symbol = null,
    Object? symbolName = freezed,
    Object? domesticExchange = null,
    Object? domesticPrice = null,
    Object? overseasExchange = null,
    Object? overseasPrice = null,
    Object? exchangeRate = null,
    Object? premiumRate = null,
    Object? overseasPriceInKrw = null,
    Object? priceGap = null,
    Object? priceChangePercent24h = null,
    Object? volume24h = null,
    Object? volatilityIndex = null,
    Object? imageUrl = freezed,
    Object? sortPriority = freezed,
    Object? favorite = null,
  }) {
    return _then(_$PremiumItemImpl(
      symbol: null == symbol
          ? _value.symbol
          : symbol // ignore: cast_nullable_to_non_nullable
              as String,
      symbolName: freezed == symbolName
          ? _value.symbolName
          : symbolName // ignore: cast_nullable_to_non_nullable
              as String?,
      domesticExchange: null == domesticExchange
          ? _value.domesticExchange
          : domesticExchange // ignore: cast_nullable_to_non_nullable
              as String,
      domesticPrice: null == domesticPrice
          ? _value.domesticPrice
          : domesticPrice // ignore: cast_nullable_to_non_nullable
              as num,
      overseasExchange: null == overseasExchange
          ? _value.overseasExchange
          : overseasExchange // ignore: cast_nullable_to_non_nullable
              as String,
      overseasPrice: null == overseasPrice
          ? _value.overseasPrice
          : overseasPrice // ignore: cast_nullable_to_non_nullable
              as num,
      exchangeRate: null == exchangeRate
          ? _value.exchangeRate
          : exchangeRate // ignore: cast_nullable_to_non_nullable
              as num,
      premiumRate: null == premiumRate
          ? _value.premiumRate
          : premiumRate // ignore: cast_nullable_to_non_nullable
              as num,
      overseasPriceInKrw: null == overseasPriceInKrw
          ? _value.overseasPriceInKrw
          : overseasPriceInKrw // ignore: cast_nullable_to_non_nullable
              as num,
      priceGap: null == priceGap
          ? _value.priceGap
          : priceGap // ignore: cast_nullable_to_non_nullable
              as num,
      priceChangePercent24h: null == priceChangePercent24h
          ? _value.priceChangePercent24h
          : priceChangePercent24h // ignore: cast_nullable_to_non_nullable
              as num,
      volume24h: null == volume24h
          ? _value.volume24h
          : volume24h // ignore: cast_nullable_to_non_nullable
              as num,
      volatilityIndex: null == volatilityIndex
          ? _value.volatilityIndex
          : volatilityIndex // ignore: cast_nullable_to_non_nullable
              as num,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      sortPriority: freezed == sortPriority
          ? _value.sortPriority
          : sortPriority // ignore: cast_nullable_to_non_nullable
              as int?,
      favorite: null == favorite
          ? _value.favorite
          : favorite // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PremiumItemImpl implements _PremiumItem {
  const _$PremiumItemImpl(
      {required this.symbol,
      this.symbolName,
      required this.domesticExchange,
      required this.domesticPrice,
      required this.overseasExchange,
      required this.overseasPrice,
      required this.exchangeRate,
      required this.premiumRate,
      required this.overseasPriceInKrw,
      required this.priceGap,
      required this.priceChangePercent24h,
      required this.volume24h,
      required this.volatilityIndex,
      this.imageUrl,
      this.sortPriority,
      this.favorite = false});

  factory _$PremiumItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$PremiumItemImplFromJson(json);

  @override
  final String symbol;
  @override
  final String? symbolName;
  @override
  final String domesticExchange;
  @override
  final num domesticPrice;
  @override
  final String overseasExchange;
  @override
  final num overseasPrice;
  @override
  final num exchangeRate;
  @override
  final num premiumRate;
// (여기서는 kimp로 간주)
  @override
  final num overseasPriceInKrw;
  @override
  final num priceGap;
  @override
  final num priceChangePercent24h;
  @override
  final num volume24h;
  @override
  final num volatilityIndex;
  @override
  final String? imageUrl;
  @override
  final int? sortPriority;
  @override
  @JsonKey()
  final bool favorite;

  @override
  String toString() {
    return 'PremiumItem(symbol: $symbol, symbolName: $symbolName, domesticExchange: $domesticExchange, domesticPrice: $domesticPrice, overseasExchange: $overseasExchange, overseasPrice: $overseasPrice, exchangeRate: $exchangeRate, premiumRate: $premiumRate, overseasPriceInKrw: $overseasPriceInKrw, priceGap: $priceGap, priceChangePercent24h: $priceChangePercent24h, volume24h: $volume24h, volatilityIndex: $volatilityIndex, imageUrl: $imageUrl, sortPriority: $sortPriority, favorite: $favorite)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PremiumItemImpl &&
            (identical(other.symbol, symbol) || other.symbol == symbol) &&
            (identical(other.symbolName, symbolName) ||
                other.symbolName == symbolName) &&
            (identical(other.domesticExchange, domesticExchange) ||
                other.domesticExchange == domesticExchange) &&
            (identical(other.domesticPrice, domesticPrice) ||
                other.domesticPrice == domesticPrice) &&
            (identical(other.overseasExchange, overseasExchange) ||
                other.overseasExchange == overseasExchange) &&
            (identical(other.overseasPrice, overseasPrice) ||
                other.overseasPrice == overseasPrice) &&
            (identical(other.exchangeRate, exchangeRate) ||
                other.exchangeRate == exchangeRate) &&
            (identical(other.premiumRate, premiumRate) ||
                other.premiumRate == premiumRate) &&
            (identical(other.overseasPriceInKrw, overseasPriceInKrw) ||
                other.overseasPriceInKrw == overseasPriceInKrw) &&
            (identical(other.priceGap, priceGap) ||
                other.priceGap == priceGap) &&
            (identical(other.priceChangePercent24h, priceChangePercent24h) ||
                other.priceChangePercent24h == priceChangePercent24h) &&
            (identical(other.volume24h, volume24h) ||
                other.volume24h == volume24h) &&
            (identical(other.volatilityIndex, volatilityIndex) ||
                other.volatilityIndex == volatilityIndex) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.sortPriority, sortPriority) ||
                other.sortPriority == sortPriority) &&
            (identical(other.favorite, favorite) ||
                other.favorite == favorite));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      symbol,
      symbolName,
      domesticExchange,
      domesticPrice,
      overseasExchange,
      overseasPrice,
      exchangeRate,
      premiumRate,
      overseasPriceInKrw,
      priceGap,
      priceChangePercent24h,
      volume24h,
      volatilityIndex,
      imageUrl,
      sortPriority,
      favorite);

  /// Create a copy of PremiumItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PremiumItemImplCopyWith<_$PremiumItemImpl> get copyWith =>
      __$$PremiumItemImplCopyWithImpl<_$PremiumItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PremiumItemImplToJson(
      this,
    );
  }
}

abstract class _PremiumItem implements PremiumItem {
  const factory _PremiumItem(
      {required final String symbol,
      final String? symbolName,
      required final String domesticExchange,
      required final num domesticPrice,
      required final String overseasExchange,
      required final num overseasPrice,
      required final num exchangeRate,
      required final num premiumRate,
      required final num overseasPriceInKrw,
      required final num priceGap,
      required final num priceChangePercent24h,
      required final num volume24h,
      required final num volatilityIndex,
      final String? imageUrl,
      final int? sortPriority,
      final bool favorite}) = _$PremiumItemImpl;

  factory _PremiumItem.fromJson(Map<String, dynamic> json) =
      _$PremiumItemImpl.fromJson;

  @override
  String get symbol;
  @override
  String? get symbolName;
  @override
  String get domesticExchange;
  @override
  num get domesticPrice;
  @override
  String get overseasExchange;
  @override
  num get overseasPrice;
  @override
  num get exchangeRate;
  @override
  num get premiumRate; // (여기서는 kimp로 간주)
  @override
  num get overseasPriceInKrw;
  @override
  num get priceGap;
  @override
  num get priceChangePercent24h;
  @override
  num get volume24h;
  @override
  num get volatilityIndex;
  @override
  String? get imageUrl;
  @override
  int? get sortPriority;
  @override
  bool get favorite;

  /// Create a copy of PremiumItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PremiumItemImplCopyWith<_$PremiumItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
