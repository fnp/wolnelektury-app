// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'settings_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SettingsState {

 AppSetting? get settings; String? get version;// Notifications, null means that the value is not fetched yet
 bool get isLoadingNotifications; bool get isSettingNotificationError; bool? get notificationsEnabled; bool get notificationsPermissionDenied; bool get isChangingPassword; bool? get isChangingPasswordSuccess; bool get isDeletingAccount; bool? get isDeletingAccountSuccess; bool get isSendingResetPassword; bool? get resetPasswordSuccess;
/// Create a copy of SettingsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SettingsStateCopyWith<SettingsState> get copyWith => _$SettingsStateCopyWithImpl<SettingsState>(this as SettingsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SettingsState&&const DeepCollectionEquality().equals(other.settings, settings)&&(identical(other.version, version) || other.version == version)&&(identical(other.isLoadingNotifications, isLoadingNotifications) || other.isLoadingNotifications == isLoadingNotifications)&&(identical(other.isSettingNotificationError, isSettingNotificationError) || other.isSettingNotificationError == isSettingNotificationError)&&(identical(other.notificationsEnabled, notificationsEnabled) || other.notificationsEnabled == notificationsEnabled)&&(identical(other.notificationsPermissionDenied, notificationsPermissionDenied) || other.notificationsPermissionDenied == notificationsPermissionDenied)&&(identical(other.isChangingPassword, isChangingPassword) || other.isChangingPassword == isChangingPassword)&&(identical(other.isChangingPasswordSuccess, isChangingPasswordSuccess) || other.isChangingPasswordSuccess == isChangingPasswordSuccess)&&(identical(other.isDeletingAccount, isDeletingAccount) || other.isDeletingAccount == isDeletingAccount)&&(identical(other.isDeletingAccountSuccess, isDeletingAccountSuccess) || other.isDeletingAccountSuccess == isDeletingAccountSuccess)&&(identical(other.isSendingResetPassword, isSendingResetPassword) || other.isSendingResetPassword == isSendingResetPassword)&&(identical(other.resetPasswordSuccess, resetPasswordSuccess) || other.resetPasswordSuccess == resetPasswordSuccess));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(settings),version,isLoadingNotifications,isSettingNotificationError,notificationsEnabled,notificationsPermissionDenied,isChangingPassword,isChangingPasswordSuccess,isDeletingAccount,isDeletingAccountSuccess,isSendingResetPassword,resetPasswordSuccess);

@override
String toString() {
  return 'SettingsState(settings: $settings, version: $version, isLoadingNotifications: $isLoadingNotifications, isSettingNotificationError: $isSettingNotificationError, notificationsEnabled: $notificationsEnabled, notificationsPermissionDenied: $notificationsPermissionDenied, isChangingPassword: $isChangingPassword, isChangingPasswordSuccess: $isChangingPasswordSuccess, isDeletingAccount: $isDeletingAccount, isDeletingAccountSuccess: $isDeletingAccountSuccess, isSendingResetPassword: $isSendingResetPassword, resetPasswordSuccess: $resetPasswordSuccess)';
}


}

