import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wolnelektury/src/application/app_logger.dart';
import 'package:wolnelektury/src/data/progress_repository.dart';
import 'package:wolnelektury/src/utils/cubit/safe_cubit.dart';
import 'package:wolnelektury/src/utils/data_state/data_state.dart';

part 'synchronizer_cubit.freezed.dart';
part 'synchronizer_state.dart';

class SynchronizerCubit extends SafeCubit<SynchronizerState> {
  final ProgressRepository _progressRepository;
  SynchronizerCubit(this._progressRepository)
    : super(const SynchronizerState());

  // This is called once user is logged in or the internet connection is restored.
  Future<void> sentOutProgressSync() async {
    emit(state.copyWith(isLoading: true, isError: false));
    AppLogger.instance.d('SynchronizerCubit', 'sentOutProgressSync called');
    final result = await _progressRepository.sendOutProgressSync();
    AppLogger.instance.d(
      'SynchronizerCubit',
      'sentOutProgressSync result is $result',
    );
    result.handle(
      success: (data, _) async {
        await _receiveInProgressSync();
        emit(state.copyWith(isLoading: false));
      },
      failure: (failure) {
        emit(state.copyWith(isLoading: false, isError: true));
      },
    );
  }

  // This gets called after we synced the app to the DB
  // Only when success to not overwrite
  Future<void> _receiveInProgressSync() async {
    AppLogger.instance.d('SynchronizerCubit: receiveProgressSync called', null);
    final result = await _progressRepository.receiveInProgressSync();
    AppLogger.instance.d(
      'SynchronizerCubit',
      'receiveInProgressSync result is $result',
    );
    result.handle(
      success: (_, _) {},
      failure: (failure) {
        emit(state.copyWith(isError: true));
      },
    );
  }
}
