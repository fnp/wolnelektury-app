import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wolnelektury/src/utils/cubit/safe_cubit.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';

part 'minimized_player_cubit.freezed.dart';
part 'minimized_player_state.dart';

class MinimizedPlayerCubit extends SafeCubit<MinimizedPlayerState> {
  MinimizedPlayerCubit({
    required double maxWidth,
    required double maxHeight,
  }) : super(
          MinimizedPlayerState(
            maxWidth: maxWidth,
            maxHeight: maxHeight,
          ),
        ) {
    _init();
  }

  void _init() {
    if (state.position == null) {
      emit(
        state.copyWith(
          position: Offset(
            state.maxWidth - Dimensions.veryLargePadding,
            state.maxHeight - Dimensions.veryLargePadding,
          ),
        ),
      );
    }
  }

  void changePosition(Offset position) {
    Offset effectivePosition = position;
    if (effectivePosition.dx < 0) {
      effectivePosition = Offset(0, effectivePosition.dy);
    }
    if (effectivePosition.dy < 0) {
      effectivePosition = Offset(effectivePosition.dx, 0);
    }
    if (effectivePosition.dx > state.maxWidth) {
      effectivePosition = Offset(state.maxWidth, effectivePosition.dy);
    }
    if (effectivePosition.dy > state.maxHeight) {
      effectivePosition = Offset(effectivePosition.dx, state.maxHeight);
    }
    emit(state.copyWith(position: effectivePosition));
  }
}
