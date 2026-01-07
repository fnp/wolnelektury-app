// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'book_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BookModel {

 String get title; String get url; String get slug; List<EpochModel> get epochs; List<GenreModel> get genres; List<KindModel> get kinds; List<AuthorModel> get authors; List<BookTranslator> get translators; List<BookChild> get children;@JsonKey(name: 'content_warnings') List<String> get contentWarnings; List<String> get audiences;@JsonKey(name: 'elevenreader_link') String? get elevenReaderLink;@JsonKey(name: 'fragment_data') BookFragmentData? get fragment;@JsonKey(name: 'simple_thumb') String? get simpleThumb;@JsonKey(name: 'cover_thumb') String? get coverThumb;@JsonKey(name: 'cover_color') String? get coverColor;@JsonKey(name: 'cover') String? get coverUrl;@JsonKey(name: 'simple_cover') String? get simpleCoverUrl;@JsonKey(name: 'isbn_pdf') String? get isbnPdf;@JsonKey(name: 'isbn_epub') String? get isbnEpub;@JsonKey(name: 'isbn_mobi') String? get isbnMobi;@JsonKey(name: 'abstract') String? get description;@JsonKey(name: 'has_mp3_file') bool get hasAudiobook;
/// Create a copy of BookModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BookModelCopyWith<BookModel> get copyWith => _$BookModelCopyWithImpl<BookModel>(this as BookModel, _$identity);

  /// Serializes this BookModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BookModel&&(identical(other.title, title) || other.title == title)&&(identical(other.url, url) || other.url == url)&&(identical(other.slug, slug) || other.slug == slug)&&const DeepCollectionEquality().equals(other.epochs, epochs)&&const DeepCollectionEquality().equals(other.genres, genres)&&const DeepCollectionEquality().equals(other.kinds, kinds)&&const DeepCollectionEquality().equals(other.authors, authors)&&const DeepCollectionEquality().equals(other.translators, translators)&&const DeepCollectionEquality().equals(other.children, children)&&const DeepCollectionEquality().equals(other.contentWarnings, contentWarnings)&&const DeepCollectionEquality().equals(other.audiences, audiences)&&(identical(other.elevenReaderLink, elevenReaderLink) || other.elevenReaderLink == elevenReaderLink)&&(identical(other.fragment, fragment) || other.fragment == fragment)&&(identical(other.simpleThumb, simpleThumb) || other.simpleThumb == simpleThumb)&&(identical(other.coverThumb, coverThumb) || other.coverThumb == coverThumb)&&(identical(other.coverColor, coverColor) || other.coverColor == coverColor)&&(identical(other.coverUrl, coverUrl) || other.coverUrl == coverUrl)&&(identical(other.simpleCoverUrl, simpleCoverUrl) || other.simpleCoverUrl == simpleCoverUrl)&&(identical(other.isbnPdf, isbnPdf) || other.isbnPdf == isbnPdf)&&(identical(other.isbnEpub, isbnEpub) || other.isbnEpub == isbnEpub)&&(identical(other.isbnMobi, isbnMobi) || other.isbnMobi == isbnMobi)&&(identical(other.description, description) || other.description == description)&&(identical(other.hasAudiobook, hasAudiobook) || other.hasAudiobook == hasAudiobook));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,title,url,slug,const DeepCollectionEquality().hash(epochs),const DeepCollectionEquality().hash(genres),const DeepCollectionEquality().hash(kinds),const DeepCollectionEquality().hash(authors),const DeepCollectionEquality().hash(translators),const DeepCollectionEquality().hash(children),const DeepCollectionEquality().hash(contentWarnings),const DeepCollectionEquality().hash(audiences),elevenReaderLink,fragment,simpleThumb,coverThumb,coverColor,coverUrl,simpleCoverUrl,isbnPdf,isbnEpub,isbnMobi,description,hasAudiobook]);

@override
String toString() {
  return 'BookModel(title: $title, url: $url, slug: $slug, epochs: $epochs, genres: $genres, kinds: $kinds, authors: $authors, translators: $translators, children: $children, contentWarnings: $contentWarnings, audiences: $audiences, elevenReaderLink: $elevenReaderLink, fragment: $fragment, simpleThumb: $simpleThumb, coverThumb: $coverThumb, coverColor: $coverColor, coverUrl: $coverUrl, simpleCoverUrl: $simpleCoverUrl, isbnPdf: $isbnPdf, isbnEpub: $isbnEpub, isbnMobi: $isbnMobi, description: $description, hasAudiobook: $hasAudiobook)';
}


}

