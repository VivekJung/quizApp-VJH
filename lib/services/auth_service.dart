import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final userStream = FirebaseAuth.instance.authStateChanges();
  final user = FirebaseAuth.instance.currentUser;

  //Anonymous Firebase Login

  Future anonymousLogin() async {
    try {
      await FirebaseAuth.instance.signInAnonymously();
    } on FirebaseAuthException catch (e) {
      log('Anon Signing in error!\n ${e.toString()} ');
    }
  }

  Future emailPasswordLogin() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: "admin@ayur.com", password: "1amadmin");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        log('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        log('Wrong password provided for that user.');
      }
    }
  }

  Future signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } on FirebaseAuthException catch (e) {
      log('Signing out error!\n ${e.toString()} ');
    }
  }
}
