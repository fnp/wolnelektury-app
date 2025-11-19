part of 'scroll_cubit.dart';

@freezed
sealed class ScrollState with _$ScrollState {
  const factory ScrollState({@Default(true) showAppBar}) = _ScrollState;
}
