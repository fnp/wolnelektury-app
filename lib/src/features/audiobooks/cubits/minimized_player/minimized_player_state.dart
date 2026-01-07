part of 'minimized_player_cubit.dart';

@freezed
sealed class MinimizedPlayerState with _$MinimizedPlayerState {
  const factory MinimizedPlayerState({
    required double maxWidth,
    required double maxHeight,
    Offset? position,
  }) = _MinimizedPlayerState;
}
