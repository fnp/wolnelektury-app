// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AuthState {
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isLoadingAgreements => throw _privateConstructorUsedError;
  bool? get isLoginSuccess => throw _privateConstructorUsedError;
  bool? get isRegisterSuccess => throw _privateConstructorUsedError;
  bool? get isLoginSuccessFromRegisterFlow =>
      throw _privateConstructorUsedError;
  UserModel? get user => throw _privateConstructorUsedError;
  RegisterAgreementModel? get agreements => throw _privateConstructorUsedError;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AuthStateCopyWith<AuthState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthStateCopyWith<$Res> {
  factory $AuthStateCopyWith(AuthState value, $Res Function(AuthState) then) =
      _$AuthStateCopyWithImpl<$Res, AuthState>;
  @useResult
  $Res call(
      {bool isLoading,
      bool isLoadingAgreements,
      bool? isLoginSuccess,
      bool? isRegisterSuccess,
      bool? isLoginSuccessFromRegisterFlow,
      UserModel? user,
      RegisterAgreementModel? agreements});

  $UserModelCopyWith<$Res>? get user;
  $RegisterAgreementModelCopyWith<$Res>? get agreements;
}

/// @nodoc
class _$AuthStateCopyWithImpl<$Res, $Val extends AuthState>
    implements $AuthStateCopyWith<$Res> {
  _$AuthStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? isLoadingAgreements = null,
    Object? isLoginSuccess = freezed,
    Object? isRegisterSuccess = freezed,
    Object? isLoginSuccessFromRegisterFlow = freezed,
    Object? user = freezed,
    Object? agreements = freezed,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoadingAgreements: null == isLoadingAgreements
          ? _value.isLoadingAgreements
          : isLoadingAgreements // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoginSuccess: freezed == isLoginSuccess
          ? _value.isLoginSuccess
          : isLoginSuccess // ignore: cast_nullable_to_non_nullable
              as bool?,
      isRegisterSuccess: freezed == isRegisterSuccess
          ? _value.isRegisterSuccess
          : isRegisterSuccess // ignore: cast_nullable_to_non_nullable
              as bool?,
      isLoginSuccessFromRegisterFlow: freezed == isLoginSuccessFromRegisterFlow
          ? _value.isLoginSuccessFromRegisterFlow
          : isLoginSuccessFromRegisterFlow // ignore: cast_nullable_to_non_nullable
              as bool?,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserModel?,
      agreements: freezed == agreements
          ? _value.agreements
          : agreements // ignore: cast_nullable_to_non_nullable
              as RegisterAgreementModel?,
    ) as $Val);
  }

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserModelCopyWith<$Res>? get user {
    if (_value.user == null) {
      return null;
    }

    return $UserModelCopyWith<$Res>(_value.user!, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RegisterAgreementModelCopyWith<$Res>? get agreements {
    if (_value.agreements == null) {
      return null;
    }

    return $RegisterAgreementModelCopyWith<$Res>(_value.agreements!, (value) {
      return _then(_value.copyWith(agreements: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AuthStateImplCopyWith<$Res>
    implements $AuthStateCopyWith<$Res> {
  factory _$$AuthStateImplCopyWith(
          _$AuthStateImpl value, $Res Function(_$AuthStateImpl) then) =
      __$$AuthStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isLoading,
      bool isLoadingAgreements,
      bool? isLoginSuccess,
      bool? isRegisterSuccess,
      bool? isLoginSuccessFromRegisterFlow,
      UserModel? user,
      RegisterAgreementModel? agreements});

  @override
  $UserModelCopyWith<$Res>? get user;
  @override
  $RegisterAgreementModelCopyWith<$Res>? get agreements;
}

/// @nodoc
class __$$AuthStateImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$AuthStateImpl>
    implements _$$AuthStateImplCopyWith<$Res> {
  __$$AuthStateImplCopyWithImpl(
      _$AuthStateImpl _value, $Res Function(_$AuthStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? isLoadingAgreements = null,
    Object? isLoginSuccess = freezed,
    Object? isRegisterSuccess = freezed,
    Object? isLoginSuccessFromRegisterFlow = freezed,
    Object? user = freezed,
    Object? agreements = freezed,
  }) {
    return _then(_$AuthStateImpl(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoadingAgreements: null == isLoadingAgreements
          ? _value.isLoadingAgreements
          : isLoadingAgreements // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoginSuccess: freezed == isLoginSuccess
          ? _value.isLoginSuccess
          : isLoginSuccess // ignore: cast_nullable_to_non_nullable
              as bool?,
      isRegisterSuccess: freezed == isRegisterSuccess
          ? _value.isRegisterSuccess
          : isRegisterSuccess // ignore: cast_nullable_to_non_nullable
              as bool?,
      isLoginSuccessFromRegisterFlow: freezed == isLoginSuccessFromRegisterFlow
          ? _value.isLoginSuccessFromRegisterFlow
          : isLoginSuccessFromRegisterFlow // ignore: cast_nullable_to_non_nullable
              as bool?,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserModel?,
      agreements: freezed == agreements
          ? _value.agreements
          : agreements // ignore: cast_nullable_to_non_nullable
              as RegisterAgreementModel?,
    ));
  }
}

/// @nodoc

class _$AuthStateImpl implements _AuthState {
  const _$AuthStateImpl(
      {this.isLoading = false,
      this.isLoadingAgreements = false,
      this.isLoginSuccess,
      this.isRegisterSuccess,
      this.isLoginSuccessFromRegisterFlow,
      this.user,
      this.agreements});

  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool isLoadingAgreements;
  @override
  final bool? isLoginSuccess;
  @override
  final bool? isRegisterSuccess;
  @override
  final bool? isLoginSuccessFromRegisterFlow;
  @override
  final UserModel? user;
  @override
  final RegisterAgreementModel? agreements;

  @override
  String toString() {
    return 'AuthState(isLoading: $isLoading, isLoadingAgreements: $isLoadingAgreements, isLoginSuccess: $isLoginSuccess, isRegisterSuccess: $isRegisterSuccess, isLoginSuccessFromRegisterFlow: $isLoginSuccessFromRegisterFlow, user: $user, agreements: $agreements)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isLoadingAgreements, isLoadingAgreements) ||
                other.isLoadingAgreements == isLoadingAgreements) &&
            (identical(other.isLoginSuccess, isLoginSuccess) ||
                other.isLoginSuccess == isLoginSuccess) &&
            (identical(other.isRegisterSuccess, isRegisterSuccess) ||
                other.isRegisterSuccess == isRegisterSuccess) &&
            (identical(other.isLoginSuccessFromRegisterFlow,
                    isLoginSuccessFromRegisterFlow) ||
                other.isLoginSuccessFromRegisterFlow ==
                    isLoginSuccessFromRegisterFlow) &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.agreements, agreements) ||
                other.agreements == agreements));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      isLoading,
      isLoadingAgreements,
      isLoginSuccess,
      isRegisterSuccess,
      isLoginSuccessFromRegisterFlow,
      user,
      agreements);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthStateImplCopyWith<_$AuthStateImpl> get copyWith =>
      __$$AuthStateImplCopyWithImpl<_$AuthStateImpl>(this, _$identity);
}

abstract class _AuthState implements AuthState {
  const factory _AuthState(
      {final bool isLoading,
      final bool isLoadingAgreements,
      final bool? isLoginSuccess,
      final bool? isRegisterSuccess,
      final bool? isLoginSuccessFromRegisterFlow,
      final UserModel? user,
      final RegisterAgreementModel? agreements}) = _$AuthStateImpl;

  @override
  bool get isLoading;
  @override
  bool get isLoadingAgreements;
  @override
  bool? get isLoginSuccess;
  @override
  bool? get isRegisterSuccess;
  @override
  bool? get isLoginSuccessFromRegisterFlow;
  @override
  UserModel? get user;
  @override
  RegisterAgreementModel? get agreements;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthStateImplCopyWith<_$AuthStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
