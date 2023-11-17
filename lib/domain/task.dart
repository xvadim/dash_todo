import 'package:freezed_annotation/freezed_annotation.dart';

part 'task.freezed.dart';

@freezed
class Task with _$Task {
  const factory Task({
    required int id,
    @Default(false) bool isCompleted,
    @Default('') String priority,
    DateTime? completionDate,
    DateTime? creationDate,
    required String text,
    @Default([]) List<String> contexts,
    @Default([]) List<String> projects,
    required String rawString,
  }) = _Task;

  // see https://github.com/todotxt/todo.txt
  // 'x (A) 2023-11-17 2023-11-16 some text +projectTag @contextTag another txt'
  factory Task.fromString(int id, String string) {
    final rawString = string;

    // don't use regexp for such simple checks
    bool isCompleted = false;
    if (string.startsWith(_completionMark)) {
      isCompleted = true;
      string = string.removePrefix(_completionMarkLength);
    }

    String priority = '';
    if (string.length >= _prioriTyMarkLength &&
        string[0] == '(' &&
        string[2] == ')' &&
        string[3] == ' ' &&
        _priorityMarks.contains(string[1])) {
      priority = string[1];
      string = string.removePrefix(_prioriTyMarkLength);
    }

    return Task(
      id: id,
      isCompleted: isCompleted,
      priority: priority,
      text: string,
      rawString: rawString,
    );
  }

  static const _completionMark = 'x ';
  static const _completionMarkLength = _completionMark.length;
  static const _priorityMarks = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  static const _prioriTyMarkLength = '(A) '.length;
}

extension TaskEx on Task {
  String toRawString() {
    return 'test';
  }
}

extension StringEx on String {
  String removePrefix(int prefixLength) =>
      prefixLength >= length ? '' : substring(prefixLength);
}
