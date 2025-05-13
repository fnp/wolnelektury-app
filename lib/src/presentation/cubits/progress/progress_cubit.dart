import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wolnelektury/src/data/progress_repository.dart';
import 'package:wolnelektury/src/domain/progress_model.dart';

part 'progress_cubit.freezed.dart';
part 'progress_state.dart';

class ProgressCubit extends Cubit<ProgressState> {
  final ProgressRepository _progressRepository;
  ProgressCubit(this._progressRepository) : super(const ProgressState()) {
    _init();
  }

  Future<void> _init() async {
    emit(state.copyWith(isLoading: true));
    final progresses = await _progressRepository.getProgresses();
    progresses.when(
      success: (progresses, _) {
        print('Progresses: $progresses');
        emit(state.copyWith(isLoading: false, progresses: progresses));
      },
      failed: (failure) {
        emit(state.copyWith(isLoading: false));
      },
    );
  }
}
