import 'package:freezed_annotation/freezed_annotation.dart';

part 'tasks_filter.freezed.dart';

@freezed
class TasksFilter with _$TasksFilter {
  const factory TasksFilter({
    String? project,
    String? context,
  }) = _TasksFilter;
}
