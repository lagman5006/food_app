import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:developer' as dev;

import '../../core/injection/injection.dart';
import '../../domain/usecases/auth_usecase.dart';
import 'auth_event.dart';
import 'auth_state.dart';


class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthUseCase _useCase = getAuthUseCase();

  AuthBloc() : super(AuthInitial()) {
    on<SignIn>((event, emit) async {
      emit(AuthILoading());
      try {
        final user = await _useCase.signIn(event.email, event.password);
        emit(AuthSuccess(user));
      } catch (e) {
        dev.log('SignIn Error: $e');
        emit(AuthFailure(e.toString()));
      }
    });

    on<SignUp>((event, emit) async {
      emit(AuthILoading());
      try {
        final user = await _useCase.signUp(event.email, event.password);
        emit(AuthSuccess(user));
      } catch (e) {
        dev.log('SignUp Error: $e');
        emit(AuthFailure(e.toString()));
      }
    });

    on<SignOut>((event, emit) async {
      emit(AuthILoading());
      try {
        await _useCase.signOut();
        emit(AuthInitial());
      } catch (e) {
        dev.log('SignOut Error: $e');
        emit(AuthFailure(e.toString()));
      }
    });

    on<SignInWithGoogle>((event, emit) async {
      emit(AuthILoading());
      try {
        dev.log('Starting Google Sign-In');
        final user = await _useCase.signInWithGoogle();
        if (user != null) {
          dev.log('Google Sign-In Success: ${user.uid}');
          emit(AuthSuccess(user));
        } else {
          dev.log('Google Sign-In Canceled or Failed');
          emit(AuthInitial());
        }
      } catch (e) {
        dev.log('Google Sign-In Error: $e');
        emit(AuthFailure('Google Sign-In failed: $e'));
      }
    });
  }
}