import 'package:freezed_annotation/freezed_annotation.dart';

part 'task.freezed.dart';
part 'task.g.dart';

@Freezed()
class Task with _$Task {
  const factory Task({
    @Default(null) String? taskID,
    required String userId,
    required String text,
  }) = _Task;

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);
}
