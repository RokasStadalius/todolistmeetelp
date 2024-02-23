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
      showAppBar: true,
      customAppBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("Edit a task", style: TextStyle(color: Colors.black)),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 300,
              child: TextFormField(
                style: const TextStyle(color: Colors.black87),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.7),
                  hintText: "Edit your task",
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
                controller: _taskController,
                maxLines: null,
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
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green[700],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    onPressed: () {
                      print(widget.taskId);
                      ref
                          .read(taskProvider.notifier)
                          .editTask(widget.taskId, _taskController.text);
                      context.go('/');
                    },
                    child: const Text("Edit Task"))),
          ],
        ),
      ),
    );
  }
}
