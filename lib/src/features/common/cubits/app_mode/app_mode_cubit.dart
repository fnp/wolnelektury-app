import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wolnelektury/src/enums/app_mode_enum.dart';
import 'package:wolnelektury/src/utils/cubit/safe_cubit.dart';

part 'app_mode_cubit.freezed.dart';
part 'app_mode_state.dart';

class AppModeCubit extends SafeCubit<AppModeState> {
  AppModeCubit() : super(const AppModeState());

  void changeMode(AppModeEnum mode) {
    if (state.mode == mode) return;
    emit(state.copyWith(mode: mode));
  }
}