/// @nodoc
abstract mixin class $SettingsStateCopyWith<$Res>  {
  factory $SettingsStateCopyWith(SettingsState value, $Res Function(SettingsState) _then) = _$SettingsStateCopyWithImpl;
@useResult
$Res call({
 AppSetting? settings, String? version, bool isLoadingNotifications, bool isSettingNotificationError, bool? notificationsEnabled, bool notificationsPermissionDenied, bool isChangingPassword, bool? isChangingPasswordSuccess, bool isDeletingAccount, bool? isDeletingAccountSuccess, bool isSendingResetPassword, bool? resetPasswordSuccess
});




}
/// @nodoc
class _$SettingsStateCopyWithImpl<$Res>
    implements $SettingsStateCopyWith<$Res> {
  _$SettingsStateCopyWithImpl(this._self, this._then);

  final SettingsState _self;
  final $Res Function(SettingsState) _then;

/// Create a copy of SettingsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? settings = freezed,Object? version = freezed,Object? isLoadingNotifications = null,Object? isSettingNotificationError = null,Object? notificationsEnabled = freezed,Object? notificationsPermissionDenied = null,Object? isChangingPassword = null,Object? isChangingPasswordSuccess = freezed,Object? isDeletingAccount = null,Object? isDeletingAccountSuccess = freezed,Object? isSendingResetPassword = null,Object? resetPasswordSuccess = freezed,}) {
  return _then(_self.copyWith(
settings: freezed == settings ? _self.settings : settings // ignore: cast_nullable_to_non_nullable
as AppSetting?,version: freezed == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String?,isLoadingNotifications: null == isLoadingNotifications ? _self.isLoadingNotifications : isLoadingNotifications // ignore: cast_nullable_to_non_nullable
as bool,isSettingNotificationError: null == isSettingNotificationError ? _self.isSettingNotificationError : isSettingNotificationError // ignore: cast_nullable_to_non_nullable
as bool,notificationsEnabled: freezed == notificationsEnabled ? _self.notificationsEnabled : notificationsEnabled // ignore: cast_nullable_to_non_nullable
as bool?,notificationsPermissionDenied: null == notificationsPermissionDenied ? _self.notificationsPermissionDenied : notificationsPermissionDenied // ignore: cast_nullable_to_non_nullable
as bool,isChangingPassword: null == isChangingPassword ? _self.isChangingPassword : isChangingPassword // ignore: cast_nullable_to_non_nullable
as bool,isChangingPasswordSuccess: freezed == isChangingPasswordSuccess ? _self.isChangingPasswordSuccess : isChangingPasswordSuccess // ignore: cast_nullable_to_non_nullable
as bool?,isDeletingAccount: null == isDeletingAccount ? _self.isDeletingAccount : isDeletingAccount // ignore: cast_nullable_to_non_nullable
as bool,isDeletingAccountSuccess: freezed == isDeletingAccountSuccess ? _self.isDeletingAccountSuccess : isDeletingAccountSuccess // ignore: cast_nullable_to_non_nullable
as bool?,isSendingResetPassword: null == isSendingResetPassword ? _self.isSendingResetPassword : isSendingResetPassword // ignore: cast_nullable_to_non_nullable
as bool,resetPasswordSuccess: freezed == resetPasswordSuccess ? _self.resetPasswordSuccess : resetPasswordSuccess // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

}


/// @nodoc


class _SettingsState implements SettingsState {
  const _SettingsState({this.settings, this.version, this.isLoadingNotifications = false, this.isSettingNotificationError = false, this.notificationsEnabled, this.notificationsPermissionDenied = false, this.isChangingPassword = false, this.isChangingPasswordSuccess, this.isDeletingAccount = false, this.isDeletingAccountSuccess, this.isSendingResetPassword = false, this.resetPasswordSuccess});
  

@override final  AppSetting? settings;
@override final  String? version;
// Notifications, null means that the value is not fetched yet
@override@JsonKey() final  bool isLoadingNotifications;
@override@JsonKey() final  bool isSettingNotificationError;
@override final  bool? notificationsEnabled;
@override@JsonKey() final  bool notificationsPermissionDenied;
@override@JsonKey() final  bool isChangingPassword;
@override final  bool? isChangingPasswordSuccess;
@override@JsonKey() final  bool isDeletingAccount;
@override final  bool? isDeletingAccountSuccess;
@override@JsonKey() final  bool isSendingResetPassword;
@override final  bool? resetPasswordSuccess;

/// Create a copy of SettingsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SettingsStateCopyWith<_SettingsState> get copyWith => __$SettingsStateCopyWithImpl<_SettingsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SettingsState&&const DeepCollectionEquality().equals(other.settings, settings)&&(identical(other.version, version) || other.version == version)&&(identical(other.isLoadingNotifications, isLoadingNotifications) || other.isLoadingNotifications == isLoadingNotifications)&&(identical(other.isSettingNotificationError, isSettingNotificationError) || other.isSettingNotificationError == isSettingNotificationError)&&(identical(other.notificationsEnabled, notificationsEnabled) || other.notificationsEnabled == notificationsEnabled)&&(identical(other.notificationsPermissionDenied, notificationsPermissionDenied) || other.notificationsPermissionDenied == notificationsPermissionDenied)&&(identical(other.isChangingPassword, isChangingPassword) || other.isChangingPassword == isChangingPassword)&&(identical(other.isChangingPasswordSuccess, isChangingPasswordSuccess) || other.isChangingPasswordSuccess == isChangingPasswordSuccess)&&(identical(other.isDeletingAccount, isDeletingAccount) || other.isDeletingAccount == isDeletingAccount)&&(identical(other.isDeletingAccountSuccess, isDeletingAccountSuccess) || other.isDeletingAccountSuccess == isDeletingAccountSuccess)&&(identical(other.isSendingResetPassword, isSendingResetPassword) || other.isSendingResetPassword == isSendingResetPassword)&&(identical(other.resetPasswordSuccess, resetPasswordSuccess) || other.resetPasswordSuccess == resetPasswordSuccess));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(settings),version,isLoadingNotifications,isSettingNotificationError,notificationsEnabled,notificationsPermissionDenied,isChangingPassword,isChangingPasswordSuccess,isDeletingAccount,isDeletingAccountSuccess,isSendingResetPassword,resetPasswordSuccess);

@override
String toString() {
  return 'SettingsState(settings: $settings, version: $version, isLoadingNotifications: $isLoadingNotifications, isSettingNotificationError: $isSettingNotificationError, notificationsEnabled: $notificationsEnabled, notificationsPermissionDenied: $notificationsPermissionDenied, isChangingPassword: $isChangingPassword, isChangingPasswordSuccess: $isChangingPasswordSuccess, isDeletingAccount: $isDeletingAccount, isDeletingAccountSuccess: $isDeletingAccountSuccess, isSendingResetPassword: $isSendingResetPassword, resetPasswordSuccess: $resetPasswordSuccess)';
}


}

/// @nodoc
abstract mixin class _$SettingsStateCopyWith<$Res> implements $SettingsStateCopyWith<$Res> {
  factory _$SettingsStateCopyWith(_SettingsState value, $Res Function(_SettingsState) _then) = __$SettingsStateCopyWithImpl;
@override @useResult
$Res call({
 AppSetting? settings, String? version, bool isLoadingNotifications, bool isSettingNotificationError, bool? notificationsEnabled, bool notificationsPermissionDenied, bool isChangingPassword, bool? isChangingPasswordSuccess, bool isDeletingAccount, bool? isDeletingAccountSuccess, bool isSendingResetPassword, bool? resetPasswordSuccess
});




}
/// @nodoc
class __$SettingsStateCopyWithImpl<$Res>
    implements _$SettingsStateCopyWith<$Res> {
  __$SettingsStateCopyWithImpl(this._self, this._then);

  final _SettingsState _self;
  final $Res Function(_SettingsState) _then;

/// Create a copy of SettingsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? settings = freezed,Object? version = freezed,Object? isLoadingNotifications = null,Object? isSettingNotificationError = null,Object? notificationsEnabled = freezed,Object? notificationsPermissionDenied = null,Object? isChangingPassword = null,Object? isChangingPasswordSuccess = freezed,Object? isDeletingAccount = null,Object? isDeletingAccountSuccess = freezed,Object? isSendingResetPassword = null,Object? resetPasswordSuccess = freezed,}) {
  return _then(_SettingsState(
settings: freezed == settings ? _self.settings : settings // ignore: cast_nullable_to_non_nullable
as AppSetting?,version: freezed == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String?,isLoadingNotifications: null == isLoadingNotifications ? _self.isLoadingNotifications : isLoadingNotifications // ignore: cast_nullable_to_non_nullable
as bool,isSettingNotificationError: null == isSettingNotificationError ? _self.isSettingNotificationError : isSettingNotificationError // ignore: cast_nullable_to_non_nullable
as bool,notificationsEnabled: freezed == notificationsEnabled ? _self.notificationsEnabled : notificationsEnabled // ignore: cast_nullable_to_non_nullable
as bool?,notificationsPermissionDenied: null == notificationsPermissionDenied ? _self.notificationsPermissionDenied : notificationsPermissionDenied // ignore: cast_nullable_to_non_nullable
as bool,isChangingPassword: null == isChangingPassword ? _self.isChangingPassword : isChangingPassword // ignore: cast_nullable_to_non_nullable
as bool,isChangingPasswordSuccess: freezed == isChangingPasswordSuccess ? _self.isChangingPasswordSuccess : isChangingPasswordSuccess // ignore: cast_nullable_to_non_nullable
as bool?,isDeletingAccount: null == isDeletingAccount ? _self.isDeletingAccount : isDeletingAccount // ignore: cast_nullable_to_non_nullable
as bool,isDeletingAccountSuccess: freezed == isDeletingAccountSuccess ? _self.isDeletingAccountSuccess : isDeletingAccountSuccess // ignore: cast_nullable_to_non_nullable
as bool?,isSendingResetPassword: null == isSendingResetPassword ? _self.isSendingResetPassword : isSendingResetPassword // ignore: cast_nullable_to_non_nullable
as bool,resetPasswordSuccess: freezed == resetPasswordSuccess ? _self.resetPasswordSuccess : resetPasswordSuccess // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}


}

// dart format on
