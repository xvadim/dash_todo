import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/tasks_filter.dart';

part 'tasks_filter_contoller.g.dart';

@riverpod
class TasksFilterController extends _$TasksFilterController {
  @override
  TasksFilter build() => const TasksFilter();

  void setProject(String? project) {
    state = state.copyWith(project: project);
  }
}
