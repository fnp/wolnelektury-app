import 'package:bloc/bloc.dart';

abstract class SafeCubit<State> extends BlocBase<State> {
  SafeCubit(super.initialState);

  @override
  void emit(State state) {
    if (isClosed) return;
    super.emit(state);
  }
}
