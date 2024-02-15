import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:todoappmeetelp/data/models/task.dart';
import 'package:todoappmeetelp/presentation/widgets/base_page.dart';
import 'package:todoappmeetelp/providers/task_repository_provider.dart';

class TaskCreation extends ConsumerStatefulWidget {
  const TaskCreation({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TaskCreationState();
}

class _TaskCreationState extends ConsumerState<TaskCreation> {
  final TextEditingController _taskController = TextEditingController();

  @override
  void dispose() {
    _taskController.dispose();
    super.dispose();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return BasePage(
      showAppBar: false,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 300,
              child: TextField(
                controller: _taskController,
                decoration: const InputDecoration(
                  hintText: 'Enter your task',
                  border: OutlineInputBorder(),
                ),
                maxLines: null, // Allow multiline input
                textAlign: TextAlign.center,
                keyboardType: TextInputType.multiline,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
                width: 200,
                child: ElevatedButton(
                    onPressed: () {
                      if (FirebaseAuth.instance.currentUser != null) {
                        Task task = Task(
                            userId: FirebaseAuth.instance.currentUser!.uid,
                            text: _taskController.text);
                        ref.read(taskRepositoryProvider).createTask(task);
                        context.go('/home');
                      }
                    },
                    child: const Text("Add Task"))),
          ],
        ),
      ),
    );
  }
}