/// @nodoc
abstract mixin class $BookModelCopyWith<$Res>  {
  factory $BookModelCopyWith(BookModel value, $Res Function(BookModel) _then) = _$BookModelCopyWithImpl;
@useResult
$Res call({
 String title, String url, String slug, List<EpochModel> epochs, List<GenreModel> genres, List<KindModel> kinds, List<AuthorModel> authors, List<BookTranslator> translators, List<BookChild> children,@JsonKey(name: 'content_warnings') List<String> contentWarnings, List<String> audiences,@JsonKey(name: 'elevenreader_link') String? elevenReaderLink,@JsonKey(name: 'fragment_data') BookFragmentData? fragment,@JsonKey(name: 'simple_thumb') String? simpleThumb,@JsonKey(name: 'cover_thumb') String? coverThumb,@JsonKey(name: 'cover_color') String? coverColor,@JsonKey(name: 'cover') String? coverUrl,@JsonKey(name: 'simple_cover') String? simpleCoverUrl,@JsonKey(name: 'isbn_pdf') String? isbnPdf,@JsonKey(name: 'isbn_epub') String? isbnEpub,@JsonKey(name: 'isbn_mobi') String? isbnMobi,@JsonKey(name: 'abstract') String? description,@JsonKey(name: 'has_mp3_file') bool hasAudiobook
});


$BookFragmentDataCopyWith<$Res>? get fragment;

}
/// @nodoc
class _$BookModelCopyWithImpl<$Res>
    implements $BookModelCopyWith<$Res> {
  _$BookModelCopyWithImpl(this._self, this._then);

  final BookModel _self;
  final $Res Function(BookModel) _then;

/// Create a copy of BookModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? url = null,Object? slug = null,Object? epochs = null,Object? genres = null,Object? kinds = null,Object? authors = null,Object? translators = null,Object? children = null,Object? contentWarnings = null,Object? audiences = null,Object? elevenReaderLink = freezed,Object? fragment = freezed,Object? simpleThumb = freezed,Object? coverThumb = freezed,Object? coverColor = freezed,Object? coverUrl = freezed,Object? simpleCoverUrl = freezed,Object? isbnPdf = freezed,Object? isbnEpub = freezed,Object? isbnMobi = freezed,Object? description = freezed,Object? hasAudiobook = null,}) {
  return _then(_self.copyWith(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,epochs: null == epochs ? _self.epochs : epochs // ignore: cast_nullable_to_non_nullable
as List<EpochModel>,genres: null == genres ? _self.genres : genres // ignore: cast_nullable_to_non_nullable
as List<GenreModel>,kinds: null == kinds ? _self.kinds : kinds // ignore: cast_nullable_to_non_nullable
as List<KindModel>,authors: null == authors ? _self.authors : authors // ignore: cast_nullable_to_non_nullable
as List<AuthorModel>,translators: null == translators ? _self.translators : translators // ignore: cast_nullable_to_non_nullable
as List<BookTranslator>,children: null == children ? _self.children : children // ignore: cast_nullable_to_non_nullable
as List<BookChild>,contentWarnings: null == contentWarnings ? _self.contentWarnings : contentWarnings // ignore: cast_nullable_to_non_nullable
as List<String>,audiences: null == audiences ? _self.audiences : audiences // ignore: cast_nullable_to_non_nullable
as List<String>,elevenReaderLink: freezed == elevenReaderLink ? _self.elevenReaderLink : elevenReaderLink // ignore: cast_nullable_to_non_nullable
as String?,fragment: freezed == fragment ? _self.fragment : fragment // ignore: cast_nullable_to_non_nullable
as BookFragmentData?,simpleThumb: freezed == simpleThumb ? _self.simpleThumb : simpleThumb // ignore: cast_nullable_to_non_nullable
as String?,coverThumb: freezed == coverThumb ? _self.coverThumb : coverThumb // ignore: cast_nullable_to_non_nullable
as String?,coverColor: freezed == coverColor ? _self.coverColor : coverColor // ignore: cast_nullable_to_non_nullable
as String?,coverUrl: freezed == coverUrl ? _self.coverUrl : coverUrl // ignore: cast_nullable_to_non_nullable
as String?,simpleCoverUrl: freezed == simpleCoverUrl ? _self.simpleCoverUrl : simpleCoverUrl // ignore: cast_nullable_to_non_nullable
as String?,isbnPdf: freezed == isbnPdf ? _self.isbnPdf : isbnPdf // ignore: cast_nullable_to_non_nullable
as String?,isbnEpub: freezed == isbnEpub ? _self.isbnEpub : isbnEpub // ignore: cast_nullable_to_non_nullable
as String?,isbnMobi: freezed == isbnMobi ? _self.isbnMobi : isbnMobi // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,hasAudiobook: null == hasAudiobook ? _self.hasAudiobook : hasAudiobook // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of BookModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BookFragmentDataCopyWith<$Res>? get fragment {
    if (_self.fragment == null) {
    return null;
  }

  return $BookFragmentDataCopyWith<$Res>(_self.fragment!, (value) {
    return _then(_self.copyWith(fragment: value));
  });
}
}


/// @nodoc
@JsonSerializable()

class _BookModel implements BookModel {
  const _BookModel({required this.title, required this.url, required this.slug, final  List<EpochModel> epochs = const [], final  List<GenreModel> genres = const [], final  List<KindModel> kinds = const [], final  List<AuthorModel> authors = const [], final  List<BookTranslator> translators = const [], final  List<BookChild> children = const [], @JsonKey(name: 'content_warnings') final  List<String> contentWarnings = const [], final  List<String> audiences = const [], @JsonKey(name: 'elevenreader_link') this.elevenReaderLink, @JsonKey(name: 'fragment_data') this.fragment, @JsonKey(name: 'simple_thumb') this.simpleThumb, @JsonKey(name: 'cover_thumb') this.coverThumb, @JsonKey(name: 'cover_color') this.coverColor, @JsonKey(name: 'cover') this.coverUrl, @JsonKey(name: 'simple_cover') this.simpleCoverUrl, @JsonKey(name: 'isbn_pdf') this.isbnPdf, @JsonKey(name: 'isbn_epub') this.isbnEpub, @JsonKey(name: 'isbn_mobi') this.isbnMobi, @JsonKey(name: 'abstract') this.description, @JsonKey(name: 'has_mp3_file') this.hasAudiobook = false}): _epochs = epochs,_genres = genres,_kinds = kinds,_authors = authors,_translators = translators,_children = children,_contentWarnings = contentWarnings,_audiences = audiences;
  factory _BookModel.fromJson(Map<String, dynamic> json) => _$BookModelFromJson(json);

@override final  String title;
@override final  String url;
@override final  String slug;
 final  List<EpochModel> _epochs;
@override@JsonKey() List<EpochModel> get epochs {
  if (_epochs is EqualUnmodifiableListView) return _epochs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_epochs);
}

 final  List<GenreModel> _genres;
@override@JsonKey() List<GenreModel> get genres {
  if (_genres is EqualUnmodifiableListView) return _genres;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_genres);
}

 final  List<KindModel> _kinds;
