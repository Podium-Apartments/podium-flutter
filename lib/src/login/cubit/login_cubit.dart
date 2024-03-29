import 'package:authentication_repo/authentication_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._authenticationRepository) : super(const LoginState());

  final AuthenticationRepository _authenticationRepository;

  void emailChanged(String value) {
    final email = Email.dirty(value);
    emit(
      state.copyWith(
        email: email,
      ),
    );
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);
    emit(
      state.copyWith(
        password: password,
      ),
    );
  }

  void returnToEmail() {
    emit(
      state.copyWith(
        emailIsValid: false,
      ),
    );
  }

  Future<void> checkEmailValidity() async {
    if (state.email.isNotValid) return;
    try {
      await _authenticationRepository.checkEmailValidity(
        email: state.email.value,
      );
      emit(state.copyWith(emailIsValid: true));
    } catch (error) {
      debugPrint('error in checkEmailValidity: $error');
    }
  }

  Future<void> logInWithCredentials() async {
    if (state.status.isCanceled) return;
    try {
      await _authenticationRepository.logInWithEmailAndPassword(
        email: state.email.value,
        password: state.password.value,
      );
      emit(state.copyWith(status: FormzSubmissionStatus.success));
    } on LogInWithEmailAndPasswordFailure catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.message,
          status: FormzSubmissionStatus.failure,
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: FormzSubmissionStatus.failure));
    }
  }

  Future<void> logInWithDemoResidentUser() async {
    await _authenticationRepository.logInWithEmailAndPassword(
      email: 'demouser@podiumapartments.com',
      password: 'demopassword',
    );
  }

  Future<void> logInWithDemoAdminUser() async {
    await _authenticationRepository.logInWithEmailAndPassword(
      email: 'demoadminuser@podiumapartments.com',
      password: 'demoadminpassword',
    );
  }

  Future<void> logInWithGoogle() async {
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    try {
      await _authenticationRepository.logInWithGoogle();
      emit(state.copyWith(status: FormzSubmissionStatus.success));
    } on LogInWithGoogleFailure catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.message,
          status: FormzSubmissionStatus.failure,
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: FormzSubmissionStatus.failure));
    }
  }

  Future<void> logInWithFacebook() async {
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    try {
      await _authenticationRepository.signInWithFacebook();
      emit(state.copyWith(status: FormzSubmissionStatus.success));
    } on LogInWithGoogleFailure catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.message,
          status: FormzSubmissionStatus.failure,
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: FormzSubmissionStatus.failure));
    }
  }

  Future<void> logOut() async {
    await _authenticationRepository.logOut();
  }
}
