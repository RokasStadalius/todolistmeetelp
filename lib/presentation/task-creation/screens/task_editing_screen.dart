import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:todoappmeetelp/presentation/widgets/base_page.dart';
import 'package:todoappmeetelp/providers/task_repository_provider.dart';

class TaskEditingScreen extends ConsumerStatefulWidget {
  const TaskEditingScreen(
      {super.key, required this.initialText, required this.taskId});
  final String? initialText;
  final String? taskId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _TaskEditingScreenState();
}

class _TaskEditingScreenState extends ConsumerState<TaskEditingScreen> {
  final TextEditingController _taskController = TextEditingController();

  @override
  void dispose() {
    _taskController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _taskController.text = widget.initialText!;
    return BasePage(
      showAppBar: false,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 300,
              child: TextFormField(
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
                      ref
                          .read(taskRepositoryProvider)
                          .editTask(widget.taskId, _taskController.text);
                      context.go('/home');
                    },
                    child: const Text("Edit Task"))),
          ],
        ),
      ),
    );
  }
}
