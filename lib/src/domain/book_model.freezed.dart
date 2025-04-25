// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'book_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

BookModel _$BookModelFromJson(Map<String, dynamic> json) {
  return _BookModel.fromJson(json);
}

/// @nodoc
mixin _$BookModel {
  String get title => throw _privateConstructorUsedError;
  String get url => throw _privateConstructorUsedError;
  String get slug => throw _privateConstructorUsedError;
  List<EpochModel> get epochs => throw _privateConstructorUsedError;
  List<GenreModel> get genres => throw _privateConstructorUsedError;
  List<KindModel> get kinds => throw _privateConstructorUsedError;
  List<AuthorModel> get authors => throw _privateConstructorUsedError;
  List<BookTranslator> get translators => throw _privateConstructorUsedError;
  @JsonKey(name: 'fragment_data')
  BookFragmentData? get fragment => throw _privateConstructorUsedError;
  @JsonKey(name: 'simple_thumb')
  String? get simpleThumb => throw _privateConstructorUsedError;
  @JsonKey(name: 'cover_thumb')
  String? get coverThumb => throw _privateConstructorUsedError;
  @JsonKey(name: 'cover_color')
  String? get coverColor => throw _privateConstructorUsedError;
  @JsonKey(name: 'cover')
  String? get coverUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'simple_cover')
  String? get simpleCoverUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'isbn_pdf')
  String? get isbnPdf => throw _privateConstructorUsedError;
  @JsonKey(name: 'isbn_epub')
  String? get isbnEpub => throw _privateConstructorUsedError;
  @JsonKey(name: 'isbn_mobi')
  String? get isbnMobi => throw _privateConstructorUsedError;
  @JsonKey(name: 'abstract')
  String? get description => throw _privateConstructorUsedError;
  @JsonKey(name: 'has_mp3_file')
  bool get hasAudiobook => throw _privateConstructorUsedError;

  /// Serializes this BookModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BookModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BookModelCopyWith<BookModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BookModelCopyWith<$Res> {
  factory $BookModelCopyWith(BookModel value, $Res Function(BookModel) then) =
      _$BookModelCopyWithImpl<$Res, BookModel>;
  @useResult
  $Res call(
      {String title,
      String url,
      String slug,
      List<EpochModel> epochs,
      List<GenreModel> genres,
      List<KindModel> kinds,
      List<AuthorModel> authors,
      List<BookTranslator> translators,
      @JsonKey(name: 'fragment_data') BookFragmentData? fragment,
      @JsonKey(name: 'simple_thumb') String? simpleThumb,
      @JsonKey(name: 'cover_thumb') String? coverThumb,
      @JsonKey(name: 'cover_color') String? coverColor,
      @JsonKey(name: 'cover') String? coverUrl,
      @JsonKey(name: 'simple_cover') String? simpleCoverUrl,
      @JsonKey(name: 'isbn_pdf') String? isbnPdf,
      @JsonKey(name: 'isbn_epub') String? isbnEpub,
      @JsonKey(name: 'isbn_mobi') String? isbnMobi,
      @JsonKey(name: 'abstract') String? description,
      @JsonKey(name: 'has_mp3_file') bool hasAudiobook});

  $BookFragmentDataCopyWith<$Res>? get fragment;
}

