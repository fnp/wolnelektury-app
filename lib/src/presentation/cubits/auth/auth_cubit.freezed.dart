// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AuthState {

 bool get isLoading; bool get isLoadingAgreements; bool? get isLoginSuccess; bool? get isRegisterSuccess; bool? get isLoginSuccessFromRegisterFlow; UserModel? get user; RegisterAgreementModel? get agreements; bool get wasLoggedInWhileOnline;// UI
 bool get shouldShowRegisterForm;
/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthStateCopyWith<AuthState> get copyWith => _$AuthStateCopyWithImpl<AuthState>(this as AuthState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isLoadingAgreements, isLoadingAgreements) || other.isLoadingAgreements == isLoadingAgreements)&&(identical(other.isLoginSuccess, isLoginSuccess) || other.isLoginSuccess == isLoginSuccess)&&(identical(other.isRegisterSuccess, isRegisterSuccess) || other.isRegisterSuccess == isRegisterSuccess)&&(identical(other.isLoginSuccessFromRegisterFlow, isLoginSuccessFromRegisterFlow) || other.isLoginSuccessFromRegisterFlow == isLoginSuccessFromRegisterFlow)&&(identical(other.user, user) || other.user == user)&&(identical(other.agreements, agreements) || other.agreements == agreements)&&(identical(other.wasLoggedInWhileOnline, wasLoggedInWhileOnline) || other.wasLoggedInWhileOnline == wasLoggedInWhileOnline)&&(identical(other.shouldShowRegisterForm, shouldShowRegisterForm) || other.shouldShowRegisterForm == shouldShowRegisterForm));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,isLoadingAgreements,isLoginSuccess,isRegisterSuccess,isLoginSuccessFromRegisterFlow,user,agreements,wasLoggedInWhileOnline,shouldShowRegisterForm);

@override
String toString() {
  return 'AuthState(isLoading: $isLoading, isLoadingAgreements: $isLoadingAgreements, isLoginSuccess: $isLoginSuccess, isRegisterSuccess: $isRegisterSuccess, isLoginSuccessFromRegisterFlow: $isLoginSuccessFromRegisterFlow, user: $user, agreements: $agreements, wasLoggedInWhileOnline: $wasLoggedInWhileOnline, shouldShowRegisterForm: $shouldShowRegisterForm)';
}


}

/// @nodoc
abstract mixin class $AuthStateCopyWith<$Res>  {
  factory $AuthStateCopyWith(AuthState value, $Res Function(AuthState) _then) = _$AuthStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, bool isLoadingAgreements, bool? isLoginSuccess, bool? isRegisterSuccess, bool? isLoginSuccessFromRegisterFlow, UserModel? user, RegisterAgreementModel? agreements, bool wasLoggedInWhileOnline, bool shouldShowRegisterForm
});


$UserModelCopyWith<$Res>? get user;$RegisterAgreementModelCopyWith<$Res>? get agreements;

}
/// @nodoc
class _$AuthStateCopyWithImpl<$Res>
    implements $AuthStateCopyWith<$Res> {
  _$AuthStateCopyWithImpl(this._self, this._then);

  final AuthState _self;
  final $Res Function(AuthState) _then;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? isLoadingAgreements = null,Object? isLoginSuccess = freezed,Object? isRegisterSuccess = freezed,Object? isLoginSuccessFromRegisterFlow = freezed,Object? user = freezed,Object? agreements = freezed,Object? wasLoggedInWhileOnline = null,Object? shouldShowRegisterForm = null,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isLoadingAgreements: null == isLoadingAgreements ? _self.isLoadingAgreements : isLoadingAgreements // ignore: cast_nullable_to_non_nullable
as bool,isLoginSuccess: freezed == isLoginSuccess ? _self.isLoginSuccess : isLoginSuccess // ignore: cast_nullable_to_non_nullable
as bool?,isRegisterSuccess: freezed == isRegisterSuccess ? _self.isRegisterSuccess : isRegisterSuccess // ignore: cast_nullable_to_non_nullable
as bool?,isLoginSuccessFromRegisterFlow: freezed == isLoginSuccessFromRegisterFlow ? _self.isLoginSuccessFromRegisterFlow : isLoginSuccessFromRegisterFlow // ignore: cast_nullable_to_non_nullable
as bool?,user: freezed == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as UserModel?,agreements: freezed == agreements ? _self.agreements : agreements // ignore: cast_nullable_to_non_nullable
as RegisterAgreementModel?,wasLoggedInWhileOnline: null == wasLoggedInWhileOnline ? _self.wasLoggedInWhileOnline : wasLoggedInWhileOnline // ignore: cast_nullable_to_non_nullable
as bool,shouldShowRegisterForm: null == shouldShowRegisterForm ? _self.shouldShowRegisterForm : shouldShowRegisterForm // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserModelCopyWith<$Res>? get user {
    if (_self.user == null) {
    return null;
  }

  return $UserModelCopyWith<$Res>(_self.user!, (value) {
    return _then(_self.copyWith(user: value));
  });
}/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RegisterAgreementModelCopyWith<$Res>? get agreements {
    if (_self.agreements == null) {
    return null;
  }

  return $RegisterAgreementModelCopyWith<$Res>(_self.agreements!, (value) {
    return _then(_self.copyWith(agreements: value));
  });
}
}


/// @nodoc


