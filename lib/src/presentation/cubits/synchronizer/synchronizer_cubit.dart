import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wolnelektury/src/utils/cubit/safe_cubit.dart';

part 'synchronizer_cubit.freezed.dart';
part 'synchronizer_state.dart';

class SynchronizerCubit extends SafeCubit<SynchronizerState> {
  SynchronizerCubit() : super(const SynchronizerState());

  // TODO
  // Funkcja która na starcie aplikacji wysyła wszystkie progresy, które zostały utworzone później niz timestamp ostatniej wysyłkowej synchronizacji.

  // TODO
  // Funkcja ktora na starcie aplikacji pobiera wszystkie progresy, które zostały utworzone później niz timestamp ostatniej pobieranej synchronizacji.
}
