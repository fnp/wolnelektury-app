import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wolnelektury/src/application/app_logger.dart';
import 'package:wolnelektury/src/config/router/router.dart';
import 'package:wolnelektury/src/config/router/router_config.dart';
import 'package:wolnelektury/src/presentation/enums/my_library_enum.dart';
import 'package:wolnelektury/src/utils/cubit/safe_cubit.dart';

part 'router_cubit.freezed.dart';
part 'router_state.dart';

class RouterCubit extends SafeCubit<RouterState> {
  RouterCubit()
    : super(
        RouterState(
          location: router.location,
          previousLocation: router.location,
        ),
      ) {
    _initRouterListener();
  }

  void _initRouterListener() {
    router.routerDelegate.addListener(_routerListener);
  }

  void _routerListener() {
    if (router.location != state.location) {
      AppLogger.instance.d(
        'RouterCubit',
        'Route changed to: ${router.location}',
      );

      emit(
        state.copyWith(
          previousLocation: state.location,
          location: router.location,
        ),
      );
    }
  }

  void changeMyLibraryEnum(MyLibraryEnum myLibraryEnum) {
    emit(state.copyWith(lastEnteredMyLibraryEnum: myLibraryEnum));
  }

  @override
  Future<void> close() {
    router.routeInformationProvider.removeListener(_routerListener);
    return super.close();
  }
}