@override@JsonKey() List<KindModel> get kinds {
  if (_kinds is EqualUnmodifiableListView) return _kinds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_kinds);
}

 final  List<AuthorModel> _authors;
@override@JsonKey() List<AuthorModel> get authors {
  if (_authors is EqualUnmodifiableListView) return _authors;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_authors);
}

 final  List<BookTranslator> _translators;
@override@JsonKey() List<BookTranslator> get translators {
  if (_translators is EqualUnmodifiableListView) return _translators;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_translators);
}

 final  List<BookChild> _children;
@override@JsonKey() List<BookChild> get children {
  if (_children is EqualUnmodifiableListView) return _children;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_children);
}

 final  List<String> _contentWarnings;
@override@JsonKey(name: 'content_warnings') List<String> get contentWarnings {
  if (_contentWarnings is EqualUnmodifiableListView) return _contentWarnings;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_contentWarnings);
}

 final  List<String> _audiences;
@override@JsonKey() List<String> get audiences {
  if (_audiences is EqualUnmodifiableListView) return _audiences;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_audiences);
}

@override@JsonKey(name: 'elevenreader_link') final  String? elevenReaderLink;
@override@JsonKey(name: 'fragment_data') final  BookFragmentData? fragment;
@override@JsonKey(name: 'simple_thumb') final  String? simpleThumb;
@override@JsonKey(name: 'cover_thumb') final  String? coverThumb;
@override@JsonKey(name: 'cover_color') final  String? coverColor;
@override@JsonKey(name: 'cover') final  String? coverUrl;
@override@JsonKey(name: 'simple_cover') final  String? simpleCoverUrl;
@override@JsonKey(name: 'isbn_pdf') final  String? isbnPdf;
@override@JsonKey(name: 'isbn_epub') final  String? isbnEpub;
@override@JsonKey(name: 'isbn_mobi') final  String? isbnMobi;
@override@JsonKey(name: 'abstract') final  String? description;
@override@JsonKey(name: 'has_mp3_file') final  bool hasAudiobook;