/// @nodoc
class _$BookModelCopyWithImpl<$Res, $Val extends BookModel>
    implements $BookModelCopyWith<$Res> {
  _$BookModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BookModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? url = null,
    Object? slug = null,
    Object? epochs = null,
    Object? genres = null,
    Object? kinds = null,
    Object? authors = null,
    Object? translators = null,
    Object? fragment = freezed,
    Object? simpleThumb = freezed,
    Object? coverThumb = freezed,
    Object? coverColor = freezed,
    Object? coverUrl = freezed,
    Object? simpleCoverUrl = freezed,
    Object? isbnPdf = freezed,
    Object? isbnEpub = freezed,
    Object? isbnMobi = freezed,
    Object? description = freezed,
    Object? hasAudiobook = null,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      slug: null == slug
          ? _value.slug
          : slug // ignore: cast_nullable_to_non_nullable
              as String,
      epochs: null == epochs
          ? _value.epochs
          : epochs // ignore: cast_nullable_to_non_nullable
              as List<EpochModel>,
      genres: null == genres
          ? _value.genres
          : genres // ignore: cast_nullable_to_non_nullable
              as List<GenreModel>,
      kinds: null == kinds
          ? _value.kinds
          : kinds // ignore: cast_nullable_to_non_nullable
              as List<KindModel>,
      authors: null == authors
          ? _value.authors
          : authors // ignore: cast_nullable_to_non_nullable
              as List<AuthorModel>,
      translators: null == translators
          ? _value.translators
          : translators // ignore: cast_nullable_to_non_nullable
              as List<BookTranslator>,
      fragment: freezed == fragment
          ? _value.fragment
          : fragment // ignore: cast_nullable_to_non_nullable
              as BookFragmentData?,
      simpleThumb: freezed == simpleThumb
          ? _value.simpleThumb
          : simpleThumb // ignore: cast_nullable_to_non_nullable
              as String?,
      coverThumb: freezed == coverThumb
          ? _value.coverThumb
          : coverThumb // ignore: cast_nullable_to_non_nullable
              as String?,
      coverColor: freezed == coverColor
          ? _value.coverColor
          : coverColor // ignore: cast_nullable_to_non_nullable
              as String?,
      coverUrl: freezed == coverUrl
          ? _value.coverUrl
          : coverUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      simpleCoverUrl: freezed == simpleCoverUrl
          ? _value.simpleCoverUrl
          : simpleCoverUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      isbnPdf: freezed == isbnPdf
          ? _value.isbnPdf
          : isbnPdf // ignore: cast_nullable_to_non_nullable
              as String?,
      isbnEpub: freezed == isbnEpub
          ? _value.isbnEpub
          : isbnEpub // ignore: cast_nullable_to_non_nullable
              as String?,
      isbnMobi: freezed == isbnMobi
          ? _value.isbnMobi
          : isbnMobi // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      hasAudiobook: null == hasAudiobook
          ? _value.hasAudiobook
          : hasAudiobook // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }

  /// Create a copy of BookModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BookFragmentDataCopyWith<$Res>? get fragment {
    if (_value.fragment == null) {
      return null;
    }

    return $BookFragmentDataCopyWith<$Res>(_value.fragment!, (value) {
      return _then(_value.copyWith(fragment: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$BookModelImplCopyWith<$Res>
    implements $BookModelCopyWith<$Res> {
  factory _$$BookModelImplCopyWith(
          _$BookModelImpl value, $Res Function(_$BookModelImpl) then) =
      __$$BookModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String title,
      String url,
      String slug,
      List<EpochModel> epochs,
      List<GenreModel> genres,
      List<KindModel> kinds,
      List<AuthorModel> authors,
      List<BookTranslator> translators,
      @JsonKey(name: 'fragment_data') BookFragmentData? fragment,
      @JsonKey(name: 'simple_thumb') String? simpleThumb,
      @JsonKey(name: 'cover_thumb') String? coverThumb,
      @JsonKey(name: 'cover_color') String? coverColor,
      @JsonKey(name: 'cover') String? coverUrl,
      @JsonKey(name: 'simple_cover') String? simpleCoverUrl,
      @JsonKey(name: 'isbn_pdf') String? isbnPdf,
      @JsonKey(name: 'isbn_epub') String? isbnEpub,
      @JsonKey(name: 'isbn_mobi') String? isbnMobi,
      @JsonKey(name: 'abstract') String? description,
      @JsonKey(name: 'has_mp3_file') bool hasAudiobook});

  @override
  $BookFragmentDataCopyWith<$Res>? get fragment;
}

/// @nodoc
class __$$BookModelImplCopyWithImpl<$Res>
    extends _$BookModelCopyWithImpl<$Res, _$BookModelImpl>
    implements _$$BookModelImplCopyWith<$Res> {
  __$$BookModelImplCopyWithImpl(
      _$BookModelImpl _value, $Res Function(_$BookModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of BookModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? url = null,
    Object? slug = null,
    Object? epochs = null,
    Object? genres = null,
    Object? kinds = null,
    Object? authors = null,
    Object? translators = null,
    Object? fragment = freezed,
    Object? simpleThumb = freezed,
    Object? coverThumb = freezed,
    Object? coverColor = freezed,
    Object? coverUrl = freezed,
    Object? simpleCoverUrl = freezed,
    Object? isbnPdf = freezed,
    Object? isbnEpub = freezed,
    Object? isbnMobi = freezed,
    Object? description = freezed,
    Object? hasAudiobook = null,
  }) {
    return _then(_$BookModelImpl(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      slug: null == slug
          ? _value.slug
          : slug // ignore: cast_nullable_to_non_nullable
              as String,
      epochs: null == epochs
          ? _value._epochs
          : epochs // ignore: cast_nullable_to_non_nullable
              as List<EpochModel>,
      genres: null == genres
          ? _value._genres
          : genres // ignore: cast_nullable_to_non_nullable
              as List<GenreModel>,
      kinds: null == kinds
          ? _value._kinds
          : kinds // ignore: cast_nullable_to_non_nullable
              as List<KindModel>,
      authors: null == authors
          ? _value._authors
          : authors // ignore: cast_nullable_to_non_nullable
              as List<AuthorModel>,
      translators: null == translators
          ? _value._translators
          : translators // ignore: cast_nullable_to_non_nullable
              as List<BookTranslator>,
      fragment: freezed == fragment
          ? _value.fragment
          : fragment // ignore: cast_nullable_to_non_nullable
              as BookFragmentData?,
      simpleThumb: freezed == simpleThumb
          ? _value.simpleThumb
          : simpleThumb // ignore: cast_nullable_to_non_nullable
              as String?,
      coverThumb: freezed == coverThumb
          ? _value.coverThumb
          : coverThumb // ignore: cast_nullable_to_non_nullable
              as String?,
      coverColor: freezed == coverColor
          ? _value.coverColor
          : coverColor // ignore: cast_nullable_to_non_nullable
              as String?,
      coverUrl: freezed == coverUrl
          ? _value.coverUrl
          : coverUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      simpleCoverUrl: freezed == simpleCoverUrl
          ? _value.simpleCoverUrl
          : simpleCoverUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      isbnPdf: freezed == isbnPdf
          ? _value.isbnPdf
          : isbnPdf // ignore: cast_nullable_to_non_nullable
              as String?,
      isbnEpub: freezed == isbnEpub
          ? _value.isbnEpub
          : isbnEpub // ignore: cast_nullable_to_non_nullable
              as String?,
      isbnMobi: freezed == isbnMobi
          ? _value.isbnMobi
          : isbnMobi // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      hasAudiobook: null == hasAudiobook
          ? _value.hasAudiobook
          : hasAudiobook // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BookModelImpl implements _BookModel {
  const _$BookModelImpl(
      {required this.title,
      required this.url,
      required this.slug,
      final List<EpochModel> epochs = const [],
      final List<GenreModel> genres = const [],
      final List<KindModel> kinds = const [],
      final List<AuthorModel> authors = const [],
      final List<BookTranslator> translators = const [],
      @JsonKey(name: 'fragment_data') this.fragment,
      @JsonKey(name: 'simple_thumb') this.simpleThumb,
      @JsonKey(name: 'cover_thumb') this.coverThumb,
      @JsonKey(name: 'cover_color') this.coverColor,
      @JsonKey(name: 'cover') this.coverUrl,
      @JsonKey(name: 'simple_cover') this.simpleCoverUrl,
      @JsonKey(name: 'isbn_pdf') this.isbnPdf,
      @JsonKey(name: 'isbn_epub') this.isbnEpub,
      @JsonKey(name: 'isbn_mobi') this.isbnMobi,
      @JsonKey(name: 'abstract') this.description,
      @JsonKey(name: 'has_mp3_file') this.hasAudiobook = false})
      : _epochs = epochs,
        _genres = genres,
        _kinds = kinds,
        _authors = authors,
        _translators = translators;

  factory _$BookModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$BookModelImplFromJson(json);

  @override
  final String title;
  @override
  final String url;
  @override
  final String slug;
  final List<EpochModel> _epochs;
  @override
  @JsonKey()
  List<EpochModel> get epochs {
    if (_epochs is EqualUnmodifiableListView) return _epochs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_epochs);
  }

  final List<GenreModel> _genres;
  @override
  @JsonKey()
  List<GenreModel> get genres {
    if (_genres is EqualUnmodifiableListView) return _genres;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_genres);
  }

  final List<KindModel> _kinds;
  @override
  @JsonKey()
  List<KindModel> get kinds {
    if (_kinds is EqualUnmodifiableListView) return _kinds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_kinds);
  }

  final List<AuthorModel> _authors;
  @override
  @JsonKey()
  List<AuthorModel> get authors {
    if (_authors is EqualUnmodifiableListView) return _authors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_authors);
  }

  final List<BookTranslator> _translators;
  @override
  @JsonKey()
  List<BookTranslator> get translators {
    if (_translators is EqualUnmodifiableListView) return _translators;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_translators);
  }

  @override
  @JsonKey(name: 'fragment_data')
  final BookFragmentData? fragment;
  @override
  @JsonKey(name: 'simple_thumb')
  final String? simpleThumb;
  @override
  @JsonKey(name: 'cover_thumb')
  final String? coverThumb;
  @override
  @JsonKey(name: 'cover_color')
  final String? coverColor;
  @override
  @JsonKey(name: 'cover')
  final String? coverUrl;
  @override
  @JsonKey(name: 'simple_cover')
  final String? simpleCoverUrl;
  @override
  @JsonKey(name: 'isbn_pdf')
  final String? isbnPdf;
  @override
  @JsonKey(name: 'isbn_epub')
  final String? isbnEpub;
  @override
  @JsonKey(name: 'isbn_mobi')
  final String? isbnMobi;
  @override
  @JsonKey(name: 'abstract')
  final String? description;
  @override
  @JsonKey(name: 'has_mp3_file')
  final bool hasAudiobook;

  @override
  String toString() {
    return 'BookModel(title: $title, url: $url, slug: $slug, epochs: $epochs, genres: $genres, kinds: $kinds, authors: $authors, translators: $translators, fragment: $fragment, simpleThumb: $simpleThumb, coverThumb: $coverThumb, coverColor: $coverColor, coverUrl: $coverUrl, simpleCoverUrl: $simpleCoverUrl, isbnPdf: $isbnPdf, isbnEpub: $isbnEpub, isbnMobi: $isbnMobi, description: $description, hasAudiobook: $hasAudiobook)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BookModelImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.slug, slug) || other.slug == slug) &&
            const DeepCollectionEquality().equals(other._epochs, _epochs) &&
            const DeepCollectionEquality().equals(other._genres, _genres) &&
            const DeepCollectionEquality().equals(other._kinds, _kinds) &&
            const DeepCollectionEquality().equals(other._authors, _authors) &&
            const DeepCollectionEquality()
                .equals(other._translators, _translators) &&
            (identical(other.fragment, fragment) ||
                other.fragment == fragment) &&
            (identical(other.simpleThumb, simpleThumb) ||
                other.simpleThumb == simpleThumb) &&
            (identical(other.coverThumb, coverThumb) ||
                other.coverThumb == coverThumb) &&
            (identical(other.coverColor, coverColor) ||
                other.coverColor == coverColor) &&
            (identical(other.coverUrl, coverUrl) ||
                other.coverUrl == coverUrl) &&
            (identical(other.simpleCoverUrl, simpleCoverUrl) ||
                other.simpleCoverUrl == simpleCoverUrl) &&
            (identical(other.isbnPdf, isbnPdf) || other.isbnPdf == isbnPdf) &&
            (identical(other.isbnEpub, isbnEpub) ||
                other.isbnEpub == isbnEpub) &&
            (identical(other.isbnMobi, isbnMobi) ||
                other.isbnMobi == isbnMobi) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.hasAudiobook, hasAudiobook) ||
                other.hasAudiobook == hasAudiobook));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        title,
        url,
        slug,
        const DeepCollectionEquality().hash(_epochs),
        const DeepCollectionEquality().hash(_genres),
        const DeepCollectionEquality().hash(_kinds),
        const DeepCollectionEquality().hash(_authors),
        const DeepCollectionEquality().hash(_translators),
        fragment,
        simpleThumb,
        coverThumb,
        coverColor,
        coverUrl,
        simpleCoverUrl,
        isbnPdf,
        isbnEpub,
        isbnMobi,
        description,
        hasAudiobook
      ]);

  /// Create a copy of BookModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BookModelImplCopyWith<_$BookModelImpl> get copyWith =>
      __$$BookModelImplCopyWithImpl<_$BookModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BookModelImplToJson(
      this,
    );
  }
}

