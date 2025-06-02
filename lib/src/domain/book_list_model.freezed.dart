// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'book_list_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

BookListModel _$BookListModelFromJson(Map<String, dynamic> json) {
  return _BookListModel.fromJson(json);
}

/// @nodoc
mixin _$BookListModel {
  String get name => throw _privateConstructorUsedError;
  String get slug => throw _privateConstructorUsedError;
  List<String> get books => throw _privateConstructorUsedError;

  /// Serializes this BookListModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BookListModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BookListModelCopyWith<BookListModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BookListModelCopyWith<$Res> {
  factory $BookListModelCopyWith(
          BookListModel value, $Res Function(BookListModel) then) =
      _$BookListModelCopyWithImpl<$Res, BookListModel>;
  @useResult
  $Res call({String name, String slug, List<String> books});
}

/// @nodoc
class _$BookListModelCopyWithImpl<$Res, $Val extends BookListModel>
    implements $BookListModelCopyWith<$Res> {
  _$BookListModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BookListModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? slug = null,
    Object? books = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      slug: null == slug
          ? _value.slug
          : slug // ignore: cast_nullable_to_non_nullable
              as String,
      books: null == books
          ? _value.books
          : books // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BookListModelImplCopyWith<$Res>
    implements $BookListModelCopyWith<$Res> {
  factory _$$BookListModelImplCopyWith(
          _$BookListModelImpl value, $Res Function(_$BookListModelImpl) then) =
      __$$BookListModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String slug, List<String> books});
}

/// @nodoc
class __$$BookListModelImplCopyWithImpl<$Res>
    extends _$BookListModelCopyWithImpl<$Res, _$BookListModelImpl>
    implements _$$BookListModelImplCopyWith<$Res> {
  __$$BookListModelImplCopyWithImpl(
      _$BookListModelImpl _value, $Res Function(_$BookListModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of BookListModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? slug = null,
    Object? books = null,
  }) {
    return _then(_$BookListModelImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      slug: null == slug
          ? _value.slug
          : slug // ignore: cast_nullable_to_non_nullable
              as String,
      books: null == books
          ? _value._books
          : books // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BookListModelImpl implements _BookListModel {
  const _$BookListModelImpl(
      {required this.name,
      required this.slug,
      required final List<String> books})
      : _books = books;

  factory _$BookListModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$BookListModelImplFromJson(json);

  @override
  final String name;
  @override
  final String slug;
  final List<String> _books;
  @override
  List<String> get books {
    if (_books is EqualUnmodifiableListView) return _books;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_books);
  }

  @override
  String toString() {
    return 'BookListModel(name: $name, slug: $slug, books: $books)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BookListModelImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.slug, slug) || other.slug == slug) &&
            const DeepCollectionEquality().equals(other._books, _books));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, name, slug, const DeepCollectionEquality().hash(_books));

  /// Create a copy of BookListModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BookListModelImplCopyWith<_$BookListModelImpl> get copyWith =>
      __$$BookListModelImplCopyWithImpl<_$BookListModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BookListModelImplToJson(
      this,
    );
  }
}

abstract class _BookListModel implements BookListModel {
  const factory _BookListModel(
      {required final String name,
      required final String slug,
      required final List<String> books}) = _$BookListModelImpl;

  factory _BookListModel.fromJson(Map<String, dynamic> json) =
      _$BookListModelImpl.fromJson;

  @override
  String get name;
  @override
  String get slug;
  @override
  List<String> get books;

  /// Create a copy of BookListModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BookListModelImplCopyWith<_$BookListModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
