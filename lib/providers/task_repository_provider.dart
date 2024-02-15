import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoappmeetelp/domain/repositories/task_repository.dart';

final taskRepositoryProvider = StateProvider<TaskRepository>(
  (ref) {
    return TaskRepository();
  },
);
