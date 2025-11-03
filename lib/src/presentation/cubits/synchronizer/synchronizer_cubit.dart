import 'dart:ui';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wolnelektury/src/data/bookmarks_repository.dart';
import 'package:wolnelektury/src/data/likes_repository.dart';
import 'package:wolnelektury/src/data/progress_repository.dart';
import 'package:wolnelektury/src/utils/cubit/safe_cubit.dart';
import 'package:wolnelektury/src/utils/data_state/data_state.dart';

part 'synchronizer_cubit.freezed.dart';
part 'synchronizer_state.dart';

class SynchronizerCubit extends SafeCubit<SynchronizerState> {
  final ProgressRepository _progressRepository;
  final LikesRepository _likesRepository;
  final BookmarksRepository _bookmarksRepository;
  SynchronizerCubit(
    this._progressRepository,
    this._likesRepository,
    this._bookmarksRepository,
  ) : super(const SynchronizerState());

  Future<void> triggerAllSyncs({VoidCallback? onFinish}) async {
    await Future.wait([
      sendOutLikesSync(),
      sentOutProgressSync(),
      sendOutBookmarksSync(),
    ]);
    onFinish?.call();
  }

  // This is called once user is logged in or the internet connection is restored.
  Future<void> sentOutProgressSync() async {
    emit(state.copyWith(isLoading: true, isError: false));
    final result = await _progressRepository.sendOutProgressSync();
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
    final result = await _progressRepository.receiveInProgressSync();
    result.handle(
      success: (_, _) {},
      failure: (failure) {
        emit(state.copyWith(isError: true));
      },
    );
  }

  // This is called once user is logged in or the internet connection is restored.
  // It sends out likes to the server.
  Future<void> sendOutLikesSync({VoidCallback? onFinish}) async {
    emit(state.copyWith(isLoading: true, isError: false));
    final result = await _likesRepository.sendOutLikesSync();

    result.handle(
      success: (data, _) async {
        await _receiveInLikesSync(onFinish);
        emit(state.copyWith(isLoading: false));
      },
      failure: (failure) {
        onFinish?.call();
        emit(state.copyWith(isLoading: false, isError: true));
      },
    );
  }

  // This gets called after we synced the app to the DB
  Future<void> _receiveInLikesSync(VoidCallback? onFinish) async {
    final result = await _likesRepository.receiveInLikesSync();
    result.handle(
      success: (_, _) {
        onFinish?.call();
      },
      failure: (failure) {
        onFinish?.call();
        emit(state.copyWith(isError: true));
      },
    );
  }

  Future<void> sendOutBookmarksSync() async {
    emit(state.copyWith(isLoading: true, isError: false));
    final result = await _bookmarksRepository.sendOutBookmarksSync();
    result.handle(
      success: (data, _) async {
        await _receiveInBookmarksSync();
        emit(state.copyWith(isLoading: false));
      },
      failure: (failure) {
        emit(state.copyWith(isLoading: false, isError: true));
      },
    );
  }

  Future<void> _receiveInBookmarksSync() async {
    final result = await _bookmarksRepository.receiveInBookmarksSync();
    result.handle(
      success: (_, _) {},
      failure: (failure) {
        emit(state.copyWith(isError: true));
      },
    );
  }
}
