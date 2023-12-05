import 'package:freezed_annotation/freezed_annotation.dart';

import 'task.dart';

part 'todos.freezed.dart';

@freezed
class Todos with _$Todos {
  const factory Todos({
    required List<Task> tasks,
    required Set<String> projects,
  }) = _Todos;
}
