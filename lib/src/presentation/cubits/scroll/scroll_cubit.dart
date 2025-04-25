import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wolnelektury/src/utils/cubit/safe_cubit.dart';

part 'scroll_cubit.freezed.dart';
part 'scroll_state.dart';

class ScrollCubit extends SafeCubit<ScrollState> {
  ScrollCubit() : super(const ScrollState());

  void showAppBar() {
    if (isClosed) return;
    emit(state.copyWith(showAppBar: true));
  }

  void hideAppBar() {
    if (isClosed) return;
    emit(state.copyWith(showAppBar: false));
  }
}
