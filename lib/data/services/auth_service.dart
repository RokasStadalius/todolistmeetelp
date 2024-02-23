import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authProvider = Provider<AuthService>(
  (ref) {
    return AuthService();
  },
);

class AuthService {
  Stream<User?> get authStateChanges =>
      FirebaseAuth.instance.authStateChanges();

  User? get currentUser => FirebaseAuth.instance.currentUser;

  Future<User?> signUp(String email, String password) async {
    try {
      UserCredential credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return credential.user;
    } catch (e) {
      print("Error occured + $e");
    }

    return null;
  }

  Future<User?> signIn(String email, String password) async {
    try {
      UserCredential credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return credential.user;
    } catch (e) {
      print("Error occured + $e");
    }

    return null;
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