/// Create a copy of BookModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BookModelCopyWith<_BookModel> get copyWith => __$BookModelCopyWithImpl<_BookModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BookModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BookModel&&(identical(other.title, title) || other.title == title)&&(identical(other.url, url) || other.url == url)&&(identical(other.slug, slug) || other.slug == slug)&&const DeepCollectionEquality().equals(other._epochs, _epochs)&&const DeepCollectionEquality().equals(other._genres, _genres)&&const DeepCollectionEquality().equals(other._kinds, _kinds)&&const DeepCollectionEquality().equals(other._authors, _authors)&&const DeepCollectionEquality().equals(other._translators, _translators)&&const DeepCollectionEquality().equals(other._children, _children)&&const DeepCollectionEquality().equals(other._contentWarnings, _contentWarnings)&&const DeepCollectionEquality().equals(other._audiences, _audiences)&&(identical(other.elevenReaderLink, elevenReaderLink) || other.elevenReaderLink == elevenReaderLink)&&(identical(other.fragment, fragment) || other.fragment == fragment)&&(identical(other.simpleThumb, simpleThumb) || other.simpleThumb == simpleThumb)&&(identical(other.coverThumb, coverThumb) || other.coverThumb == coverThumb)&&(identical(other.coverColor, coverColor) || other.coverColor == coverColor)&&(identical(other.coverUrl, coverUrl) || other.coverUrl == coverUrl)&&(identical(other.simpleCoverUrl, simpleCoverUrl) || other.simpleCoverUrl == simpleCoverUrl)&&(identical(other.isbnPdf, isbnPdf) || other.isbnPdf == isbnPdf)&&(identical(other.isbnEpub, isbnEpub) || other.isbnEpub == isbnEpub)&&(identical(other.isbnMobi, isbnMobi) || other.isbnMobi == isbnMobi)&&(identical(other.description, description) || other.description == description)&&(identical(other.hasAudiobook, hasAudiobook) || other.hasAudiobook == hasAudiobook));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,title,url,slug,const DeepCollectionEquality().hash(_epochs),const DeepCollectionEquality().hash(_genres),const DeepCollectionEquality().hash(_kinds),const DeepCollectionEquality().hash(_authors),const DeepCollectionEquality().hash(_translators),const DeepCollectionEquality().hash(_children),const DeepCollectionEquality().hash(_contentWarnings),const DeepCollectionEquality().hash(_audiences),elevenReaderLink,fragment,simpleThumb,coverThumb,coverColor,coverUrl,simpleCoverUrl,isbnPdf,isbnEpub,isbnMobi,description,hasAudiobook]);

@override
String toString() {
  return 'BookModel(title: $title, url: $url, slug: $slug, epochs: $epochs, genres: $genres, kinds: $kinds, authors: $authors, translators: $translators, children: $children, contentWarnings: $contentWarnings, audiences: $audiences, elevenReaderLink: $elevenReaderLink, fragment: $fragment, simpleThumb: $simpleThumb, coverThumb: $coverThumb, coverColor: $coverColor, coverUrl: $coverUrl, simpleCoverUrl: $simpleCoverUrl, isbnPdf: $isbnPdf, isbnEpub: $isbnEpub, isbnMobi: $isbnMobi, description: $description, hasAudiobook: $hasAudiobook)';
}


}

