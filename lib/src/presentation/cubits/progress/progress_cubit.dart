import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wolnelektury/src/application/api_response/api_response.dart';
import 'package:wolnelektury/src/data/progress_repository.dart';
import 'package:wolnelektury/src/domain/progress_model.dart';
import 'package:wolnelektury/src/utils/string/string_extension.dart';

part 'progress_cubit.freezed.dart';
part 'progress_state.dart';

class ProgressCubit extends Cubit<ProgressState> {
  final ProgressRepository _progressRepository;
  ProgressCubit(this._progressRepository) : super(const ProgressState());

  Future<void> getProgresses() async {
    emit(state.copyWith(isLoading: true));
    final progresses = await _progressRepository.getProgresses();
    progresses.when(
      success: (progresses, pagination) {
        emit(
          state.copyWith(
            progresses: progresses,
            pagination: pagination ?? state.pagination,
            isLoading: false,
          ),
        );
      },
      failed: (failure) {
        emit(state.copyWith(isLoading: false));
      },
    );
  }

  Future<void> loadMore() async {
    if (state.pagination.next == null) return;

    emit(state.copyWith(isLoadingMore: true));
    final books = await _progressRepository.getProgresses(
      url: state.pagination.next!.removeApiUrl,
    );

    books.when(
      success: (progresses, pagination) {
        emit(
          state.copyWith(
            progresses: [...state.progresses, ...progresses],
            pagination: pagination ?? state.pagination,
            isLoadingMore: false,
          ),
        );
      },
      failed: (failure) {
        emit(
          state.copyWith(
            isLoadingMore: false,
          ),
        );
      },
    );
  }
}
