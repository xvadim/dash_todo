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

  test('Task priorities test', () {
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

  group('Task dates tests', () {
    test('Correct dates test', () {
      final dateTask = Task.fromString(1, '(A) 2023-11-16 task');
      expect(dateTask.priority, 'A');
      expect(dateTask.completionDate, isNull);
      expect(dateTask.creationDate, DateTime(2023, 11, 16));
      expect(dateTask.text, 'task');

      final completedTask = Task.fromString(1, 'x 2023-11-16 task');
      expect(completedTask.isCompleted, true);
      expect(completedTask.completionDate, DateTime(2023, 11, 16));
      expect(completedTask.creationDate, null);
      expect(completedTask.text, 'task');

      final completedTask2 = Task.fromString(1, 'x 2023-11-17 2023-11-16 task');
      expect(completedTask2.isCompleted, true);
      expect(completedTask2.completionDate, DateTime(2023, 11, 17));
      expect(completedTask2.creationDate, DateTime(2023, 11, 16));
      expect(completedTask2.text, 'task');
    });

    test('Wrong dates test', () {
      // note two spaces before 2023
      final dateTask = Task.fromString(1, '(A)  2023-11-16 task');
      expect(dateTask.completionDate, isNull);
      expect(dateTask.creationDate, isNull);
      expect(dateTask.text, ' 2023-11-16 task');

      final dateTask2 = Task.fromString(1, '(A) 202a-11-16 task');
      expect(dateTask2.completionDate, isNull);
      expect(dateTask2.creationDate, isNull);
      expect(dateTask2.text, '202a-11-16 task');

      final dateTask3 = Task.fromString(1, '(A) 2023-42-16 task');
      expect(dateTask3.completionDate, isNull);
      expect(dateTask3.creationDate, isNull);
      expect(dateTask3.text, '2023-42-16 task');

      final dateTask4 = Task.fromString(1, 'x 2023-11-16 2023-42-16 task');
      expect(dateTask4.completionDate, DateTime(2023, 11, 16));
      expect(dateTask4.creationDate, isNull);

      final dateTask5 = Task.fromString(1, 'x 2023-42-16 2023-11-16 task');
      expect(dateTask5.completionDate, isNull);
      expect(dateTask5.creationDate, isNull);
    });
  });

  group('Projects and contexts test', () {
    test('Projects test', () {
      final taskWithProjects = Task.fromString(
        1,
        'a +prj task and +проект and +prj↑ and + non+prj +trailingPrj',
      );

      expect(taskWithProjects.projects, isNotEmpty);
      expect(taskWithProjects.projects, [
        'prj',
        'проект',
        'prj↑',
        'trailingPrj',
      ]);

      final taskWithoutProjects = Task.fromString(
        1,
        'prj task and проект and prj↑ and + non+prj ',
      );

      expect(taskWithoutProjects.projects, isEmpty);
    });

    test('Contexts test', () {
      final taskWithContexts = Task.fromString(
        1,
        'a @context task and @контекстї and @ctx↑ and @ non@ctx ',
      );

      expect(taskWithContexts.contexts, isNotEmpty);
      expect(taskWithContexts.contexts, ['context', 'контекстї', 'ctx↑']);

      final taskWithoutContexts = Task.fromString(
        1,
        'a context task and контекстї and ctx↑@ and @ non@ctx',
      );

      expect(taskWithoutContexts.contexts, isEmpty);
    });
  });

  test('Task to string test', () {
    final task = Task(
      id: 1,
      isCompleted: true,
      priority: 'A',
      completionDate: DateTime(2023, 11, 17),
      creationDate: DateTime(2023, 11, 16),
      text: 'task',
      projects: ['prj1', 'prj2'],
      contexts: ['ctx1', 'ctx2'],
    );
    expect(
      task.toRawString(),
      'x (A) 2023-11-17 2023-11-16 task +prj1 +prj2 @ctx1 @ctx2',
    );

    const strTask = '(A) task';
    final parsedTask = Task.fromString(1, strTask);
    expect(parsedTask.toRawString(), strTask);

    final completedTask = parsedTask.copyWith(isCompleted: true);
    expect(completedTask.toRawString(), 'x $strTask');

    const strCompletedTask = 'x task';
    final parsedCompletedTask = Task.fromString(1, strCompletedTask).copyWith(
      isCompleted: true,
    );
    expect(parsedCompletedTask.toRawString(), strCompletedTask);
  });
}
