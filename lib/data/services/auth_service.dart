import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  Stream<User?> get authStateChanges =>
      FirebaseAuth.instance.authStateChanges();

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

  void signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
