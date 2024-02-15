import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todoappmeetelp/data/services/auth_service.dart';
import 'package:todoappmeetelp/domain/repositories/task_repository.dart';
import 'package:todoappmeetelp/presentation/home/widgets/task_tile.dart';
import 'package:todoappmeetelp/presentation/widgets/base_page.dart';
import 'package:todoappmeetelp/data/models/task.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  final TaskRepository _taskRepository = TaskRepository();
  late Stream<List<Task>> _tasksStream; // Define a stream of tasks
  final AuthService _auth = AuthService();

  @override
  void initState() {
    super.initState();
    _tasksStream = _taskRepository
        .fetchTasksStream(FirebaseAuth.instance.currentUser!.uid);
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      showAppBar: true,
      customAppBar: AppBar(
        title: const Text("To-Do-List"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              _auth.signOut();
              context.go('/');
            },
          )
        ],
      ),
      child: Stack(
        children: [
          StreamBuilder<List<Task>>(
            stream: _tasksStream,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              } else {
                final tasks = snapshot.data ?? [];
                return ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    final task = tasks[index];
                    return TaskTile(
                      text: task.text,
                      taskId: task.taskID,
                    );
                  },
                );
              }
            },
          ),
          Positioned(
            bottom: 16.0,
            right: 16.0,
            child: FloatingActionButton(
              onPressed: () {
                return context.go(
                  context.namedLocation('taskcreate'),
                );
              },
              child: const Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }
}