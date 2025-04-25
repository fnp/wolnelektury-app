// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'minimized_player_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$MinimizedPlayerState {
  double get maxWidth => throw _privateConstructorUsedError;
  double get maxHeight => throw _privateConstructorUsedError;
  Offset? get position => throw _privateConstructorUsedError;

  /// Create a copy of MinimizedPlayerState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MinimizedPlayerStateCopyWith<MinimizedPlayerState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MinimizedPlayerStateCopyWith<$Res> {
  factory $MinimizedPlayerStateCopyWith(MinimizedPlayerState value,
          $Res Function(MinimizedPlayerState) then) =
      _$MinimizedPlayerStateCopyWithImpl<$Res, MinimizedPlayerState>;
  @useResult
  $Res call({double maxWidth, double maxHeight, Offset? position});
}

/// @nodoc
class _$MinimizedPlayerStateCopyWithImpl<$Res,
        $Val extends MinimizedPlayerState>
    implements $MinimizedPlayerStateCopyWith<$Res> {
  _$MinimizedPlayerStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MinimizedPlayerState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? maxWidth = null,
    Object? maxHeight = null,
    Object? position = freezed,
  }) {
    return _then(_value.copyWith(
      maxWidth: null == maxWidth
          ? _value.maxWidth
          : maxWidth // ignore: cast_nullable_to_non_nullable
              as double,
      maxHeight: null == maxHeight
          ? _value.maxHeight
          : maxHeight // ignore: cast_nullable_to_non_nullable
              as double,
      position: freezed == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as Offset?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MinimizedPlayerStateImplCopyWith<$Res>
    implements $MinimizedPlayerStateCopyWith<$Res> {
  factory _$$MinimizedPlayerStateImplCopyWith(_$MinimizedPlayerStateImpl value,
          $Res Function(_$MinimizedPlayerStateImpl) then) =
      __$$MinimizedPlayerStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double maxWidth, double maxHeight, Offset? position});
}

/// @nodoc
class __$$MinimizedPlayerStateImplCopyWithImpl<$Res>
    extends _$MinimizedPlayerStateCopyWithImpl<$Res, _$MinimizedPlayerStateImpl>
    implements _$$MinimizedPlayerStateImplCopyWith<$Res> {
  __$$MinimizedPlayerStateImplCopyWithImpl(_$MinimizedPlayerStateImpl _value,
      $Res Function(_$MinimizedPlayerStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of MinimizedPlayerState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? maxWidth = null,
    Object? maxHeight = null,
    Object? position = freezed,
  }) {
    return _then(_$MinimizedPlayerStateImpl(
      maxWidth: null == maxWidth
          ? _value.maxWidth
          : maxWidth // ignore: cast_nullable_to_non_nullable
              as double,
      maxHeight: null == maxHeight
          ? _value.maxHeight
          : maxHeight // ignore: cast_nullable_to_non_nullable
              as double,
      position: freezed == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as Offset?,
    ));
  }
}

/// @nodoc

class _$MinimizedPlayerStateImpl implements _MinimizedPlayerState {
  const _$MinimizedPlayerStateImpl(
      {required this.maxWidth, required this.maxHeight, this.position});

  @override
  final double maxWidth;
  @override
  final double maxHeight;
  @override
  final Offset? position;

  @override
  String toString() {
    return 'MinimizedPlayerState(maxWidth: $maxWidth, maxHeight: $maxHeight, position: $position)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MinimizedPlayerStateImpl &&
            (identical(other.maxWidth, maxWidth) ||
                other.maxWidth == maxWidth) &&
            (identical(other.maxHeight, maxHeight) ||
                other.maxHeight == maxHeight) &&
            (identical(other.position, position) ||
                other.position == position));
  }

  @override
  int get hashCode => Object.hash(runtimeType, maxWidth, maxHeight, position);

  /// Create a copy of MinimizedPlayerState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MinimizedPlayerStateImplCopyWith<_$MinimizedPlayerStateImpl>
      get copyWith =>
          __$$MinimizedPlayerStateImplCopyWithImpl<_$MinimizedPlayerStateImpl>(
              this, _$identity);
}

abstract class _MinimizedPlayerState implements MinimizedPlayerState {
  const factory _MinimizedPlayerState(
      {required final double maxWidth,
      required final double maxHeight,
      final Offset? position}) = _$MinimizedPlayerStateImpl;

  @override
  double get maxWidth;
  @override
  double get maxHeight;
  @override
  Offset? get position;

  /// Create a copy of MinimizedPlayerState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MinimizedPlayerStateImplCopyWith<_$MinimizedPlayerStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
