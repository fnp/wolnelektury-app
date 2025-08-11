// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'generic_search_result_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GenericSearchResultModel {

 List<DetailedAuthorModel> get author; List<GenreModel> get genre;
/// Create a copy of GenericSearchResultModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GenericSearchResultModelCopyWith<GenericSearchResultModel> get copyWith => _$GenericSearchResultModelCopyWithImpl<GenericSearchResultModel>(this as GenericSearchResultModel, _$identity);

  /// Serializes this GenericSearchResultModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GenericSearchResultModel&&const DeepCollectionEquality().equals(other.author, author)&&const DeepCollectionEquality().equals(other.genre, genre));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(author),const DeepCollectionEquality().hash(genre));

@override
String toString() {
  return 'GenericSearchResultModel(author: $author, genre: $genre)';
}


}

/// @nodoc
abstract mixin class $GenericSearchResultModelCopyWith<$Res>  {
  factory $GenericSearchResultModelCopyWith(GenericSearchResultModel value, $Res Function(GenericSearchResultModel) _then) = _$GenericSearchResultModelCopyWithImpl;
@useResult
$Res call({
 List<DetailedAuthorModel> author, List<GenreModel> genre
});




}
/// @nodoc
class _$GenericSearchResultModelCopyWithImpl<$Res>
    implements $GenericSearchResultModelCopyWith<$Res> {
  _$GenericSearchResultModelCopyWithImpl(this._self, this._then);

  final GenericSearchResultModel _self;
  final $Res Function(GenericSearchResultModel) _then;

/// Create a copy of GenericSearchResultModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? author = null,Object? genre = null,}) {
  return _then(_self.copyWith(
author: null == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as List<DetailedAuthorModel>,genre: null == genre ? _self.genre : genre // ignore: cast_nullable_to_non_nullable
as List<GenreModel>,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _GenericSearchResultModel implements GenericSearchResultModel {
  const _GenericSearchResultModel({final  List<DetailedAuthorModel> author = const [], final  List<GenreModel> genre = const []}): _author = author,_genre = genre;
  factory _GenericSearchResultModel.fromJson(Map<String, dynamic> json) => _$GenericSearchResultModelFromJson(json);

 final  List<DetailedAuthorModel> _author;
@override@JsonKey() List<DetailedAuthorModel> get author {
  if (_author is EqualUnmodifiableListView) return _author;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_author);
}

 final  List<GenreModel> _genre;
@override@JsonKey() List<GenreModel> get genre {
  if (_genre is EqualUnmodifiableListView) return _genre;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_genre);
}


/// Create a copy of GenericSearchResultModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GenericSearchResultModelCopyWith<_GenericSearchResultModel> get copyWith => __$GenericSearchResultModelCopyWithImpl<_GenericSearchResultModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GenericSearchResultModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GenericSearchResultModel&&const DeepCollectionEquality().equals(other._author, _author)&&const DeepCollectionEquality().equals(other._genre, _genre));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_author),const DeepCollectionEquality().hash(_genre));

@override
String toString() {
  return 'GenericSearchResultModel(author: $author, genre: $genre)';
}


}

/// @nodoc
abstract mixin class _$GenericSearchResultModelCopyWith<$Res> implements $GenericSearchResultModelCopyWith<$Res> {
  factory _$GenericSearchResultModelCopyWith(_GenericSearchResultModel value, $Res Function(_GenericSearchResultModel) _then) = __$GenericSearchResultModelCopyWithImpl;
@override @useResult
$Res call({
 List<DetailedAuthorModel> author, List<GenreModel> genre
});




}
/// @nodoc
class __$GenericSearchResultModelCopyWithImpl<$Res>
    implements _$GenericSearchResultModelCopyWith<$Res> {
  __$GenericSearchResultModelCopyWithImpl(this._self, this._then);

  final _GenericSearchResultModel _self;
  final $Res Function(_GenericSearchResultModel) _then;

/// Create a copy of GenericSearchResultModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? author = null,Object? genre = null,}) {
  return _then(_GenericSearchResultModel(
author: null == author ? _self._author : author // ignore: cast_nullable_to_non_nullable
as List<DetailedAuthorModel>,genre: null == genre ? _self._genre : genre // ignore: cast_nullable_to_non_nullable
as List<GenreModel>,
  ));
}


}

// dart format on
