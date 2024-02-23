import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoappmeetelp/common/router.dart';
import 'package:todoappmeetelp/firebase_options.dart';
import 'package:todoappmeetelp/providers/auth_serivce.provider.dart';

late final TodoRouter router;
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  void initState() {
    super.initState();
    router = TodoRouter(ref: ref);
    ref.read(authNotifier.notifier).init();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: TodoRouter(ref: ref).router,
      //home: TaskCreation(),
    );
  }
}
