// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'register_agreement_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RegisterAgreementModel {

 List<String> get info; List<SingleRegisterAgreementModel> get options;
/// Create a copy of RegisterAgreementModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RegisterAgreementModelCopyWith<RegisterAgreementModel> get copyWith => _$RegisterAgreementModelCopyWithImpl<RegisterAgreementModel>(this as RegisterAgreementModel, _$identity);

  /// Serializes this RegisterAgreementModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RegisterAgreementModel&&const DeepCollectionEquality().equals(other.info, info)&&const DeepCollectionEquality().equals(other.options, options));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(info),const DeepCollectionEquality().hash(options));

@override
String toString() {
  return 'RegisterAgreementModel(info: $info, options: $options)';
}


}

/// @nodoc
abstract mixin class $RegisterAgreementModelCopyWith<$Res>  {
  factory $RegisterAgreementModelCopyWith(RegisterAgreementModel value, $Res Function(RegisterAgreementModel) _then) = _$RegisterAgreementModelCopyWithImpl;
@useResult
$Res call({
 List<String> info, List<SingleRegisterAgreementModel> options
});




}
/// @nodoc
class _$RegisterAgreementModelCopyWithImpl<$Res>
    implements $RegisterAgreementModelCopyWith<$Res> {
  _$RegisterAgreementModelCopyWithImpl(this._self, this._then);

  final RegisterAgreementModel _self;
  final $Res Function(RegisterAgreementModel) _then;

/// Create a copy of RegisterAgreementModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? info = null,Object? options = null,}) {
  return _then(_self.copyWith(
info: null == info ? _self.info : info // ignore: cast_nullable_to_non_nullable
as List<String>,options: null == options ? _self.options : options // ignore: cast_nullable_to_non_nullable
as List<SingleRegisterAgreementModel>,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _RegisterAgreementModel implements RegisterAgreementModel {
  const _RegisterAgreementModel({final  List<String> info = const [], final  List<SingleRegisterAgreementModel> options = const []}): _info = info,_options = options;
  factory _RegisterAgreementModel.fromJson(Map<String, dynamic> json) => _$RegisterAgreementModelFromJson(json);

 final  List<String> _info;
@override@JsonKey() List<String> get info {
  if (_info is EqualUnmodifiableListView) return _info;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_info);
}

 final  List<SingleRegisterAgreementModel> _options;
@override@JsonKey() List<SingleRegisterAgreementModel> get options {
  if (_options is EqualUnmodifiableListView) return _options;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_options);
}


/// Create a copy of RegisterAgreementModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RegisterAgreementModelCopyWith<_RegisterAgreementModel> get copyWith => __$RegisterAgreementModelCopyWithImpl<_RegisterAgreementModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RegisterAgreementModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RegisterAgreementModel&&const DeepCollectionEquality().equals(other._info, _info)&&const DeepCollectionEquality().equals(other._options, _options));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_info),const DeepCollectionEquality().hash(_options));

@override
String toString() {
  return 'RegisterAgreementModel(info: $info, options: $options)';
}


}

/// @nodoc
abstract mixin class _$RegisterAgreementModelCopyWith<$Res> implements $RegisterAgreementModelCopyWith<$Res> {
  factory _$RegisterAgreementModelCopyWith(_RegisterAgreementModel value, $Res Function(_RegisterAgreementModel) _then) = __$RegisterAgreementModelCopyWithImpl;
@override @useResult
$Res call({
 List<String> info, List<SingleRegisterAgreementModel> options
});




}
/// @nodoc
class __$RegisterAgreementModelCopyWithImpl<$Res>
    implements _$RegisterAgreementModelCopyWith<$Res> {
  __$RegisterAgreementModelCopyWithImpl(this._self, this._then);

  final _RegisterAgreementModel _self;
  final $Res Function(_RegisterAgreementModel) _then;

/// Create a copy of RegisterAgreementModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? info = null,Object? options = null,}) {
  return _then(_RegisterAgreementModel(
info: null == info ? _self._info : info // ignore: cast_nullable_to_non_nullable
as List<String>,options: null == options ? _self._options : options // ignore: cast_nullable_to_non_nullable
as List<SingleRegisterAgreementModel>,
  ));
}


}