abstract class _BookModel implements BookModel {
  const factory _BookModel(
          {required final String title,
          required final String url,
          required final String slug,
          final List<EpochModel> epochs,
          final List<GenreModel> genres,
          final List<KindModel> kinds,
          final List<AuthorModel> authors,
          final List<BookTranslator> translators,
          @JsonKey(name: 'fragment_data') final BookFragmentData? fragment,
          @JsonKey(name: 'simple_thumb') final String? simpleThumb,
          @JsonKey(name: 'cover_thumb') final String? coverThumb,
          @JsonKey(name: 'cover_color') final String? coverColor,
          @JsonKey(name: 'cover') final String? coverUrl,
          @JsonKey(name: 'simple_cover') final String? simpleCoverUrl,
          @JsonKey(name: 'isbn_pdf') final String? isbnPdf,
          @JsonKey(name: 'isbn_epub') final String? isbnEpub,
          @JsonKey(name: 'isbn_mobi') final String? isbnMobi,
          @JsonKey(name: 'abstract') final String? description,
          @JsonKey(name: 'has_mp3_file') final bool hasAudiobook}) =
      _$BookModelImpl;

  factory _BookModel.fromJson(Map<String, dynamic> json) =
      _$BookModelImpl.fromJson;

  @override
  String get title;
  @override
  String get url;
  @override
  String get slug;
  @override
  List<EpochModel> get epochs;
  @override
  List<GenreModel> get genres;
  @override
  List<KindModel> get kinds;
  @override
  List<AuthorModel> get authors;
  @override
  List<BookTranslator> get translators;
  @override
  @JsonKey(name: 'fragment_data')
  BookFragmentData? get fragment;
  @override
  @JsonKey(name: 'simple_thumb')
  String? get simpleThumb;
  @override
  @JsonKey(name: 'cover_thumb')
  String? get coverThumb;
  @override
  @JsonKey(name: 'cover_color')
  String? get coverColor;
  @override
  @JsonKey(name: 'cover')
  String? get coverUrl;
  @override
  @JsonKey(name: 'simple_cover')
  String? get simpleCoverUrl;
  @override
  @JsonKey(name: 'isbn_pdf')
  String? get isbnPdf;
  @override
  @JsonKey(name: 'isbn_epub')
  String? get isbnEpub;
  @override
  @JsonKey(name: 'isbn_mobi')
  String? get isbnMobi;
  @override
  @JsonKey(name: 'abstract')
  String? get description;
  @override
  @JsonKey(name: 'has_mp3_file')
  bool get hasAudiobook;

