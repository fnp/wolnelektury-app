// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'single_book_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SingleBookState {
  bool get isLoading => throw _privateConstructorUsedError;
  BookModel? get book => throw _privateConstructorUsedError;

  /// Create a copy of SingleBookState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SingleBookStateCopyWith<SingleBookState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SingleBookStateCopyWith<$Res> {
  factory $SingleBookStateCopyWith(
          SingleBookState value, $Res Function(SingleBookState) then) =
      _$SingleBookStateCopyWithImpl<$Res, SingleBookState>;
  @useResult
  $Res call({bool isLoading, BookModel? book});

  $BookModelCopyWith<$Res>? get book;
}

/// @nodoc
class _$SingleBookStateCopyWithImpl<$Res, $Val extends SingleBookState>
    implements $SingleBookStateCopyWith<$Res> {
  _$SingleBookStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SingleBookState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? book = freezed,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      book: freezed == book
          ? _value.book
          : book // ignore: cast_nullable_to_non_nullable
              as BookModel?,
    ) as $Val);
  }

  /// Create a copy of SingleBookState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BookModelCopyWith<$Res>? get book {
    if (_value.book == null) {
      return null;
    }

    return $BookModelCopyWith<$Res>(_value.book!, (value) {
      return _then(_value.copyWith(book: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SingleBookStateImplCopyWith<$Res>
    implements $SingleBookStateCopyWith<$Res> {
  factory _$$SingleBookStateImplCopyWith(_$SingleBookStateImpl value,
          $Res Function(_$SingleBookStateImpl) then) =
      __$$SingleBookStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isLoading, BookModel? book});

  @override
  $BookModelCopyWith<$Res>? get book;
}

/// @nodoc
class __$$SingleBookStateImplCopyWithImpl<$Res>
    extends _$SingleBookStateCopyWithImpl<$Res, _$SingleBookStateImpl>
    implements _$$SingleBookStateImplCopyWith<$Res> {
  __$$SingleBookStateImplCopyWithImpl(
      _$SingleBookStateImpl _value, $Res Function(_$SingleBookStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of SingleBookState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? book = freezed,
  }) {
    return _then(_$SingleBookStateImpl(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      book: freezed == book
          ? _value.book
          : book // ignore: cast_nullable_to_non_nullable
              as BookModel?,
    ));
  }
}

/// @nodoc

class _$SingleBookStateImpl implements _SingleBookState {
  const _$SingleBookStateImpl({this.isLoading = false, this.book});

  @override
  @JsonKey()
  final bool isLoading;
  @override
  final BookModel? book;

  @override
  String toString() {
    return 'SingleBookState(isLoading: $isLoading, book: $book)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SingleBookStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.book, book) || other.book == book));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isLoading, book);

  /// Create a copy of SingleBookState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SingleBookStateImplCopyWith<_$SingleBookStateImpl> get copyWith =>
      __$$SingleBookStateImplCopyWithImpl<_$SingleBookStateImpl>(
          this, _$identity);
}

abstract class _SingleBookState implements SingleBookState {
  const factory _SingleBookState(
      {final bool isLoading, final BookModel? book}) = _$SingleBookStateImpl;

  @override
  bool get isLoading;
  @override
  BookModel? get book;

  /// Create a copy of SingleBookState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SingleBookStateImplCopyWith<_$SingleBookStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
