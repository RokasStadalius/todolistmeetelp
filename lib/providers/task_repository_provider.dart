import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoappmeetelp/data/models/task.dart';
import 'package:todoappmeetelp/domain/repositories/task_repository.dart';

final taskProvider = StateNotifierProvider<TaskNotifier, TasksState>((ref) {
  return TaskNotifier(ref);
});

class TaskNotifier extends StateNotifier<TasksState> {
  TaskNotifier(this.ref) : super(TasksState());

  final Ref ref;
  late StreamSubscription<List<Task>> _tasksSubscription;

  Future<void> createTask(String task) async {
    await ref.read(dbProvider).createTask(task);
  }

  Future<void> fetchTasksStream(String uid) async {
    _tasksSubscription = ref.read(dbProvider).tasksStream(uid).listen((tasks) {
      state = state.copyWith(tasks: tasks);
    });
  }

  Future<void> deleteTask(String? taskId) async {
    await ref.read(dbProvider).deleteTask(taskId);
  }

  Future<void> editTask(String? taskId, String value) async {
    await ref.read(dbProvider).editTask(taskId, value);
  }

  @override
  void dispose() {
    _tasksSubscription.cancel();
    super.dispose();
  }
}

class TasksState {
  final List<Task> tasks;

  TasksState({
    this.tasks = const [],
  });

  TasksState copyWith({
    List<Task>? tasks,
  }) {
    return TasksState(
      tasks: tasks ?? this.tasks,
    );
  }
}