class _AuthState implements AuthState {
  const _AuthState({this.isLoading = false, this.isLoadingAgreements = false, this.isLoginSuccess, this.isRegisterSuccess, this.isLoginSuccessFromRegisterFlow, this.user, this.agreements, this.wasLoggedInWhileOnline = false, this.shouldShowRegisterForm = false});
  

@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool isLoadingAgreements;
@override final  bool? isLoginSuccess;
@override final  bool? isRegisterSuccess;
@override final  bool? isLoginSuccessFromRegisterFlow;
@override final  UserModel? user;
@override final  RegisterAgreementModel? agreements;
@override@JsonKey() final  bool wasLoggedInWhileOnline;
// UI
@override@JsonKey() final  bool shouldShowRegisterForm;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AuthStateCopyWith<_AuthState> get copyWith => __$AuthStateCopyWithImpl<_AuthState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AuthState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isLoadingAgreements, isLoadingAgreements) || other.isLoadingAgreements == isLoadingAgreements)&&(identical(other.isLoginSuccess, isLoginSuccess) || other.isLoginSuccess == isLoginSuccess)&&(identical(other.isRegisterSuccess, isRegisterSuccess) || other.isRegisterSuccess == isRegisterSuccess)&&(identical(other.isLoginSuccessFromRegisterFlow, isLoginSuccessFromRegisterFlow) || other.isLoginSuccessFromRegisterFlow == isLoginSuccessFromRegisterFlow)&&(identical(other.user, user) || other.user == user)&&(identical(other.agreements, agreements) || other.agreements == agreements)&&(identical(other.wasLoggedInWhileOnline, wasLoggedInWhileOnline) || other.wasLoggedInWhileOnline == wasLoggedInWhileOnline)&&(identical(other.shouldShowRegisterForm, shouldShowRegisterForm) || other.shouldShowRegisterForm == shouldShowRegisterForm));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,isLoadingAgreements,isLoginSuccess,isRegisterSuccess,isLoginSuccessFromRegisterFlow,user,agreements,wasLoggedInWhileOnline,shouldShowRegisterForm);

@override
String toString() {
  return 'AuthState(isLoading: $isLoading, isLoadingAgreements: $isLoadingAgreements, isLoginSuccess: $isLoginSuccess, isRegisterSuccess: $isRegisterSuccess, isLoginSuccessFromRegisterFlow: $isLoginSuccessFromRegisterFlow, user: $user, agreements: $agreements, wasLoggedInWhileOnline: $wasLoggedInWhileOnline, shouldShowRegisterForm: $shouldShowRegisterForm)';
}


}

/// @nodoc
abstract mixin class _$AuthStateCopyWith<$Res> implements $AuthStateCopyWith<$Res> {
  factory _$AuthStateCopyWith(_AuthState value, $Res Function(_AuthState) _then) = __$AuthStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, bool isLoadingAgreements, bool? isLoginSuccess, bool? isRegisterSuccess, bool? isLoginSuccessFromRegisterFlow, UserModel? user, RegisterAgreementModel? agreements, bool wasLoggedInWhileOnline, bool shouldShowRegisterForm
});


@override $UserModelCopyWith<$Res>? get user;@override $RegisterAgreementModelCopyWith<$Res>? get agreements;

}
/// @nodoc
class __$AuthStateCopyWithImpl<$Res>
    implements _$AuthStateCopyWith<$Res> {
  __$AuthStateCopyWithImpl(this._self, this._then);

  final _AuthState _self;
  final $Res Function(_AuthState) _then;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? isLoadingAgreements = null,Object? isLoginSuccess = freezed,Object? isRegisterSuccess = freezed,Object? isLoginSuccessFromRegisterFlow = freezed,Object? user = freezed,Object? agreements = freezed,Object? wasLoggedInWhileOnline = null,Object? shouldShowRegisterForm = null,}) {
  return _then(_AuthState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isLoadingAgreements: null == isLoadingAgreements ? _self.isLoadingAgreements : isLoadingAgreements // ignore: cast_nullable_to_non_nullable
as bool,isLoginSuccess: freezed == isLoginSuccess ? _self.isLoginSuccess : isLoginSuccess // ignore: cast_nullable_to_non_nullable
as bool?,isRegisterSuccess: freezed == isRegisterSuccess ? _self.isRegisterSuccess : isRegisterSuccess // ignore: cast_nullable_to_non_nullable
as bool?,isLoginSuccessFromRegisterFlow: freezed == isLoginSuccessFromRegisterFlow ? _self.isLoginSuccessFromRegisterFlow : isLoginSuccessFromRegisterFlow // ignore: cast_nullable_to_non_nullable
as bool?,user: freezed == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as UserModel?,agreements: freezed == agreements ? _self.agreements : agreements // ignore: cast_nullable_to_non_nullable
as RegisterAgreementModel?,wasLoggedInWhileOnline: null == wasLoggedInWhileOnline ? _self.wasLoggedInWhileOnline : wasLoggedInWhileOnline // ignore: cast_nullable_to_non_nullable
as bool,shouldShowRegisterForm: null == shouldShowRegisterForm ? _self.shouldShowRegisterForm : shouldShowRegisterForm // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserModelCopyWith<$Res>? get user {
    if (_self.user == null) {
    return null;
  }

  return $UserModelCopyWith<$Res>(_self.user!, (value) {
    return _then(_self.copyWith(user: value));
  });
}/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RegisterAgreementModelCopyWith<$Res>? get agreements {
    if (_self.agreements == null) {
    return null;
  }

  return $RegisterAgreementModelCopyWith<$Res>(_self.agreements!, (value) {
    return _then(_self.copyWith(agreements: value));
  });
}
}

// dart format on
