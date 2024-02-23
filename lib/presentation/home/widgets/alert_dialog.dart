import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoappmeetelp/providers/task_repository_provider.dart';

class AlertConfirmation extends ConsumerWidget {
  const AlertConfirmation({super.key, required this.taskId});

  final String? taskId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      title: const Text("Confirm Deletion"),
      content: const Text("Are you sure you want to delete this task?"),
      actions: [
        TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("Cancel")),
        TextButton(
            onPressed: () {
              ref.read(taskProvider.notifier).deleteTask(taskId);
              Navigator.of(context).pop();
            },
            child: const Text("Delete")),
      ],
    );
  }
}
