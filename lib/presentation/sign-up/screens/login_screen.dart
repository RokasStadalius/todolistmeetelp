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
        showAppBar: false,
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 300,
              ),
              SizedBox(
                width: 240,
                height: 50,
                child: TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.3),
                      hintText: "Email",
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ))),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: 240,
                height: 50,
                child: TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.3),
                      hintText: "Password",
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ))),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                  width: 200,
                  child: ElevatedButton(
                      onPressed: _signIn, child: const Text("Log In"))),
            ],
          ),
        ));
  }

  void _signIn() async {
    String email = _emailController.text;
    String password = _passwordController.text;

    User? user = await ref.read(authServiceProvider).signIn(email, password);

    if (user != null) {
      context.go('/home');
      print("User is succesfully logged in");
    }
  }
}
