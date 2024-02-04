import 'dart:ffi';

import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

enum LoginStatus {
  success,
  invalidEmail, // id field is not the email format
  userDisabled,
  userNotFound, // pw or email is wrong
  unexpected, // err code not given but login failed
  other, // not handled err code
}

enum JoinStatus {
  success,
  nullParam,
  alreadyExistsEmail,
  weakPassword,
  passwordRepeatWrong,
  other,
}

enum WithDrawStatus {
  success,
  noLoginRecent,
  other,
}

class AuthService extends GetxService {
  /// singleton pattern
  static AuthService get to => Get.find();

  final _firebaseAuth = FirebaseAuth.instance;

  Future<JoinStatus> joinWithEmailAndPassword({required String email, required String password, required String passwordRepeat}) async {
    if (passwordRepeat != password) {
      return JoinStatus.passwordRepeatWrong;
    }
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(email: email!, password: password!);
    } on FirebaseAuthException catch (error) {
      switch (error.code) {
        case 'weak-password':
          return JoinStatus.weakPassword;
        case 'email-already-in-use':
          return JoinStatus.alreadyExistsEmail;
        default:
          return JoinStatus.other;
      }
    }

    return JoinStatus.success;
  }

  Future<WithDrawStatus> withDrawUser() async {
    if (_firebaseAuth.currentUser == null) {
      return WithDrawStatus.noLoginRecent;
    }

    try {
      await _firebaseAuth.currentUser?.delete();
      return WithDrawStatus.success;
    } on FirebaseAuthException catch (error) {
      switch (error.code) {
        case ('requires-recent-login'):
          return WithDrawStatus.noLoginRecent;
        default:
          return WithDrawStatus.other;
      }
    }
  }

  Future<LoginStatus> logInWithEmailAndPassword({required String email, required String password}) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      if (credential.user == null) {
        return LoginStatus.unexpected;
      } else {
        return LoginStatus.success;
      }
    } on FirebaseAuthException catch (error) {
      switch (error.code) {
        case "invalid-email":
          return LoginStatus.invalidEmail;
        case "user-disabled":
          return LoginStatus.userDisabled;
        case "user-not-found":
          return LoginStatus.userNotFound;
        case "wrong-password":
          return LoginStatus.userNotFound;
        default:
          return LoginStatus.other;
      }
    }
  }

  Future<void> logOut() async {
    await _firebaseAuth.signOut();
  }

  User? getCurrentUser() {
    return _firebaseAuth.currentUser;
  }

  String? getEmail() {
    return _firebaseAuth.currentUser?.email;
  }
}
