import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // auth change user stream
  Stream<User?> get user {
    return _auth.authStateChanges();
  }

  // sing in anon
  Future<User?> singInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      return result.user;
    } catch (e, s) {
      log("$e - $s");
      return null;
    }
  }

  // register with email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      var result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      var user = result.user;
      return user;
    } catch (e, s) {
      log("$e - $s");
      return null;
    }
  }

  // sign in with email and password
  Future singInWithEmailAndPassword(String email, String password) async {
    try {
      var result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      var user = result.user;

      return user;
    } catch (e, s) {
      log("$e - $s");
      return null;
    }
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      return null;
    }
  }

  Future<User?> authPhone(String verificationId, String smsCode) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: smsCode);
      var result = await _auth.signInWithCredential(credential);
      return result.user;
    } catch (e, s) {
      log("$e - $s");
      return null;
    }
  }

  Future<void> verifyPhone(
      String phone,
      void Function(String id) getVerificationId,
      void Function(FirebaseAuthException) verificationFailed) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phone,
      timeout: const Duration(minutes: 1),
      verificationCompleted: (PhoneAuthCredential credential) {
        log("${credential.smsCode}");
      },
      verificationFailed: (FirebaseAuthException e) {
        log("error: $e");
        verificationFailed(e);
      },
      codeSent: (String verificationId, int? resendToken) {
        log("$verificationId -- $resendToken");
        getVerificationId(verificationId);
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        log("timeout: $verificationId");
      },
    );
  }
}
