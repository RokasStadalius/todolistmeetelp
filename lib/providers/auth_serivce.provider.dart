import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoappmeetelp/data/services/auth_service.dart';

final authServiceProvider = StateProvider<AuthService>(
  (ref) {
    return AuthService();
  },
);
