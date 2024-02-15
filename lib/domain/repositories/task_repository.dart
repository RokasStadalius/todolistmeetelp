import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todoappmeetelp/data/models/task.dart';

class TaskRepository {
  final _db = FirebaseFirestore.instance;

  createTask(Task task) async {
    await _db
        .collection("Tasks")
        .add(task.toJson())
        .then((value) => print("Successfully added task"))
        .catchError((error) => print("Failed to add task: $error"));
  }

  Stream<List<Task>> fetchTasksStream(String uid) {
    return _db
        .collection("Tasks")
        .where('userId', isEqualTo: uid)
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        final data = doc.data();
        return Task.fromJson(data).copyWith(taskID: doc.id);
      }).toList();
    });
  }

  void deleteTask(String? taskId) {
    _db.collection('Tasks').doc(taskId).delete().then(
      (value) {
        print("Task successfully deleted");
      },
    );
  }

  void editTask(String? taskId, String value) {
    _db.collection('Tasks').doc(taskId).update({
      'text': value,
    }).then(
      (value) => print("Task successfully edited"),
    );
  }
}