  /// Create a copy of BookModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BookModelImplCopyWith<_$BookModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

BookFragmentData _$BookFragmentDataFromJson(Map<String, dynamic> json) {
  return _BookFragmentData.fromJson(json);
}

/// @nodoc
mixin _$BookFragmentData {
  String? get title => throw _privateConstructorUsedError;
  String? get html => throw _privateConstructorUsedError;

  /// Serializes this BookFragmentData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BookFragmentData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BookFragmentDataCopyWith<BookFragmentData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BookFragmentDataCopyWith<$Res> {
  factory $BookFragmentDataCopyWith(
          BookFragmentData value, $Res Function(BookFragmentData) then) =
      _$BookFragmentDataCopyWithImpl<$Res, BookFragmentData>;
  @useResult
  $Res call({String? title, String? html});
}

/// @nodoc
class _$BookFragmentDataCopyWithImpl<$Res, $Val extends BookFragmentData>
    implements $BookFragmentDataCopyWith<$Res> {
  _$BookFragmentDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BookFragmentData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = freezed,
    Object? html = freezed,
  }) {
    return _then(_value.copyWith(
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      html: freezed == html
          ? _value.html
          : html // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BookFragmentDataImplCopyWith<$Res>
    implements $BookFragmentDataCopyWith<$Res> {
  factory _$$BookFragmentDataImplCopyWith(_$BookFragmentDataImpl value,
          $Res Function(_$BookFragmentDataImpl) then) =
      __$$BookFragmentDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? title, String? html});
}

/// @nodoc
class __$$BookFragmentDataImplCopyWithImpl<$Res>
    extends _$BookFragmentDataCopyWithImpl<$Res, _$BookFragmentDataImpl>
    implements _$$BookFragmentDataImplCopyWith<$Res> {
  __$$BookFragmentDataImplCopyWithImpl(_$BookFragmentDataImpl _value,
      $Res Function(_$BookFragmentDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of BookFragmentData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = freezed,
    Object? html = freezed,
  }) {
    return _then(_$BookFragmentDataImpl(
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      html: freezed == html
          ? _value.html
          : html // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BookFragmentDataImpl implements _BookFragmentData {
  const _$BookFragmentDataImpl({this.title, this.html});

  factory _$BookFragmentDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$BookFragmentDataImplFromJson(json);

  @override
  final String? title;
  @override
  final String? html;

  @override
  String toString() {
    return 'BookFragmentData(title: $title, html: $html)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BookFragmentDataImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.html, html) || other.html == html));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, title, html);

  /// Create a copy of BookFragmentData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BookFragmentDataImplCopyWith<_$BookFragmentDataImpl> get copyWith =>
      __$$BookFragmentDataImplCopyWithImpl<_$BookFragmentDataImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BookFragmentDataImplToJson(
      this,
    );
  }
}

abstract class _BookFragmentData implements BookFragmentData {
  const factory _BookFragmentData({final String? title, final String? html}) =
      _$BookFragmentDataImpl;

  factory _BookFragmentData.fromJson(Map<String, dynamic> json) =
      _$BookFragmentDataImpl.fromJson;

  @override
  String? get title;
  @override
  String? get html;

  /// Create a copy of BookFragmentData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BookFragmentDataImplCopyWith<_$BookFragmentDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

BookTranslator _$BookTranslatorFromJson(Map<String, dynamic> json) {
  return _BookTranslator.fromJson(json);
}

/// @nodoc
mixin _$BookTranslator {
  String? get name => throw _privateConstructorUsedError;

  /// Serializes this BookTranslator to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BookTranslator
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BookTranslatorCopyWith<BookTranslator> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BookTranslatorCopyWith<$Res> {
  factory $BookTranslatorCopyWith(
          BookTranslator value, $Res Function(BookTranslator) then) =
      _$BookTranslatorCopyWithImpl<$Res, BookTranslator>;
  @useResult
  $Res call({String? name});
}

/// @nodoc
class _$BookTranslatorCopyWithImpl<$Res, $Val extends BookTranslator>
    implements $BookTranslatorCopyWith<$Res> {
  _$BookTranslatorCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BookTranslator
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
  }) {
    return _then(_value.copyWith(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BookTranslatorImplCopyWith<$Res>
    implements $BookTranslatorCopyWith<$Res> {
  factory _$$BookTranslatorImplCopyWith(_$BookTranslatorImpl value,
          $Res Function(_$BookTranslatorImpl) then) =
      __$$BookTranslatorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? name});
}

/// @nodoc
class __$$BookTranslatorImplCopyWithImpl<$Res>
    extends _$BookTranslatorCopyWithImpl<$Res, _$BookTranslatorImpl>
    implements _$$BookTranslatorImplCopyWith<$Res> {
  __$$BookTranslatorImplCopyWithImpl(
      _$BookTranslatorImpl _value, $Res Function(_$BookTranslatorImpl) _then)
      : super(_value, _then);

  /// Create a copy of BookTranslator
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
  }) {
    return _then(_$BookTranslatorImpl(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BookTranslatorImpl implements _BookTranslator {
  const _$BookTranslatorImpl({this.name});

  factory _$BookTranslatorImpl.fromJson(Map<String, dynamic> json) =>
      _$$BookTranslatorImplFromJson(json);

  @override
  final String? name;

  @override
  String toString() {
    return 'BookTranslator(name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BookTranslatorImpl &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name);

  /// Create a copy of BookTranslator
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BookTranslatorImplCopyWith<_$BookTranslatorImpl> get copyWith =>
      __$$BookTranslatorImplCopyWithImpl<_$BookTranslatorImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BookTranslatorImplToJson(
      this,
    );
  }
}

abstract class _BookTranslator implements BookTranslator {
  const factory _BookTranslator({final String? name}) = _$BookTranslatorImpl;

  factory _BookTranslator.fromJson(Map<String, dynamic> json) =
      _$BookTranslatorImpl.fromJson;

  @override
  String? get name;

  /// Create a copy of BookTranslator
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BookTranslatorImplCopyWith<_$BookTranslatorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
