// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'CoinItem.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CoinItem _$CoinItemFromJson(Map<String, dynamic> json) {
  return _CoinItem.fromJson(json);
}

/// @nodoc
mixin _$CoinItem {
  String get symbol => throw _privateConstructorUsedError;
  String get symbolName => throw _privateConstructorUsedError;
  String get imageUrl => throw _privateConstructorUsedError;

  /// Serializes this CoinItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CoinItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CoinItemCopyWith<CoinItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CoinItemCopyWith<$Res> {
  factory $CoinItemCopyWith(CoinItem value, $Res Function(CoinItem) then) =
      _$CoinItemCopyWithImpl<$Res, CoinItem>;
  @useResult
  $Res call({String symbol, String symbolName, String imageUrl});
}

/// @nodoc
class _$CoinItemCopyWithImpl<$Res, $Val extends CoinItem>
    implements $CoinItemCopyWith<$Res> {
  _$CoinItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CoinItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? symbol = null,
    Object? symbolName = null,
    Object? imageUrl = null,
  }) {
    return _then(_value.copyWith(
      symbol: null == symbol
          ? _value.symbol
          : symbol // ignore: cast_nullable_to_non_nullable
              as String,
      symbolName: null == symbolName
          ? _value.symbolName
          : symbolName // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CoinItemImplCopyWith<$Res>
    implements $CoinItemCopyWith<$Res> {
  factory _$$CoinItemImplCopyWith(
          _$CoinItemImpl value, $Res Function(_$CoinItemImpl) then) =
      __$$CoinItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String symbol, String symbolName, String imageUrl});
}

/// @nodoc
class __$$CoinItemImplCopyWithImpl<$Res>
    extends _$CoinItemCopyWithImpl<$Res, _$CoinItemImpl>
    implements _$$CoinItemImplCopyWith<$Res> {
  __$$CoinItemImplCopyWithImpl(
      _$CoinItemImpl _value, $Res Function(_$CoinItemImpl) _then)
      : super(_value, _then);

  /// Create a copy of CoinItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? symbol = null,
    Object? symbolName = null,
    Object? imageUrl = null,
  }) {
    return _then(_$CoinItemImpl(
      symbol: null == symbol
          ? _value.symbol
          : symbol // ignore: cast_nullable_to_non_nullable
              as String,
      symbolName: null == symbolName
          ? _value.symbolName
          : symbolName // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CoinItemImpl implements _CoinItem {
  const _$CoinItemImpl(
      {required this.symbol, required this.symbolName, required this.imageUrl});

  factory _$CoinItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$CoinItemImplFromJson(json);

  @override
  final String symbol;
  @override
  final String symbolName;
  @override
  final String imageUrl;

  @override
  String toString() {
    return 'CoinItem(symbol: $symbol, symbolName: $symbolName, imageUrl: $imageUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CoinItemImpl &&
            (identical(other.symbol, symbol) || other.symbol == symbol) &&
            (identical(other.symbolName, symbolName) ||
                other.symbolName == symbolName) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, symbol, symbolName, imageUrl);

  /// Create a copy of CoinItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CoinItemImplCopyWith<_$CoinItemImpl> get copyWith =>
      __$$CoinItemImplCopyWithImpl<_$CoinItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CoinItemImplToJson(
      this,
    );
  }
}

abstract class _CoinItem implements CoinItem {
  const factory _CoinItem(
      {required final String symbol,
      required final String symbolName,
      required final String imageUrl}) = _$CoinItemImpl;

  factory _CoinItem.fromJson(Map<String, dynamic> json) =
      _$CoinItemImpl.fromJson;

  @override
  String get symbol;
  @override
  String get symbolName;
  @override
  String get imageUrl;

  /// Create a copy of CoinItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CoinItemImplCopyWith<_$CoinItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
