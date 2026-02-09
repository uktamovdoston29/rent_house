import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:rent_house/features/auth/cubit/auth_state.dart';
import 'package:rent_house/utils/services/google_auth_service.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  Future<void> validateEmail(String email) async {
    if (email.isEmpty) {
      emit(AuthEmailError(message: "The entered email is null"));
    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
      emit(AuthEmailError(message: "The entered email is wrong!"));
    } else {
      emit(AuthEmailValid());
    }
  }

  Future<void> validatePassword(String password) async {
    if (password.isEmpty) {
      emit(AuthPasswordError(message: 'The entered password is null'));
    } else if (password.length < 6) {
      emit(
        AuthPasswordError(
          message: 'The entered password is wrong ! At least 6 symbols',
        ),
      );
    } else {
      emit(AuthPasswordValid());
    }
  }

  Future<void> signUp({required String email, required String password}) async {
    emit(AuthLoadingState());
    try {
      final result = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (result.user != null) {
        emit(AuthSuccessState());
      } else {
        throw FirebaseAuthException(
          code: "user-not-created",
          message: "Can not register",
        );
      }
    } on FirebaseAuthException catch (e) {
      print("firebase auth exception ${e.message}");
      emit(AuthErrorState(errorText: e.message ?? "Something went wrong"));
      return;
    } on FirebaseException catch (e) {
      print("firebase exception ${e.message}");
      emit(AuthErrorState(errorText: e.message ?? "Something went wrong"));
      return;
    } on TimeoutException {
      emit(
        AuthErrorState(errorText: "Slow internet connection or Server is down"),
      );
      return;
    } catch (e) {
      print("error: $e");
      emit(AuthErrorState(errorText: "Try again"));
      return;
    }
  }

  Future<void> signIn({required String email, required String password}) async {
    emit(AuthLoadingState());
    try {
      final result = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (result.user != null) {
        emit(AuthSuccessState());
      } else {
        throw FirebaseException(plugin: "Try again ");
      }
    } on FirebaseException catch (e) {
      print("firebase exception ${e.message}");
      emit(AuthErrorState(errorText: e.message));
      return;
    } catch (error) {
      emit(AuthErrorState(errorText: "Try again"));
      return;
    }
  }

  Future<void> resetPassword({required String email}) async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: email)
          .then((v) {
            print("send link");
          })
          .onError((error, stack) {
            print("error $error");
          });
    } catch (e) {
      print("error");
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      print("google loading before auth");
      final user = await GoogleAuthService.signInWithGoogle();
      if (user != null) {
        print("User ro`yxatdan o`tdi ${user.email}");
        emit(AuthSuccessState());
      } else {
        throw FirebaseAuthException(code: "404");
      }
    } on FirebaseAuthException catch (error) {
      emit(
        AuthGoogleErrorState(
          errorText: error.message ?? "Something went wrong",
        ),
      );
    } on TimeoutException {
      emit(
        AuthGoogleErrorState(
          errorText: "Slow internet connection or Server is down",
        ),
      );
    } on SocketException {
      emit(AuthGoogleErrorState(errorText: "Check your internet network"));
    }
  }
}

ValueNotifier<bool> isButoonPressed = ValueNotifier(false);
