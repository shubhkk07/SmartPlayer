// ignore_for_file: body_might_complete_normally_nullable

import 'package:firebase_auth/firebase_auth.dart';

class AuthRepo {
  Future<UserCredential?> userRegisteration({required String email, required String password}) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'weak-password':
          throw 'The password provided is too weak.';
        case 'email-already-in-use':
          throw 'The account already exists for that email.';
        case 'invalid-email':
          throw 'Email address is not valid.';
        case 'operation-not-allowed':
          throw 'Your account is inactive. Please contact the support.';
        default:
          throw e.message.toString();
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future signInwithEmailAndPass({required String email, required String password}) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw ('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        throw ('Wrong password provided for that user.');
      } else {
        throw e.message.toString();
      }
    } catch (e) {
      throw e.toString();
    }
  }

  User? getCurrentUser() {
    return FirebaseAuth.instance.currentUser;
  }

  Future signOut() async {
    return await FirebaseAuth.instance.signOut();
  }
}
