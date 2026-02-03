import 'dart:async';
import 'dart:ui';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wolnelektury/src/application/app_storage/services/app_storage_sync_service.dart';
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
  final AppStorageSyncService _syncStorage;
  SynchronizerCubit(
    this._progressRepository,
    this._likesRepository,
    this._bookmarksRepository,
    this._syncStorage,
  ) : super(const SynchronizerState());

  Future<void> cleanupSyncData() async {
    await _bookmarksRepository.reset();
    await _likesRepository.reset();
    await _syncStorage.clearSyncData();
  }

  Future<void> triggerAllSyncs({VoidCallback? onFinish}) async {
    emit(state.copyWith(isWorking: true, isLoading: true, isError: false));
    final likesCompleter = Completer<void>();
    final progressCompleter = Completer<void>();
    final bookmarksCompleter = Completer<void>();

    sendOutLikesSync(completer: likesCompleter, emitState: false);
    sentOutProgressSync(completer: progressCompleter, emitState: false);
    sendOutBookmarksSync(completer: bookmarksCompleter, emitState: false);

    try {
      await Future.wait([
        likesCompleter.future,
        progressCompleter.future,
        bookmarksCompleter.future,
      ], eagerError: true).timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          throw TimeoutException('Synchronization timeout');
        },
      );
      emit(state.copyWith(isWorking: false, isLoading: false));
    } catch (e) {
      emit(state.copyWith(isWorking: false, isLoading: false, isError: true));
    }

    onFinish?.call();
  }

  // This is called once user is logged in or the internet connection is restored.
  Future<void> sentOutProgressSync({
    Completer<void>? completer,
    bool emitState = true,
  }) async {
    if (emitState) {
      emit(state.copyWith(isLoading: true, isError: false));
    }
    final result = await _progressRepository.sendOutProgressSync();
    result.handle(
      success: (data, _) async {
        await _receiveInProgressSync(emitState: emitState);
        if (emitState) {
          emit(state.copyWith(isLoading: false));
        }
        completer?.complete();
      },
      failure: (failure) {
        if (emitState) {
          emit(state.copyWith(isLoading: false, isError: true));
        }
        completer?.complete();
      },
    );
  }

  // This gets called after we synced the app to the DB
  // Only when success to not overwrite
  Future<void> _receiveInProgressSync({bool emitState = true}) async {
    final result = await _progressRepository.receiveInProgressSync();
    result.handle(
      success: (_, _) {
        if (emitState) {
          emit(state.copyWith(isLoading: false));
        }
      },
      failure: (failure) {
        if (emitState) {
          emit(state.copyWith(isLoading: false, isError: true));
        }
      },
    );
  }

  // This is called once user is logged in or the internet connection is restored.
  // It sends out likes to the server.
  Future<void> sendOutLikesSync({
    Completer<void>? completer,
    bool emitState = true,
  }) async {
    if (emitState) {
      emit(state.copyWith(isLoading: true, isError: false));
    }
    final result = await _likesRepository.sendOutLikesSync();

    result.handle(
      success: (data, _) async {
        await _receiveInLikesSync(emitState: emitState);
        if (emitState) {
          emit(state.copyWith(isLoading: false));
        }
        completer?.complete();
      },
      failure: (failure) {
        if (emitState) {
          emit(state.copyWith(isLoading: false, isError: true));
        }
        completer?.complete();
      },
    );
  }

  // This gets called after we synced the app to the DB
  Future<void> _receiveInLikesSync({bool emitState = true}) async {
    final result = await _likesRepository.receiveInLikesSync();
    result.handle(
      success: (_, _) {
        if (emitState) {
          emit(state.copyWith(isLoading: false));
        }
      },
      failure: (failure) {
        if (emitState) {
          emit(state.copyWith(isLoading: false, isError: true));
        }
      },
    );
  }

  Future<void> sendOutBookmarksSync({
    Completer<void>? completer,
    bool emitState = true,
  }) async {
    if (emitState) {
      emit(state.copyWith(isLoading: true, isError: false));
    }
    final result = await _bookmarksRepository.sendOutBookmarksSync();
    result.handle(
      success: (data, _) async {
        await _receiveInBookmarksSync(emitState: emitState);
        if (emitState) {
          emit(state.copyWith(isLoading: false));
        }
        completer?.complete();
      },
      failure: (failure) {
        if (emitState) {
          emit(state.copyWith(isLoading: false, isError: true));
        }
        completer?.complete();
      },
    );
  }

  Future<void> _receiveInBookmarksSync({bool emitState = true}) async {
    final result = await _bookmarksRepository.receiveInBookmarksSync();
    result.handle(
      success: (_, _) {
        if (emitState) {
          emit(state.copyWith(isLoading: false));
        }
      },
      failure: (failure) {
        if (emitState) {
          emit(state.copyWith(isLoading: false, isError: true));
        }
      },
    );
  }
}
