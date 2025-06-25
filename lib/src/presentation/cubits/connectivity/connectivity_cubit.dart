import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wolnelektury/src/utils/cubit/safe_cubit.dart';

part 'connectivity_cubit.freezed.dart';
part 'connectivity_state.dart';

class ConnectivityCubit extends SafeCubit<ConnectivityState> {
  StreamSubscription<List<ConnectivityResult>>? _subscription;
  ConnectivityCubit() : super(const ConnectivityState()) {
    _init();
  }

  void _init() {
    _subscription?.cancel();
    _subscription = Connectivity().onConnectivityChanged.listen((
      List<ConnectivityResult> results,
    ) async {
      if (results.isNotEmpty) {
        final initialResult = results.first;

        if (initialResult == ConnectivityResult.none) {
          // Delay before retry
          await Future.delayed(const Duration(milliseconds: 100));

          final retryResults = await Connectivity().checkConnectivity();

          if (retryResults.isNotEmpty) {
            emit(state.copyWith(result: retryResults.first));
          } else {
            emit(state.copyWith(result: ConnectivityResult.none));
          }
        } else {
          emit(state.copyWith(result: initialResult));
        }
      }
    });
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
