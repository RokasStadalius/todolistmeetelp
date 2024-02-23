import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:todoappmeetelp/domain/repositories/task_repository.dart';
import 'package:todoappmeetelp/presentation/home/widgets/alert_dialog.dart';
import 'package:todoappmeetelp/providers/task_repository_provider.dart';

class TaskTile extends ConsumerWidget {
  const TaskTile({super.key, required this.text, required this.id});

  final String text;
  final String? id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                context.go('/taskedit/$id', extra: text);
                print(id);
              },
            ),
            IconButton(
              onPressed: () async {
                await _showDeleteConfirmation(context);
              },
              icon: const Icon(Icons.delete),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showDeleteConfirmation(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertConfirmation(taskId: id);
        });
  }
}
