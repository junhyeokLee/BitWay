// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'FavoriteCoinReq.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

FavoriteCoinReq _$FavoriteCoinReqFromJson(Map<String, dynamic> json) {
  return _FavoriteCoinReq.fromJson(json);
}

/// @nodoc
mixin _$FavoriteCoinReq {
  String get email => throw _privateConstructorUsedError;
  List<String> get symbols => throw _privateConstructorUsedError;
  bool get alertEnabled => throw _privateConstructorUsedError;

  /// Serializes this FavoriteCoinReq to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FavoriteCoinReq
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FavoriteCoinReqCopyWith<FavoriteCoinReq> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FavoriteCoinReqCopyWith<$Res> {
  factory $FavoriteCoinReqCopyWith(
          FavoriteCoinReq value, $Res Function(FavoriteCoinReq) then) =
      _$FavoriteCoinReqCopyWithImpl<$Res, FavoriteCoinReq>;
  @useResult
  $Res call({String email, List<String> symbols, bool alertEnabled});
}

/// @nodoc
class _$FavoriteCoinReqCopyWithImpl<$Res, $Val extends FavoriteCoinReq>
    implements $FavoriteCoinReqCopyWith<$Res> {
  _$FavoriteCoinReqCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FavoriteCoinReq
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? symbols = null,
    Object? alertEnabled = null,
  }) {
    return _then(_value.copyWith(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      symbols: null == symbols
          ? _value.symbols
          : symbols // ignore: cast_nullable_to_non_nullable
              as List<String>,
      alertEnabled: null == alertEnabled
          ? _value.alertEnabled
          : alertEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FavoriteCoinReqImplCopyWith<$Res>
    implements $FavoriteCoinReqCopyWith<$Res> {
  factory _$$FavoriteCoinReqImplCopyWith(_$FavoriteCoinReqImpl value,
          $Res Function(_$FavoriteCoinReqImpl) then) =
      __$$FavoriteCoinReqImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String email, List<String> symbols, bool alertEnabled});
}

/// @nodoc
class __$$FavoriteCoinReqImplCopyWithImpl<$Res>
    extends _$FavoriteCoinReqCopyWithImpl<$Res, _$FavoriteCoinReqImpl>
    implements _$$FavoriteCoinReqImplCopyWith<$Res> {
  __$$FavoriteCoinReqImplCopyWithImpl(
      _$FavoriteCoinReqImpl _value, $Res Function(_$FavoriteCoinReqImpl) _then)
      : super(_value, _then);

  /// Create a copy of FavoriteCoinReq
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? symbols = null,
    Object? alertEnabled = null,
  }) {
    return _then(_$FavoriteCoinReqImpl(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      symbols: null == symbols
          ? _value._symbols
          : symbols // ignore: cast_nullable_to_non_nullable
              as List<String>,
      alertEnabled: null == alertEnabled
          ? _value.alertEnabled
          : alertEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FavoriteCoinReqImpl implements _FavoriteCoinReq {
  const _$FavoriteCoinReqImpl(
      {required this.email,
      required final List<String> symbols,
      required this.alertEnabled})
      : _symbols = symbols;

  factory _$FavoriteCoinReqImpl.fromJson(Map<String, dynamic> json) =>
      _$$FavoriteCoinReqImplFromJson(json);

  @override
  final String email;
  final List<String> _symbols;
  @override
  List<String> get symbols {
    if (_symbols is EqualUnmodifiableListView) return _symbols;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_symbols);
  }

  @override
  final bool alertEnabled;

  @override
  String toString() {
    return 'FavoriteCoinReq(email: $email, symbols: $symbols, alertEnabled: $alertEnabled)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FavoriteCoinReqImpl &&
            (identical(other.email, email) || other.email == email) &&
            const DeepCollectionEquality().equals(other._symbols, _symbols) &&
            (identical(other.alertEnabled, alertEnabled) ||
                other.alertEnabled == alertEnabled));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, email,
      const DeepCollectionEquality().hash(_symbols), alertEnabled);

  /// Create a copy of FavoriteCoinReq
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FavoriteCoinReqImplCopyWith<_$FavoriteCoinReqImpl> get copyWith =>
      __$$FavoriteCoinReqImplCopyWithImpl<_$FavoriteCoinReqImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FavoriteCoinReqImplToJson(
      this,
    );
  }
}

abstract class _FavoriteCoinReq implements FavoriteCoinReq {
  const factory _FavoriteCoinReq(
      {required final String email,
      required final List<String> symbols,
      required final bool alertEnabled}) = _$FavoriteCoinReqImpl;

  factory _FavoriteCoinReq.fromJson(Map<String, dynamic> json) =
      _$FavoriteCoinReqImpl.fromJson;

  @override
  String get email;
  @override
  List<String> get symbols;
  @override
  bool get alertEnabled;

  /// Create a copy of FavoriteCoinReq
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FavoriteCoinReqImplCopyWith<_$FavoriteCoinReqImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
