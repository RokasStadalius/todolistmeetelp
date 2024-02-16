import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:todoappmeetelp/presentation/widgets/base_page.dart';
import 'package:todoappmeetelp/providers/auth_serivce.provider.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      showAppBar: true,
      customAppBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 240,
              height: 50,
              child: TextFormField(
                controller: _emailController,
                style: const TextStyle(color: Colors.black87), // Text color
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.7), // Text field color
                  hintText: "Email",
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 14), // Padding
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none, // No border
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: 240,
              height: 50,
              child: TextFormField(
                controller: _passwordController,
                style: const TextStyle(color: Colors.black87), // Text color
                obscureText: true,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.7), // Text field color
                  hintText: "Password",
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 14), // Padding
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none, // No border
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: 200,
              height: 50,
              child: ElevatedButton(
                onPressed: _signIn,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[700], // Button color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25), // Button border
                  ),
                ),
                child: const Text(
                  "Log In",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _signIn() async {
    String email = _emailController.text;
    String password = _passwordController.text;

    User? user = await ref.read(authServiceProvider).signIn(email, password);

    if (user != null) {
      context.go('/home');
      print("User is successfully logged in");
    }
  }
}
