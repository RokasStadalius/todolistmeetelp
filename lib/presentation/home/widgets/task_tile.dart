import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todoappmeetelp/domain/repositories/task_repository.dart';

class TaskTile extends StatelessWidget {
  TaskTile({super.key, required this.text, required this.taskId});

  final String text;
  final String? taskId;

  final TaskRepository _taskRepository = TaskRepository();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        title: Text(
          text,
          style: const TextStyle(
            fontSize: 18,
            fontFamily: 'Fredoka',
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                context.go('/home/taskedit/$text/$taskId');
              },
            ),
            IconButton(
              onPressed: () {
                _taskRepository.deleteTask(taskId);
              },
              icon: const Icon(Icons.delete),
            ),
          ],
        ),
      ),
    );
  }
}
