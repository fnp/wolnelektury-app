import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wolnelektury/src/application/app_secure_storage_service.dart';
import 'package:wolnelektury/src/data/auth_repository.dart';
import 'package:wolnelektury/src/domain/register_agreement_model.dart';
import 'package:wolnelektury/src/domain/user_model.dart';
import 'package:wolnelektury/src/utils/cubit/safe_cubit.dart';

part 'auth_cubit.freezed.dart';
part 'auth_state.dart';

class AuthCubit extends SafeCubit<AuthState> {
  final AuthRepository _authRepository;
  AuthCubit(this._authRepository) : super(const AuthState()) {
    _getRegisterAgreements();
  }

  Future<void> tryAutoLogin() async {
    final token = await AppSecureStorageService().readAccessToken();
    if (token == null) return;
    await getAndSetUser();
  }

  Future<void> login({
    required String email,
    required String password,
    // This means user is trying to log in from registering flow
    // different error is presented in case of failure
    bool fromRegisterFlow = false,
  }) async {
    emit(
      state.copyWith(
        isLoading: true,
        isLoginSuccess: null,
        isLoginSuccessFromRegisterFlow: null,
      ),
    );

    final result = await _authRepository.login(
      username: email.toLowerCase(),
      password: password.toLowerCase(),
    );

    result.map(
      success: (_) async {
        await getAndSetUser();
      },
      failed: (failure) {
        // Display different error in case of registering flow
        // email has not been verified yet
        if (fromRegisterFlow) {
          emit(
            state.copyWith(
              isLoginSuccessFromRegisterFlow: false,
            ),
          );
          return;
        }
        emit(state.copyWith(isLoginSuccess: false));
      },
    );

    emit(state.copyWith(isLoading: false));
  }

  Future<void> register({
    required String email,
    required String password,
  }) async {
    emit(state.copyWith(isLoading: true, isRegisterSuccess: null));

    final result = await _authRepository.register(
      username: email.toLowerCase(),
      password: password.toLowerCase(),
      options: state.getListOfAgreements,
    );

    result.map(
      success: (_) async {
        emit(
          state.copyWith(
            isRegisterSuccess: true,
          ),
        );
      },
      failed: (failure) {
        emit(state.copyWith(isRegisterSuccess: false));
      },
    );

    emit(state.copyWith(isLoading: false));
  }

  Future<void> logout() async {
    await AppSecureStorageService().clearTokens();
    emit(state.copyWith(user: null));
  }

  Future<void> getAndSetUser() async {
    final userResult = await _authRepository.getUser();

    userResult.map(
      success: (data) {
        emit(
          state.copyWith(
            user: data.data,
            isLoginSuccess: true,
          ),
        );
      },
      failed: (failure) {
        logout();
        emit(state.copyWith(isLoginSuccess: false));
      },
    );
    emit(state.copyWith(isLoading: false));
  }

  Future<void> _getRegisterAgreements() async {
    if (state.agreements != null) return;
    emit(state.copyWith(isLoadingAgreements: true));
    final result = await _authRepository.getRegisterAgreements();
    result.map(
      success: (data) {
        emit(
          state.copyWith(
            agreements: data.data,
            isLoadingAgreements: false,
          ),
        );
      },
      failed: (failure) {
        emit(state.copyWith(isLoadingAgreements: false));
      },
    );
  }

  void toggleAgreement(int id) {
    final agreements = state.agreements;
    if (agreements == null) return;
    final updatedOptions = agreements.options.map((option) {
      if (option.id == id) {
        return option.copyWith(isChecked: !option.isChecked);
      }
      return option;
    }).toList();
    emit(
      state.copyWith(
        agreements: agreements.copyWith(options: updatedOptions),
      ),
    );
  }
}
