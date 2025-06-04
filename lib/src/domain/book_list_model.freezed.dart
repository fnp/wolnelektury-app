// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'book_list_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BookListModel {

 String get name; String get slug; List<String> get books;
/// Create a copy of BookListModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BookListModelCopyWith<BookListModel> get copyWith => _$BookListModelCopyWithImpl<BookListModel>(this as BookListModel, _$identity);

  /// Serializes this BookListModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BookListModel&&(identical(other.name, name) || other.name == name)&&(identical(other.slug, slug) || other.slug == slug)&&const DeepCollectionEquality().equals(other.books, books));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,slug,const DeepCollectionEquality().hash(books));

@override
String toString() {
  return 'BookListModel(name: $name, slug: $slug, books: $books)';
}


}

/// @nodoc
abstract mixin class $BookListModelCopyWith<$Res>  {
  factory $BookListModelCopyWith(BookListModel value, $Res Function(BookListModel) _then) = _$BookListModelCopyWithImpl;
@useResult
$Res call({
 String name, String slug, List<String> books
});




}
/// @nodoc
class _$BookListModelCopyWithImpl<$Res>
    implements $BookListModelCopyWith<$Res> {
  _$BookListModelCopyWithImpl(this._self, this._then);

  final BookListModel _self;
  final $Res Function(BookListModel) _then;

/// Create a copy of BookListModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? slug = null,Object? books = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,books: null == books ? _self.books : books // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _BookListModel implements BookListModel {
  const _BookListModel({required this.name, required this.slug, required final  List<String> books}): _books = books;
  factory _BookListModel.fromJson(Map<String, dynamic> json) => _$BookListModelFromJson(json);

@override final  String name;
@override final  String slug;
 final  List<String> _books;
@override List<String> get books {
  if (_books is EqualUnmodifiableListView) return _books;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_books);
}


/// Create a copy of BookListModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BookListModelCopyWith<_BookListModel> get copyWith => __$BookListModelCopyWithImpl<_BookListModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BookListModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BookListModel&&(identical(other.name, name) || other.name == name)&&(identical(other.slug, slug) || other.slug == slug)&&const DeepCollectionEquality().equals(other._books, _books));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,slug,const DeepCollectionEquality().hash(_books));

@override
String toString() {
  return 'BookListModel(name: $name, slug: $slug, books: $books)';
}


}

/// @nodoc
abstract mixin class _$BookListModelCopyWith<$Res> implements $BookListModelCopyWith<$Res> {
  factory _$BookListModelCopyWith(_BookListModel value, $Res Function(_BookListModel) _then) = __$BookListModelCopyWithImpl;
@override @useResult
$Res call({
 String name, String slug, List<String> books
});




}
/// @nodoc
class __$BookListModelCopyWithImpl<$Res>
    implements _$BookListModelCopyWith<$Res> {
  __$BookListModelCopyWithImpl(this._self, this._then);

  final _BookListModel _self;
  final $Res Function(_BookListModel) _then;

/// Create a copy of BookListModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? slug = null,Object? books = null,}) {
  return _then(_BookListModel(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,books: null == books ? _self._books : books // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
