import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/sizes.dart';
import '../../../common_widgets/app_drawer.dart';
import '../application/tasks_controller.dart';
import 'widgets/toto_item.dart';

enum _MenuItem {
  downloadTasks,
  uploadTasks,
}

class TasksPage extends ConsumerWidget {
  const TasksPage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(title),
          actions: [
            PopupMenuButton<_MenuItem>(
              icon: const Icon(Icons.more_vert),
              itemBuilder: (_) => [
                PopupMenuItem(
                  value: _MenuItem.downloadTasks,
                  child: Row(
                    children: [
                      const Icon(Icons.download),
                      Text('actions.download'.tr()),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: _MenuItem.uploadTasks,
                  child: Row(
                    children: [
                      const Icon(Icons.upload),
                      Text('actions.upload'.tr()),
                    ],
                  ),
                ),
              ],
              onSelected: (item) => _onItemTap(context, ref, item),
            ),
          ],
        ),
        drawer: const Drawer(child: AppDrawer()),
        body: const _TasksListView(),
      ),
    );
  }

  Future<void> _onItemTap(
    BuildContext context,
    WidgetRef ref,
    _MenuItem item,
  ) async {
    final taskController = ref.watch(
      tasksControllerProvider.notifier,
    );
    taskController.downloadTasks();
  }
}

class _TasksListView extends ConsumerWidget {
  const _TasksListView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(tasksControllerProvider);

    return switch (state) {
      AsyncError(:final error) => Center(
          child: Text('Something went wrong: $error'),
        ),
      AsyncData(value: final tasks) => Padding(
          padding: const EdgeInsets.only(right: 1.0),
          child: CustomScrollView(
            slivers: [
              SliverList.separated(
                itemCount: tasks.length,
                itemBuilder: (_, idx) => ProviderScope(
                  overrides: [
                    currentTask.overrideWithValue(tasks[idx]),
                  ],
                  child: const TodoItem(),
                ),
                separatorBuilder: (_, __) => gapH2,
              ),
            ],
          ),
        ),
      _ => const Center(child: CircularProgressIndicator()),
    };
  }
}
