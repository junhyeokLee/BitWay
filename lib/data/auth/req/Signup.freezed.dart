// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'Signup.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$Signup {
  String get email => throw _privateConstructorUsedError;
  String get password => throw _privateConstructorUsedError;
  String get nickname => throw _privateConstructorUsedError;
  bool get emailVerified => throw _privateConstructorUsedError;
  bool get codeSent => throw _privateConstructorUsedError;
  bool get loading => throw _privateConstructorUsedError;
  bool get agreeTerms => throw _privateConstructorUsedError;
  bool get agreePrivacy => throw _privateConstructorUsedError;
  bool get agreeMarketing => throw _privateConstructorUsedError;

  /// Create a copy of Signup
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SignupCopyWith<Signup> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SignupCopyWith<$Res> {
  factory $SignupCopyWith(Signup value, $Res Function(Signup) then) =
      _$SignupCopyWithImpl<$Res, Signup>;
  @useResult
  $Res call(
      {String email,
      String password,
      String nickname,
      bool emailVerified,
      bool codeSent,
      bool loading,
      bool agreeTerms,
      bool agreePrivacy,
      bool agreeMarketing});
}

/// @nodoc
class _$SignupCopyWithImpl<$Res, $Val extends Signup>
    implements $SignupCopyWith<$Res> {
  _$SignupCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Signup
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? password = null,
    Object? nickname = null,
    Object? emailVerified = null,
    Object? codeSent = null,
    Object? loading = null,
    Object? agreeTerms = null,
    Object? agreePrivacy = null,
    Object? agreeMarketing = null,
  }) {
    return _then(_value.copyWith(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      nickname: null == nickname
          ? _value.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String,
      emailVerified: null == emailVerified
          ? _value.emailVerified
          : emailVerified // ignore: cast_nullable_to_non_nullable
              as bool,
      codeSent: null == codeSent
          ? _value.codeSent
          : codeSent // ignore: cast_nullable_to_non_nullable
              as bool,
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
      agreeTerms: null == agreeTerms
          ? _value.agreeTerms
          : agreeTerms // ignore: cast_nullable_to_non_nullable
              as bool,
      agreePrivacy: null == agreePrivacy
          ? _value.agreePrivacy
          : agreePrivacy // ignore: cast_nullable_to_non_nullable
              as bool,
      agreeMarketing: null == agreeMarketing
          ? _value.agreeMarketing
          : agreeMarketing // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SignupImplCopyWith<$Res> implements $SignupCopyWith<$Res> {
  factory _$$SignupImplCopyWith(
          _$SignupImpl value, $Res Function(_$SignupImpl) then) =
      __$$SignupImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String email,
      String password,
      String nickname,
      bool emailVerified,
      bool codeSent,
      bool loading,
      bool agreeTerms,
      bool agreePrivacy,
      bool agreeMarketing});
}

/// @nodoc
class __$$SignupImplCopyWithImpl<$Res>
    extends _$SignupCopyWithImpl<$Res, _$SignupImpl>
    implements _$$SignupImplCopyWith<$Res> {
  __$$SignupImplCopyWithImpl(
      _$SignupImpl _value, $Res Function(_$SignupImpl) _then)
      : super(_value, _then);

  /// Create a copy of Signup
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? password = null,
    Object? nickname = null,
    Object? emailVerified = null,
    Object? codeSent = null,
    Object? loading = null,
    Object? agreeTerms = null,
    Object? agreePrivacy = null,
    Object? agreeMarketing = null,
  }) {
    return _then(_$SignupImpl(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      nickname: null == nickname
          ? _value.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String,
      emailVerified: null == emailVerified
          ? _value.emailVerified
          : emailVerified // ignore: cast_nullable_to_non_nullable
              as bool,
      codeSent: null == codeSent
          ? _value.codeSent
          : codeSent // ignore: cast_nullable_to_non_nullable
              as bool,
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
      agreeTerms: null == agreeTerms
          ? _value.agreeTerms
          : agreeTerms // ignore: cast_nullable_to_non_nullable
              as bool,
      agreePrivacy: null == agreePrivacy
          ? _value.agreePrivacy
          : agreePrivacy // ignore: cast_nullable_to_non_nullable
              as bool,
      agreeMarketing: null == agreeMarketing
          ? _value.agreeMarketing
          : agreeMarketing // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$SignupImpl implements _Signup {
  const _$SignupImpl(
      {this.email = '',
      this.password = '',
      this.nickname = '',
      this.emailVerified = false,
      this.codeSent = false,
      this.loading = false,
      this.agreeTerms = false,
      this.agreePrivacy = false,
      this.agreeMarketing = false});

  @override
  @JsonKey()
  final String email;
  @override
  @JsonKey()
  final String password;
  @override
  @JsonKey()
  final String nickname;
  @override
  @JsonKey()
  final bool emailVerified;
  @override
  @JsonKey()
  final bool codeSent;
  @override
  @JsonKey()
  final bool loading;
  @override
  @JsonKey()
  final bool agreeTerms;
  @override
  @JsonKey()
  final bool agreePrivacy;
  @override
  @JsonKey()
  final bool agreeMarketing;

  @override
  String toString() {
    return 'Signup(email: $email, password: $password, nickname: $nickname, emailVerified: $emailVerified, codeSent: $codeSent, loading: $loading, agreeTerms: $agreeTerms, agreePrivacy: $agreePrivacy, agreeMarketing: $agreeMarketing)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SignupImpl &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.nickname, nickname) ||
                other.nickname == nickname) &&
            (identical(other.emailVerified, emailVerified) ||
                other.emailVerified == emailVerified) &&
            (identical(other.codeSent, codeSent) ||
                other.codeSent == codeSent) &&
            (identical(other.loading, loading) || other.loading == loading) &&
            (identical(other.agreeTerms, agreeTerms) ||
                other.agreeTerms == agreeTerms) &&
            (identical(other.agreePrivacy, agreePrivacy) ||
                other.agreePrivacy == agreePrivacy) &&
            (identical(other.agreeMarketing, agreeMarketing) ||
                other.agreeMarketing == agreeMarketing));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      email,
      password,
      nickname,
      emailVerified,
      codeSent,
      loading,
      agreeTerms,
      agreePrivacy,
      agreeMarketing);

  /// Create a copy of Signup
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SignupImplCopyWith<_$SignupImpl> get copyWith =>
      __$$SignupImplCopyWithImpl<_$SignupImpl>(this, _$identity);
}

abstract class _Signup implements Signup {
  const factory _Signup(
      {final String email,
      final String password,
      final String nickname,
      final bool emailVerified,
      final bool codeSent,
      final bool loading,
      final bool agreeTerms,
      final bool agreePrivacy,
      final bool agreeMarketing}) = _$SignupImpl;

  @override
  String get email;
  @override
  String get password;
  @override
  String get nickname;
  @override
  bool get emailVerified;
  @override
  bool get codeSent;
  @override
  bool get loading;
  @override
  bool get agreeTerms;
  @override
  bool get agreePrivacy;
  @override
  bool get agreeMarketing;

  /// Create a copy of Signup
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SignupImplCopyWith<_$SignupImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
