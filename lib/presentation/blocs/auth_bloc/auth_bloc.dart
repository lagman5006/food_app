import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:developer' as dev;
import 'package:firebase_auth/firebase_auth.dart' as fb;

import '../../core/injection/injection.dart';
import '../../domain/entities/user_entitiy.dart';
import '../../domain/usecases/auth_usecase.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthUseCase _useCase = getAuthUseCase();
  final fb.FirebaseAuth _firebaseAuth = fb.FirebaseAuth.instance;

  AuthBloc() : super(Unauthenticated()) {
    on<AuthCheckRequested>(_onAuthCheckRequested);
    on<SignIn>(_onSignIn);
    on<SignUp>(_onSignUp);
    on<SignOut>(_onSignOut);
    on<SignInWithGoogle>(_onSignInWithGoogle);
    on<LoggedIn>(_onLoggedIn); // Added missing event handler
    on<LoggedOut>(_onLoggedOut);
    on<AddUser>(_onAddUser);
    on<UpdateUser>(_onUpdateUser);
    on<DeleteUser>(_onDeleteUser);
    _checkAuthentication();
  }

  Future<void> _checkAuthentication() async {
    _firebaseAuth.authStateChanges().listen((fb.User? user) {
      if (user != null) {
        final userEntity = UserEntity(uid: user.uid, email: user.email);
        add(LoggedIn(userEntity));
      } else {
        add(LoggedOut());
      }
    });
  }

  Future<void> _onAuthCheckRequested(AuthCheckRequested event, Emitter<AuthState> emit) async {
    final fb.User? currentUser = _firebaseAuth.currentUser;
    if (currentUser != null) {
      final userEntity = UserEntity(uid: currentUser.uid, email: currentUser.email);
      emit(AuthSuccess(userEntity));
    } else {
      emit(Unauthenticated());
    }
  }

  Future<void> _onSignIn(SignIn event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await _useCase.signIn(event.email, event.password);
      emit(AuthSuccess(user));
    } catch (e) {
      dev.log('SignIn Error: $e');
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> _onSignUp(SignUp event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await _useCase.signUp(event.email, event.password);
      emit(AuthSuccess(user));
    } catch (e) {
      dev.log('SignUp Error: $e');
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> _onSignOut(SignOut event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await _useCase.signOut();
      emit(Unauthenticated());
    } catch (e) {
      dev.log('SignOut Error: $e');
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> _onSignInWithGoogle(SignInWithGoogle event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      dev.log('Starting Google Sign-In');
      final user = await _useCase.signInWithGoogle();
      if (user != null) {
        dev.log('Google Sign-In Success: ${user.uid}');
        emit(AuthSuccess(user));
      } else {
        dev.log('Google Sign-In Canceled or Failed');
        emit(Unauthenticated());
      }
    } catch (e) {
      dev.log('Google Sign-In Error: $e');
      emit(AuthFailure('Google Sign-In failed: $e'));
    }
  }

  Future<void> _onLoggedIn(LoggedIn event, Emitter<AuthState> emit)async{
    emit(AuthSuccess(event.user));
  }



  Future<void> _onLoggedOut(LoggedOut event, Emitter<AuthState> emit) async {
    await _firebaseAuth.signOut();
    emit(Unauthenticated());
  }

  Future<void> _onAddUser(AddUser event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await _useCase.addUser(event.user);
      final users = await _useCase.getAllUser();
      emit(UserLoaded(users));
    } catch (e) {
      dev.log('Add User Error: $e');
      emit(AuthFailure('Failed to add user: $e'));
    }
  }

  Future<void> _onUpdateUser(UpdateUser event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await _useCase.updateUser(event.user);
      final users = await _useCase.getAllUser();
      emit(UserLoaded(users));
    } catch (e) {
      dev.log('Update User Error: $e');
      emit(AuthFailure('Failed to update user: $e'));
    }
  }

  Future<void> _onDeleteUser(DeleteUser event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await _useCase.deleteUser(event.uid);
      final users = await _useCase.getAllUser();
      emit(UserLoaded(users));
    } catch (e) {
      dev.log('Delete User Error: $e');
      emit(AuthFailure('Failed to delete user: $e'));
    }
  }
}