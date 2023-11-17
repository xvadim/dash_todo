import 'package:dash_todo/domain/task.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Completed tasks test', () {
    final completedTask = Task.fromString(1, 'x task');
    expect(completedTask.isCompleted, true);
    expect(completedTask.text, 'task');

    final nonCompletedStrings = [
      'X completed',
      ' x test',
      '(A)',
    ];

    for (final str in nonCompletedStrings) {
      final task = Task.fromString(1, str);
      expect(task.isCompleted, false);
    }
  });

  test('Task priority test', () {
    final priorityTask = Task.fromString(1, '(A) task');
    expect(priorityTask.priority, 'A');
    expect(priorityTask.text, 'task');

    final unPrioritizedStrings = [
      '(a) completed',
      '(A)test',
      '(.)',
    ];

    for (final str in unPrioritizedStrings) {
      final task = Task.fromString(1, str);
      expect(task.priority, isEmpty);
    }
  });
}
