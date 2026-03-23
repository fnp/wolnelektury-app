// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'list_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
ListModel _$ListModelFromJson(
  Map<String, dynamic> json
) {
    return _BookListModel.fromJson(
      json
    );
}

/// @nodoc
mixin _$ListModel {

 String get name; String get slug; List<ListItemModel> get items;
/// Create a copy of ListModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ListModelCopyWith<ListModel> get copyWith => _$ListModelCopyWithImpl<ListModel>(this as ListModel, _$identity);

  /// Serializes this ListModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ListModel&&(identical(other.name, name) || other.name == name)&&(identical(other.slug, slug) || other.slug == slug)&&const DeepCollectionEquality().equals(other.items, items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,slug,const DeepCollectionEquality().hash(items));

@override
String toString() {
  return 'ListModel(name: $name, slug: $slug, items: $items)';
}


}

/// @nodoc
abstract mixin class $ListModelCopyWith<$Res>  {
  factory $ListModelCopyWith(ListModel value, $Res Function(ListModel) _then) = _$ListModelCopyWithImpl;
@useResult
$Res call({
 String name, String slug, List<ListItemModel> items
});




}
/// @nodoc
class _$ListModelCopyWithImpl<$Res>
    implements $ListModelCopyWith<$Res> {
  _$ListModelCopyWithImpl(this._self, this._then);

  final ListModel _self;
  final $Res Function(ListModel) _then;

/// Create a copy of ListModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? slug = null,Object? items = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<ListItemModel>,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _BookListModel implements ListModel {
  const _BookListModel({required this.name, required this.slug, final  List<ListItemModel> items = const []}): _items = items;
  factory _BookListModel.fromJson(Map<String, dynamic> json) => _$BookListModelFromJson(json);

@override final  String name;
@override final  String slug;
 final  List<ListItemModel> _items;
@override@JsonKey() List<ListItemModel> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}


/// Create a copy of ListModel
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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BookListModel&&(identical(other.name, name) || other.name == name)&&(identical(other.slug, slug) || other.slug == slug)&&const DeepCollectionEquality().equals(other._items, _items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,slug,const DeepCollectionEquality().hash(_items));

@override
String toString() {
  return 'ListModel(name: $name, slug: $slug, items: $items)';
}


}

/// @nodoc
abstract mixin class _$BookListModelCopyWith<$Res> implements $ListModelCopyWith<$Res> {
  factory _$BookListModelCopyWith(_BookListModel value, $Res Function(_BookListModel) _then) = __$BookListModelCopyWithImpl;
@override @useResult
$Res call({
 String name, String slug, List<ListItemModel> items
});




}
/// @nodoc
class __$BookListModelCopyWithImpl<$Res>
    implements _$BookListModelCopyWith<$Res> {
  __$BookListModelCopyWithImpl(this._self, this._then);

  final _BookListModel _self;
  final $Res Function(_BookListModel) _then;

/// Create a copy of ListModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? slug = null,Object? items = null,}) {
  return _then(_BookListModel(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<ListItemModel>,
  ));
}


}


/// @nodoc
mixin _$ListItemModel {

 String? get uuid;@JsonKey(name: 'list_slug') String get listSlug; int? get order; int? get timestamp; bool get favorites; bool get deleted;@JsonKey(name: 'book_slug') String? get bookSlug; String? get fragment; String? get quote; String? get bookmark; String get note;
/// Create a copy of ListItemModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ListItemModelCopyWith<ListItemModel> get copyWith => _$ListItemModelCopyWithImpl<ListItemModel>(this as ListItemModel, _$identity);

  /// Serializes this ListItemModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ListItemModel&&(identical(other.uuid, uuid) || other.uuid == uuid)&&(identical(other.listSlug, listSlug) || other.listSlug == listSlug)&&(identical(other.order, order) || other.order == order)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.favorites, favorites) || other.favorites == favorites)&&(identical(other.deleted, deleted) || other.deleted == deleted)&&(identical(other.bookSlug, bookSlug) || other.bookSlug == bookSlug)&&(identical(other.fragment, fragment) || other.fragment == fragment)&&(identical(other.quote, quote) || other.quote == quote)&&(identical(other.bookmark, bookmark) || other.bookmark == bookmark)&&(identical(other.note, note) || other.note == note));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,uuid,listSlug,order,timestamp,favorites,deleted,bookSlug,fragment,quote,bookmark,note);

@override
String toString() {
  return 'ListItemModel(uuid: $uuid, listSlug: $listSlug, order: $order, timestamp: $timestamp, favorites: $favorites, deleted: $deleted, bookSlug: $bookSlug, fragment: $fragment, quote: $quote, bookmark: $bookmark, note: $note)';
}


}

