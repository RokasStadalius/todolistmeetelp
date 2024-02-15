import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todoappmeetelp/presentation/widgets/base_page.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BasePage(
      showAppBar: false,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 200,
              child: ElevatedButton(
                  onPressed: () {
                    return context.go('/login');
                  },
                  child: const Text("Log In")),
            ),
            SizedBox(
              width: 200,
              child: ElevatedButton(
                  onPressed: () {
                    return context.go('/signup');
                  },
                  child: const Text("Sign Up")),
            ),
          ],
        ),
      ),
    );
  }
}