/// @nodoc
abstract mixin class _$BookModelCopyWith<$Res> implements $BookModelCopyWith<$Res> {
  factory _$BookModelCopyWith(_BookModel value, $Res Function(_BookModel) _then) = __$BookModelCopyWithImpl;
@override @useResult
$Res call({
 String title, String url, String slug, List<EpochModel> epochs, List<GenreModel> genres, List<KindModel> kinds, List<AuthorModel> authors, List<BookTranslator> translators, List<BookChild> children,@JsonKey(name: 'content_warnings') List<String> contentWarnings, List<String> audiences,@JsonKey(name: 'elevenreader_link') String? elevenReaderLink,@JsonKey(name: 'fragment_data') BookFragmentData? fragment,@JsonKey(name: 'simple_thumb') String? simpleThumb,@JsonKey(name: 'cover_thumb') String? coverThumb,@JsonKey(name: 'cover_color') String? coverColor,@JsonKey(name: 'cover') String? coverUrl,@JsonKey(name: 'simple_cover') String? simpleCoverUrl,@JsonKey(name: 'isbn_pdf') String? isbnPdf,@JsonKey(name: 'isbn_epub') String? isbnEpub,@JsonKey(name: 'isbn_mobi') String? isbnMobi,@JsonKey(name: 'abstract') String? description,@JsonKey(name: 'has_mp3_file') bool hasAudiobook
});


@override $BookFragmentDataCopyWith<$Res>? get fragment;

}
/// @nodoc
class __$BookModelCopyWithImpl<$Res>
    implements _$BookModelCopyWith<$Res> {
  __$BookModelCopyWithImpl(this._self, this._then);

  final _BookModel _self;
  final $Res Function(_BookModel) _then;

/// Create a copy of BookModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? url = null,Object? slug = null,Object? epochs = null,Object? genres = null,Object? kinds = null,Object? authors = null,Object? translators = null,Object? children = null,Object? contentWarnings = null,Object? audiences = null,Object? elevenReaderLink = freezed,Object? fragment = freezed,Object? simpleThumb = freezed,Object? coverThumb = freezed,Object? coverColor = freezed,Object? coverUrl = freezed,Object? simpleCoverUrl = freezed,Object? isbnPdf = freezed,Object? isbnEpub = freezed,Object? isbnMobi = freezed,Object? description = freezed,Object? hasAudiobook = null,}) {
  return _then(_BookModel(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,epochs: null == epochs ? _self._epochs : epochs // ignore: cast_nullable_to_non_nullable
as List<EpochModel>,genres: null == genres ? _self._genres : genres // ignore: cast_nullable_to_non_nullable
as List<GenreModel>,kinds: null == kinds ? _self._kinds : kinds // ignore: cast_nullable_to_non_nullable
as List<KindModel>,authors: null == authors ? _self._authors : authors // ignore: cast_nullable_to_non_nullable
as List<AuthorModel>,translators: null == translators ? _self._translators : translators // ignore: cast_nullable_to_non_nullable
as List<BookTranslator>,children: null == children ? _self._children : children // ignore: cast_nullable_to_non_nullable
as List<BookChild>,contentWarnings: null == contentWarnings ? _self._contentWarnings : contentWarnings // ignore: cast_nullable_to_non_nullable
as List<String>,audiences: null == audiences ? _self._audiences : audiences // ignore: cast_nullable_to_non_nullable
as List<String>,elevenReaderLink: freezed == elevenReaderLink ? _self.elevenReaderLink : elevenReaderLink // ignore: cast_nullable_to_non_nullable
as String?,fragment: freezed == fragment ? _self.fragment : fragment // ignore: cast_nullable_to_non_nullable
as BookFragmentData?,simpleThumb: freezed == simpleThumb ? _self.simpleThumb : simpleThumb // ignore: cast_nullable_to_non_nullable
as String?,coverThumb: freezed == coverThumb ? _self.coverThumb : coverThumb // ignore: cast_nullable_to_non_nullable
as String?,coverColor: freezed == coverColor ? _self.coverColor : coverColor // ignore: cast_nullable_to_non_nullable
as String?,coverUrl: freezed == coverUrl ? _self.coverUrl : coverUrl // ignore: cast_nullable_to_non_nullable
as String?,simpleCoverUrl: freezed == simpleCoverUrl ? _self.simpleCoverUrl : simpleCoverUrl // ignore: cast_nullable_to_non_nullable
as String?,isbnPdf: freezed == isbnPdf ? _self.isbnPdf : isbnPdf // ignore: cast_nullable_to_non_nullable
as String?,isbnEpub: freezed == isbnEpub ? _self.isbnEpub : isbnEpub // ignore: cast_nullable_to_non_nullable
as String?,isbnMobi: freezed == isbnMobi ? _self.isbnMobi : isbnMobi // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,hasAudiobook: null == hasAudiobook ? _self.hasAudiobook : hasAudiobook // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of BookModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BookFragmentDataCopyWith<$Res>? get fragment {
    if (_self.fragment == null) {
    return null;
  }

  return $BookFragmentDataCopyWith<$Res>(_self.fragment!, (value) {
    return _then(_self.copyWith(fragment: value));
  });
}
}


/// @nodoc
mixin _$BookFragmentData {

 String? get title; String? get html;
/// Create a copy of BookFragmentData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BookFragmentDataCopyWith<BookFragmentData> get copyWith => _$BookFragmentDataCopyWithImpl<BookFragmentData>(this as BookFragmentData, _$identity);

  /// Serializes this BookFragmentData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BookFragmentData&&(identical(other.title, title) || other.title == title)&&(identical(other.html, html) || other.html == html));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,html);

@override
String toString() {
  return 'BookFragmentData(title: $title, html: $html)';
}


}

/// @nodoc
abstract mixin class $BookFragmentDataCopyWith<$Res>  {
  factory $BookFragmentDataCopyWith(BookFragmentData value, $Res Function(BookFragmentData) _then) = _$BookFragmentDataCopyWithImpl;
@useResult
$Res call({
 String? title, String? html
});




}
/// @nodoc
class _$BookFragmentDataCopyWithImpl<$Res>
    implements $BookFragmentDataCopyWith<$Res> {
  _$BookFragmentDataCopyWithImpl(this._self, this._then);

  final BookFragmentData _self;
  final $Res Function(BookFragmentData) _then;

/// Create a copy of BookFragmentData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = freezed,Object? html = freezed,}) {
  return _then(_self.copyWith(
title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,html: freezed == html ? _self.html : html // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _BookFragmentData implements BookFragmentData {
  const _BookFragmentData({this.title, this.html});
  factory _BookFragmentData.fromJson(Map<String, dynamic> json) => _$BookFragmentDataFromJson(json);

@override final  String? title;
@override final  String? html;

/// Create a copy of BookFragmentData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BookFragmentDataCopyWith<_BookFragmentData> get copyWith => __$BookFragmentDataCopyWithImpl<_BookFragmentData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BookFragmentDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BookFragmentData&&(identical(other.title, title) || other.title == title)&&(identical(other.html, html) || other.html == html));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,html);

@override
String toString() {
  return 'BookFragmentData(title: $title, html: $html)';
}


}

/// @nodoc
abstract mixin class _$BookFragmentDataCopyWith<$Res> implements $BookFragmentDataCopyWith<$Res> {
  factory _$BookFragmentDataCopyWith(_BookFragmentData value, $Res Function(_BookFragmentData) _then) = __$BookFragmentDataCopyWithImpl;
@override @useResult
$Res call({
 String? title, String? html
});




}
/// @nodoc
class __$BookFragmentDataCopyWithImpl<$Res>
    implements _$BookFragmentDataCopyWith<$Res> {
  __$BookFragmentDataCopyWithImpl(this._self, this._then);

  final _BookFragmentData _self;
  final $Res Function(_BookFragmentData) _then;

/// Create a copy of BookFragmentData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = freezed,Object? html = freezed,}) {
  return _then(_BookFragmentData(
title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,html: freezed == html ? _self.html : html // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$BookTranslator {

 String? get name;
/// Create a copy of BookTranslator
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BookTranslatorCopyWith<BookTranslator> get copyWith => _$BookTranslatorCopyWithImpl<BookTranslator>(this as BookTranslator, _$identity);

  /// Serializes this BookTranslator to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BookTranslator&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name);

@override
String toString() {
  return 'BookTranslator(name: $name)';
}


}

/// @nodoc
abstract mixin class $BookTranslatorCopyWith<$Res>  {
  factory $BookTranslatorCopyWith(BookTranslator value, $Res Function(BookTranslator) _then) = _$BookTranslatorCopyWithImpl;
@useResult
$Res call({
 String? name
});




}
/// @nodoc
class _$BookTranslatorCopyWithImpl<$Res>
    implements $BookTranslatorCopyWith<$Res> {
  _$BookTranslatorCopyWithImpl(this._self, this._then);

  final BookTranslator _self;
  final $Res Function(BookTranslator) _then;

/// Create a copy of BookTranslator
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = freezed,}) {
  return _then(_self.copyWith(
name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _BookTranslator implements BookTranslator {
  const _BookTranslator({this.name});
  factory _BookTranslator.fromJson(Map<String, dynamic> json) => _$BookTranslatorFromJson(json);

@override final  String? name;

/// Create a copy of BookTranslator
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BookTranslatorCopyWith<_BookTranslator> get copyWith => __$BookTranslatorCopyWithImpl<_BookTranslator>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BookTranslatorToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BookTranslator&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name);

@override
String toString() {
  return 'BookTranslator(name: $name)';
}


}

/// @nodoc
abstract mixin class _$BookTranslatorCopyWith<$Res> implements $BookTranslatorCopyWith<$Res> {
  factory _$BookTranslatorCopyWith(_BookTranslator value, $Res Function(_BookTranslator) _then) = __$BookTranslatorCopyWithImpl;
@override @useResult
$Res call({
 String? name
});




}
/// @nodoc
class __$BookTranslatorCopyWithImpl<$Res>
    implements _$BookTranslatorCopyWith<$Res> {
  __$BookTranslatorCopyWithImpl(this._self, this._then);

  final _BookTranslator _self;
  final $Res Function(_BookTranslator) _then;

/// Create a copy of BookTranslator
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = freezed,}) {
  return _then(_BookTranslator(
name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$BookChild {

 String get title; String get slug;
/// Create a copy of BookChild
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BookChildCopyWith<BookChild> get copyWith => _$BookChildCopyWithImpl<BookChild>(this as BookChild, _$identity);

  /// Serializes this BookChild to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BookChild&&(identical(other.title, title) || other.title == title)&&(identical(other.slug, slug) || other.slug == slug));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,slug);

@override
String toString() {
  return 'BookChild(title: $title, slug: $slug)';
}


}

/// @nodoc
abstract mixin class $BookChildCopyWith<$Res>  {
  factory $BookChildCopyWith(BookChild value, $Res Function(BookChild) _then) = _$BookChildCopyWithImpl;
@useResult
$Res call({
 String title, String slug
});




}
/// @nodoc
class _$BookChildCopyWithImpl<$Res>
    implements $BookChildCopyWith<$Res> {
  _$BookChildCopyWithImpl(this._self, this._then);

  final BookChild _self;
  final $Res Function(BookChild) _then;

/// Create a copy of BookChild
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? slug = null,}) {
  return _then(_self.copyWith(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _BookChild implements BookChild {
  const _BookChild({required this.title, required this.slug});
  factory _BookChild.fromJson(Map<String, dynamic> json) => _$BookChildFromJson(json);

@override final  String title;
@override final  String slug;

/// Create a copy of BookChild
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BookChildCopyWith<_BookChild> get copyWith => __$BookChildCopyWithImpl<_BookChild>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BookChildToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BookChild&&(identical(other.title, title) || other.title == title)&&(identical(other.slug, slug) || other.slug == slug));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,slug);

@override
String toString() {
  return 'BookChild(title: $title, slug: $slug)';
}


}

/// @nodoc
abstract mixin class _$BookChildCopyWith<$Res> implements $BookChildCopyWith<$Res> {
  factory _$BookChildCopyWith(_BookChild value, $Res Function(_BookChild) _then) = __$BookChildCopyWithImpl;
@override @useResult
$Res call({
 String title, String slug
});




}
/// @nodoc
class __$BookChildCopyWithImpl<$Res>
    implements _$BookChildCopyWith<$Res> {
  __$BookChildCopyWithImpl(this._self, this._then);

  final _BookChild _self;
  final $Res Function(_BookChild) _then;

/// Create a copy of BookChild
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? slug = null,}) {
  return _then(_BookChild(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
