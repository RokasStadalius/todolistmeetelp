import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todoappmeetelp/presentation/home/screens/home_tab.dart';
import 'package:todoappmeetelp/presentation/sign-up/screens/login_screen.dart';
import 'package:todoappmeetelp/presentation/sign-up/screens/signup_screen.dart';
import 'package:todoappmeetelp/presentation/sign-up/screens/welcome_screen.dart';
import 'package:todoappmeetelp/presentation/task-creation/screens/task_creation_screen.dart';
import 'package:todoappmeetelp/presentation/task-creation/screens/task_editing_screen.dart';

final GoRouter router = GoRouter(routes: <GoRoute>[
  GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const WelcomeScreen();
      },
      routes: [
        GoRoute(
            path: 'signup',
            builder: (BuildContext context, GoRouterState state) {
              return const SignUpScreen();
            }),
        GoRoute(
            path: 'login',
            builder: (BuildContext context, GoRouterState state) {
              return const LoginScreen();
            }),
      ]),
  GoRoute(
      path: '/home',
      builder: (BuildContext context, GoRouterState state) {
        return const HomeTab();
      },
      routes: [
        GoRoute(
            path: 'taskcreate',
            name: 'taskcreate',
            builder: (BuildContext context, GoRouterState state) {
              return const TaskCreation();
            }),
        GoRoute(
          path: 'taskedit/:initialtext/:taskId',
          name: 'taskedit',
          builder: (BuildContext context, GoRouterState state) {
            final initialtext = state.pathParameters['initialtext'];
            final taskId = state.pathParameters['taskId'];
            return TaskEditingScreen(
              initialText: initialtext,
              taskId: taskId,
            );
          },
        ),
      ]),
]);
