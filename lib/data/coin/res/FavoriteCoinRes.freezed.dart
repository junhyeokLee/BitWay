// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'FavoriteCoinRes.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

FavoriteCoinRes _$FavoriteCoinResFromJson(Map<String, dynamic> json) {
  return _FavoriteCoinRes.fromJson(json);
}

/// @nodoc
mixin _$FavoriteCoinRes {
  int get id => throw _privateConstructorUsedError;
  String get symbol => throw _privateConstructorUsedError;
  bool get alertEnabled => throw _privateConstructorUsedError;

  /// Serializes this FavoriteCoinRes to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FavoriteCoinRes
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FavoriteCoinResCopyWith<FavoriteCoinRes> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FavoriteCoinResCopyWith<$Res> {
  factory $FavoriteCoinResCopyWith(
          FavoriteCoinRes value, $Res Function(FavoriteCoinRes) then) =
      _$FavoriteCoinResCopyWithImpl<$Res, FavoriteCoinRes>;
  @useResult
  $Res call({int id, String symbol, bool alertEnabled});
}

/// @nodoc
class _$FavoriteCoinResCopyWithImpl<$Res, $Val extends FavoriteCoinRes>
    implements $FavoriteCoinResCopyWith<$Res> {
  _$FavoriteCoinResCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FavoriteCoinRes
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? symbol = null,
    Object? alertEnabled = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      symbol: null == symbol
          ? _value.symbol
          : symbol // ignore: cast_nullable_to_non_nullable
              as String,
      alertEnabled: null == alertEnabled
          ? _value.alertEnabled
          : alertEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FavoriteCoinResImplCopyWith<$Res>
    implements $FavoriteCoinResCopyWith<$Res> {
  factory _$$FavoriteCoinResImplCopyWith(_$FavoriteCoinResImpl value,
          $Res Function(_$FavoriteCoinResImpl) then) =
      __$$FavoriteCoinResImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String symbol, bool alertEnabled});
}

/// @nodoc
class __$$FavoriteCoinResImplCopyWithImpl<$Res>
    extends _$FavoriteCoinResCopyWithImpl<$Res, _$FavoriteCoinResImpl>
    implements _$$FavoriteCoinResImplCopyWith<$Res> {
  __$$FavoriteCoinResImplCopyWithImpl(
      _$FavoriteCoinResImpl _value, $Res Function(_$FavoriteCoinResImpl) _then)
      : super(_value, _then);

  /// Create a copy of FavoriteCoinRes
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? symbol = null,
    Object? alertEnabled = null,
  }) {
    return _then(_$FavoriteCoinResImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      symbol: null == symbol
          ? _value.symbol
          : symbol // ignore: cast_nullable_to_non_nullable
              as String,
      alertEnabled: null == alertEnabled
          ? _value.alertEnabled
          : alertEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FavoriteCoinResImpl implements _FavoriteCoinRes {
  const _$FavoriteCoinResImpl(
      {required this.id, required this.symbol, required this.alertEnabled});

  factory _$FavoriteCoinResImpl.fromJson(Map<String, dynamic> json) =>
      _$$FavoriteCoinResImplFromJson(json);

  @override
  final int id;
  @override
  final String symbol;
  @override
  final bool alertEnabled;

  @override
  String toString() {
    return 'FavoriteCoinRes(id: $id, symbol: $symbol, alertEnabled: $alertEnabled)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FavoriteCoinResImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.symbol, symbol) || other.symbol == symbol) &&
            (identical(other.alertEnabled, alertEnabled) ||
                other.alertEnabled == alertEnabled));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, symbol, alertEnabled);

  /// Create a copy of FavoriteCoinRes
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FavoriteCoinResImplCopyWith<_$FavoriteCoinResImpl> get copyWith =>
      __$$FavoriteCoinResImplCopyWithImpl<_$FavoriteCoinResImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FavoriteCoinResImplToJson(
      this,
    );
  }
}

abstract class _FavoriteCoinRes implements FavoriteCoinRes {
  const factory _FavoriteCoinRes(
      {required final int id,
      required final String symbol,
      required final bool alertEnabled}) = _$FavoriteCoinResImpl;

  factory _FavoriteCoinRes.fromJson(Map<String, dynamic> json) =
      _$FavoriteCoinResImpl.fromJson;

  @override
  int get id;
  @override
  String get symbol;
  @override
  bool get alertEnabled;

  /// Create a copy of FavoriteCoinRes
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FavoriteCoinResImplCopyWith<_$FavoriteCoinResImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
