import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoappmeetelp/data/models/task.dart';
import 'package:todoappmeetelp/data/services/auth_service.dart';

final dbProvider = Provider<TaskRepository>(
  (ref) {
    return TaskRepository(ref: ref);
  },
);

class TaskRepository {
  TaskRepository({required this.ref}) : _db = FirebaseFirestore.instance;

  final Ref ref;
  final FirebaseFirestore _db;

  Stream<List<Task>> tasksStream(String uid) {
    return _db
        .collection("Tasks")
        .where('userId', isEqualTo: uid)
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        final data = doc.data();
        return Task(
          id: doc.id,
          userId: data['userId'],
          text: data['text'],
        );
      }).toList();
    });
  }

  Future<void> createTask(String task) async {
    String userId = ref.read(authProvider).currentUser!.uid;
    await _db
        .collection("Tasks")
        .add({'text': task, 'userId': userId})
        .then((value) => print("Successfully added task"))
        .catchError((error) => print("Failed to add task: $error"));
  }

  Future<void> deleteTask(String? taskId) async {
    await _db.collection('Tasks').doc(taskId).delete().then(
      (value) {
        print("Task successfully deleted");
      },
    );
  }

  Future<void> editTask(String? taskId, String value) async {
    await _db.collection('Tasks').doc(taskId).update({
      'text': value,
    }).then(
      (value) => print("Task successfully edited"),
    );
  }
}
