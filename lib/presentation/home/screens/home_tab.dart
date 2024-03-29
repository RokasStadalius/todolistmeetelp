import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:todoappmeetelp/data/services/auth_service.dart';
import 'package:todoappmeetelp/domain/repositories/task_repository.dart';
import 'package:todoappmeetelp/presentation/home/widgets/task_tile.dart';
import 'package:todoappmeetelp/presentation/widgets/base_page.dart';
import 'package:todoappmeetelp/data/models/task.dart';
import 'package:todoappmeetelp/providers/auth_serivce.provider.dart';
import 'package:todoappmeetelp/providers/task_repository_provider.dart';

class HomeTab extends ConsumerStatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeTabState();
}

class _HomeTabState extends ConsumerState<HomeTab> {
  @override
  void initState() {
    super.initState();
    _fetchTasks();
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      customAppBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("To-Do-List", style: TextStyle(color: Colors.black)),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.black),
            onPressed: () {
              ref.read(authNotifier.notifier).signOut();
            },
          )
        ],
      ),
      child: Consumer(
        builder: (context, watch, child) {
          final tasksState = ref.watch(taskProvider);
          return Stack(
            children: [
              SizedBox(
                height: 800,
                child: ListView.builder(
                  itemCount: tasksState.tasks.length,
                  itemBuilder: (context, index) {
                    final task = tasksState.tasks[index];
                    return TaskTile(
                      text: task.text,
                      id: task.id,
                    );
                  },
                ),
              ),
              Positioned(
                bottom: 16.0,
                right: 16.0,
                child: FloatingActionButton(
                  backgroundColor: Colors.green.shade500,
                  onPressed: () {
                    return context.go(
                      context.namedLocation('taskcreate'),
                    );
                  },
                  child: const Icon(Icons.add),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _fetchTasks() async {
    final taskNotifier = ref.read(taskProvider.notifier);
    final uid = ref.read(authNotifier.notifier).getCurrentUser()!.uid;
    await taskNotifier.fetchTasksStream(uid);
  }
}
