import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wolnelektury/src/data/progress_repository.dart';
import 'package:wolnelektury/src/domain/progress_model.dart';
import 'package:wolnelektury/src/utils/data_state/data_state.dart';

part 'progress_cubit.freezed.dart';
part 'progress_state.dart';

class ProgressCubit extends Cubit<ProgressState> {
  final ProgressRepository _progressRepository;
  ProgressCubit(this._progressRepository) : super(const ProgressState());

  Future<void> getProgresses() async {
    emit(state.copyWith(isLoading: true));
    final progresses = await _progressRepository.getProgresses();
    progresses.handle(
      success: (progresses, _) {
        emit(state.copyWith(progresses: progresses, isLoading: false));
      },
      failure: (failure) {
        emit(state.copyWith(isLoading: false));
      },
    );
  }

  Future<void> loadMore() async {
    if (state.progresses.length % 10 != 0) return;
    emit(state.copyWith(isLoadingMore: true));
    final books = await _progressRepository.getProgresses(
      offset: state.progresses.length,
    );

    books.handle(
      success: (progresses, _) {
        emit(
          state.copyWith(
            progresses: [...state.progresses, ...progresses],
            isLoadingMore: false,
          ),
        );
      },
      failure: (failure) {
        emit(state.copyWith(isLoadingMore: false));
      },
    );
  }
}
