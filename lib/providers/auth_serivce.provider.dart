import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoappmeetelp/data/services/auth_service.dart';

final authNotifier = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(ref);
});

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier(this.ref)
      : _auth = ref.read(authProvider),
        super(InitialAuthState());

  Ref ref;
  final AuthService _auth;

  StreamSubscription<User?>? _authStateChangesSubscription;

  Future<void> init() async {
    await _authStateChangesSubscription?.cancel();
    _authStateChangesSubscription = _auth.authStateChanges.listen((user) {
      print("evento pradzia");
      if (user != null) {
        state = SuccessAuthState(authResponse: _auth.currentUser);
        print("gavo eventa");
      } else {
        print("gavo eventa, useris atsijunge");
        state = InitialAuthState();
      }
    });
  }

  User? getCurrentUser() {
    return _auth.currentUser;
  }

  Future<void> signIn({required String email, required String password}) async {
    final resp = await _auth.signIn(email, password);

    state = SuccessAuthState(authResponse: resp);
  }

  Future<void> signUp({required String email, required String password}) async {
    final resp = await _auth.signUp(email, password);

    state = SuccessAuthState(authResponse: resp);
  }

  Future<void> signOut() async {
    await _auth.signOut();
    state = InitialAuthState();
  }
}

abstract class AuthState {}

class InitialAuthState extends AuthState {}

class SuccessAuthState extends AuthState {
  SuccessAuthState({required this.authResponse});

  final User? authResponse;
}