/// @nodoc
mixin _$SingleRegisterAgreementModel {

 int get id; String get html; bool get required; bool get isChecked;
/// Create a copy of SingleRegisterAgreementModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SingleRegisterAgreementModelCopyWith<SingleRegisterAgreementModel> get copyWith => _$SingleRegisterAgreementModelCopyWithImpl<SingleRegisterAgreementModel>(this as SingleRegisterAgreementModel, _$identity);

  /// Serializes this SingleRegisterAgreementModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SingleRegisterAgreementModel&&(identical(other.id, id) || other.id == id)&&(identical(other.html, html) || other.html == html)&&(identical(other.required, required) || other.required == required)&&(identical(other.isChecked, isChecked) || other.isChecked == isChecked));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,html,required,isChecked);

@override
String toString() {
  return 'SingleRegisterAgreementModel(id: $id, html: $html, required: $required, isChecked: $isChecked)';
}


}

/// @nodoc
abstract mixin class $SingleRegisterAgreementModelCopyWith<$Res>  {
  factory $SingleRegisterAgreementModelCopyWith(SingleRegisterAgreementModel value, $Res Function(SingleRegisterAgreementModel) _then) = _$SingleRegisterAgreementModelCopyWithImpl;
@useResult
$Res call({
 int id, String html, bool required, bool isChecked
});




}
/// @nodoc
class _$SingleRegisterAgreementModelCopyWithImpl<$Res>
    implements $SingleRegisterAgreementModelCopyWith<$Res> {
  _$SingleRegisterAgreementModelCopyWithImpl(this._self, this._then);

  final SingleRegisterAgreementModel _self;
  final $Res Function(SingleRegisterAgreementModel) _then;

/// Create a copy of SingleRegisterAgreementModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? html = null,Object? required = null,Object? isChecked = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,html: null == html ? _self.html : html // ignore: cast_nullable_to_non_nullable
as String,required: null == required ? _self.required : required // ignore: cast_nullable_to_non_nullable
as bool,isChecked: null == isChecked ? _self.isChecked : isChecked // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _SingleRegisterAgreementModel implements SingleRegisterAgreementModel {
  const _SingleRegisterAgreementModel({required this.id, required this.html, required this.required, this.isChecked = false});
  factory _SingleRegisterAgreementModel.fromJson(Map<String, dynamic> json) => _$SingleRegisterAgreementModelFromJson(json);

@override final  int id;
@override final  String html;
@override final  bool required;
@override@JsonKey() final  bool isChecked;

/// Create a copy of SingleRegisterAgreementModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SingleRegisterAgreementModelCopyWith<_SingleRegisterAgreementModel> get copyWith => __$SingleRegisterAgreementModelCopyWithImpl<_SingleRegisterAgreementModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SingleRegisterAgreementModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SingleRegisterAgreementModel&&(identical(other.id, id) || other.id == id)&&(identical(other.html, html) || other.html == html)&&(identical(other.required, required) || other.required == required)&&(identical(other.isChecked, isChecked) || other.isChecked == isChecked));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,html,required,isChecked);

@override
String toString() {
  return 'SingleRegisterAgreementModel(id: $id, html: $html, required: $required, isChecked: $isChecked)';
}


}

/// @nodoc
abstract mixin class _$SingleRegisterAgreementModelCopyWith<$Res> implements $SingleRegisterAgreementModelCopyWith<$Res> {
  factory _$SingleRegisterAgreementModelCopyWith(_SingleRegisterAgreementModel value, $Res Function(_SingleRegisterAgreementModel) _then) = __$SingleRegisterAgreementModelCopyWithImpl;
@override @useResult
$Res call({
 int id, String html, bool required, bool isChecked
});




}
/// @nodoc
class __$SingleRegisterAgreementModelCopyWithImpl<$Res>
    implements _$SingleRegisterAgreementModelCopyWith<$Res> {
  __$SingleRegisterAgreementModelCopyWithImpl(this._self, this._then);

  final _SingleRegisterAgreementModel _self;
  final $Res Function(_SingleRegisterAgreementModel) _then;

/// Create a copy of SingleRegisterAgreementModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? html = null,Object? required = null,Object? isChecked = null,}) {
  return _then(_SingleRegisterAgreementModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,html: null == html ? _self.html : html // ignore: cast_nullable_to_non_nullable
as String,required: null == required ? _self.required : required // ignore: cast_nullable_to_non_nullable
as bool,isChecked: null == isChecked ? _self.isChecked : isChecked // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
