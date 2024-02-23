import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:todoappmeetelp/common/listenable.dart';
import 'package:todoappmeetelp/presentation/home/screens/home_tab.dart';
import 'package:todoappmeetelp/presentation/sign-up/screens/login_screen.dart';
import 'package:todoappmeetelp/presentation/sign-up/screens/signup_screen.dart';
import 'package:todoappmeetelp/presentation/sign-up/screens/welcome_screen.dart';
import 'package:todoappmeetelp/presentation/task-creation/screens/task_creation_screen.dart';
import 'package:todoappmeetelp/presentation/task-creation/screens/task_editing_screen.dart';
import 'package:todoappmeetelp/providers/auth_serivce.provider.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();
final signInNavigatorKey = GlobalKey<NavigatorState>();
final RouteObserver<ModalRoute<void>> routeObserver =
    RouteObserver<ModalRoute<void>>();

class TodoRouter {
  TodoRouter({required this.ref});

  List<String> get introRoutes => [
        '/intro',
        '/intro/login',
        '/intro/signup',
      ];

  final WidgetRef ref;

  late final GoRouter router = GoRouter(
    navigatorKey: rootNavigatorKey,
    observers: [routeObserver],
    refreshListenable: ref.watch(refreshListener),
    redirect: (context, state) {
      final authState = ref.read(authNotifier);

      if (authState is InitialAuthState &&
          !introRoutes.contains(state.matchedLocation)) {
        print("1");
        return '/intro';
      } else if (authState is SuccessAuthState &&
          introRoutes.contains(state.matchedLocation)) {
        print("2");
        return '/';
      }
      return null;
    },
    initialLocation: '/intro',
    routes: [
      GoRoute(
          name: 'home',
          path: '/',
          builder: (context, state) => const HomeTab(),
          routes: [
            GoRoute(
                path: 'taskcreate',
                name: 'taskcreate',
                builder: (context, state) => const TaskCreation()),
            GoRoute(
              path: 'taskedit/:id',
              name: 'taskedit',
              builder: (BuildContext context, GoRouterState state) {
                String text = state.extra as String;
                String? id = state.pathParameters['id'];
                return TaskEditingScreen(
                  initialText: text,
                  taskId: id,
                );
              },
            ),
          ]),
      GoRoute(
          name: 'intro',
          path: '/intro',
          builder: (context, state) => const WelcomeScreen(),
          routes: [
            GoRoute(
                path: 'signup',
                name: 'signup',
                builder: (BuildContext context, GoRouterState state) {
                  return const SignUpScreen();
                }),
            GoRoute(
                path: 'login',
                name: 'login',
                builder: (BuildContext context, GoRouterState state) {
                  return const LoginScreen();
                }),
          ])
    ],
  );
}