/// @nodoc
abstract mixin class $ListItemModelCopyWith<$Res>  {
  factory $ListItemModelCopyWith(ListItemModel value, $Res Function(ListItemModel) _then) = _$ListItemModelCopyWithImpl;
@useResult
$Res call({
 String? uuid,@JsonKey(name: 'list_slug') String listSlug, int? order, int? timestamp, bool favorites, bool deleted,@JsonKey(name: 'book_slug') String? bookSlug, String? fragment, String? quote, String? bookmark, String note
});




}
/// @nodoc
class _$ListItemModelCopyWithImpl<$Res>
    implements $ListItemModelCopyWith<$Res> {
  _$ListItemModelCopyWithImpl(this._self, this._then);

  final ListItemModel _self;
  final $Res Function(ListItemModel) _then;

/// Create a copy of ListItemModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? uuid = freezed,Object? listSlug = null,Object? order = freezed,Object? timestamp = freezed,Object? favorites = null,Object? deleted = null,Object? bookSlug = freezed,Object? fragment = freezed,Object? quote = freezed,Object? bookmark = freezed,Object? note = null,}) {
  return _then(_self.copyWith(
uuid: freezed == uuid ? _self.uuid : uuid // ignore: cast_nullable_to_non_nullable
as String?,listSlug: null == listSlug ? _self.listSlug : listSlug // ignore: cast_nullable_to_non_nullable
as String,order: freezed == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as int?,timestamp: freezed == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as int?,favorites: null == favorites ? _self.favorites : favorites // ignore: cast_nullable_to_non_nullable
as bool,deleted: null == deleted ? _self.deleted : deleted // ignore: cast_nullable_to_non_nullable
as bool,bookSlug: freezed == bookSlug ? _self.bookSlug : bookSlug // ignore: cast_nullable_to_non_nullable
as String?,fragment: freezed == fragment ? _self.fragment : fragment // ignore: cast_nullable_to_non_nullable
as String?,quote: freezed == quote ? _self.quote : quote // ignore: cast_nullable_to_non_nullable
as String?,bookmark: freezed == bookmark ? _self.bookmark : bookmark // ignore: cast_nullable_to_non_nullable
as String?,note: null == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _ListItemModel implements ListItemModel {
  const _ListItemModel({this.uuid, @JsonKey(name: 'list_slug') required this.listSlug, this.order, this.timestamp, this.favorites = false, this.deleted = false, @JsonKey(name: 'book_slug') this.bookSlug, this.fragment, this.quote, this.bookmark, this.note = ''});
  factory _ListItemModel.fromJson(Map<String, dynamic> json) => _$ListItemModelFromJson(json);

@override final  String? uuid;
@override@JsonKey(name: 'list_slug') final  String listSlug;
@override final  int? order;
@override final  int? timestamp;
@override@JsonKey() final  bool favorites;
@override@JsonKey() final  bool deleted;
@override@JsonKey(name: 'book_slug') final  String? bookSlug;
@override final  String? fragment;
@override final  String? quote;
@override final  String? bookmark;
@override@JsonKey() final  String note;

/// Create a copy of ListItemModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ListItemModelCopyWith<_ListItemModel> get copyWith => __$ListItemModelCopyWithImpl<_ListItemModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ListItemModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ListItemModel&&(identical(other.uuid, uuid) || other.uuid == uuid)&&(identical(other.listSlug, listSlug) || other.listSlug == listSlug)&&(identical(other.order, order) || other.order == order)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.favorites, favorites) || other.favorites == favorites)&&(identical(other.deleted, deleted) || other.deleted == deleted)&&(identical(other.bookSlug, bookSlug) || other.bookSlug == bookSlug)&&(identical(other.fragment, fragment) || other.fragment == fragment)&&(identical(other.quote, quote) || other.quote == quote)&&(identical(other.bookmark, bookmark) || other.bookmark == bookmark)&&(identical(other.note, note) || other.note == note));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,uuid,listSlug,order,timestamp,favorites,deleted,bookSlug,fragment,quote,bookmark,note);

@override
String toString() {
  return 'ListItemModel(uuid: $uuid, listSlug: $listSlug, order: $order, timestamp: $timestamp, favorites: $favorites, deleted: $deleted, bookSlug: $bookSlug, fragment: $fragment, quote: $quote, bookmark: $bookmark, note: $note)';
}


}

/// @nodoc
abstract mixin class _$ListItemModelCopyWith<$Res> implements $ListItemModelCopyWith<$Res> {
  factory _$ListItemModelCopyWith(_ListItemModel value, $Res Function(_ListItemModel) _then) = __$ListItemModelCopyWithImpl;
@override @useResult
$Res call({
 String? uuid,@JsonKey(name: 'list_slug') String listSlug, int? order, int? timestamp, bool favorites, bool deleted,@JsonKey(name: 'book_slug') String? bookSlug, String? fragment, String? quote, String? bookmark, String note
});




}
/// @nodoc
class __$ListItemModelCopyWithImpl<$Res>
    implements _$ListItemModelCopyWith<$Res> {
  __$ListItemModelCopyWithImpl(this._self, this._then);

  final _ListItemModel _self;
  final $Res Function(_ListItemModel) _then;

/// Create a copy of ListItemModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? uuid = freezed,Object? listSlug = null,Object? order = freezed,Object? timestamp = freezed,Object? favorites = null,Object? deleted = null,Object? bookSlug = freezed,Object? fragment = freezed,Object? quote = freezed,Object? bookmark = freezed,Object? note = null,}) {
  return _then(_ListItemModel(
uuid: freezed == uuid ? _self.uuid : uuid // ignore: cast_nullable_to_non_nullable
as String?,listSlug: null == listSlug ? _self.listSlug : listSlug // ignore: cast_nullable_to_non_nullable
as String,order: freezed == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as int?,timestamp: freezed == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as int?,favorites: null == favorites ? _self.favorites : favorites // ignore: cast_nullable_to_non_nullable
as bool,deleted: null == deleted ? _self.deleted : deleted // ignore: cast_nullable_to_non_nullable
as bool,bookSlug: freezed == bookSlug ? _self.bookSlug : bookSlug // ignore: cast_nullable_to_non_nullable
as String?,fragment: freezed == fragment ? _self.fragment : fragment // ignore: cast_nullable_to_non_nullable
as String?,quote: freezed == quote ? _self.quote : quote // ignore: cast_nullable_to_non_nullable
as String?,bookmark: freezed == bookmark ? _self.bookmark : bookmark // ignore: cast_nullable_to_non_nullable
as String?,note: null == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
