import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../view/widgets/loading_dialog.dart';

class FbAuthController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// CREATE ACCOUNT
  Future<bool> createAccount(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      return true;
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        'Error',
        e.message ?? 'Something went wrong, try again!',
        backgroundColor: Colors.red,
      );
      _controllerExceptionCode(e.code);
    } catch (e) {}
    return false;
  }

  /// SIGN-IN
  Future<bool> signIn({required String email, required String password}) async {
    LoadingDialog().dialog();
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      Get.back();
      return await _handleEmailValidation(userCredential);
    } on FirebaseAuthException catch (e) {
      Get.back();
      Get.snackbar(
        'Error',
        e.message ?? 'Something went wrong, try again!',
        backgroundColor: Colors.red,
      );
      _controllerExceptionCode(e.code);
    } catch (e) {
      print(e);
      Get.back();
    }
    return false;
  }

  /// IS-LOGGED-IN
  bool isLoggedIn() => _auth.currentUser != null;

  /// PASSWORD-RESET
  Future<bool> passwordReset(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return true;
    } on FirebaseAuthException catch (e) {
      _controllerExceptionCode(e.code);
    } catch (e) {
      print(e);
    }
    return false;
  }

  /// HANDLE-CHECK-EMAIL
  Future<bool> _handleEmailValidation(UserCredential userCredential) async {
    if (userCredential.user != null && !userCredential.user!.emailVerified) {
      await userCredential.user!.sendEmailVerification();
      Get.snackbar(
        'CHECK-EMAIL',
        'Please, check your email to verify it.',
        backgroundColor: Colors.red,
      );
      return false;
    }
    return true;
  }

  /// SIGN-OUT
  Future<void> signOut() async {
    _auth.signOut();
  }

  /// CONTROLLER-EXCEPTION-CODE
  void _controllerExceptionCode(String code) {
    if (code == 'email-already-in-use') {
      print('email-already-in-use');
      Get.snackbar(
        'EXCEPTION',
        'email-already-in-use',
        backgroundColor: Colors.red,
      );
    } else if (code == 'invalid-email') {
      Get.snackbar(
        'EXCEPTION',
        'invalid-email',
        backgroundColor: Colors.red,
      );
    } else if (code == 'operation-not-allowed') {
      Get.snackbar(
        'EXCEPTION',
        'operation-not-allowed',
        backgroundColor: Colors.red,
      );
    } else if (code == 'weak-password') {
      Get.snackbar(
        'EXCEPTION',
        'weak-password',
        backgroundColor: Colors.red,
      );
    } else if (code == 'user-disabled') {
      Get.snackbar(
        'EXCEPTION',
        'user-disabled',
        backgroundColor: Colors.red,
      );
    } else if (code == 'user-not-found') {
      Get.snackbar(
        'EXCEPTION',
        'user-not-found',
        backgroundColor: Colors.red,
      );
    } else if (code == 'wrong-password') {
      Get.snackbar(
        'EXCEPTION',
        'wrong-password',
        backgroundColor: Colors.red,
      );
    } else if (code == 'auth/missing-android-pkg-name') {
      Get.snackbar(
        'EXCEPTION',
        'auth/missing-android-pkg-name',
        backgroundColor: Colors.red,
      );
    } else if (code == 'auth/missing-continue-uri') {
      Get.snackbar(
        'EXCEPTION',
        'auth/missing-continue-uri',
        backgroundColor: Colors.red,
      );
    } else if (code == 'auth/missing-ios-bundle-id') {
      Get.snackbar(
        'EXCEPTION',
        'auth/missing-ios-bundle-id',
        backgroundColor: Colors.red,
      );
    } else if (code == 'auth/invalid-continue-uri') {
      Get.snackbar(
        'EXCEPTION',
        'auth/invalid-continue-uri',
        backgroundColor: Colors.red,
      );
    } else if (code == 'auth/unauthorized-continue-uri') {
      Get.snackbar(
        'EXCEPTION',
        'auth/unauthorized-continue-uri',
        backgroundColor: Colors.red,
      );
    } else if (code == 'auth/user-not-found') {
      Get.snackbar(
        'EXCEPTION',
        'auth/user-not-found',
        backgroundColor: Colors.red,
      );
    }
  }
}
