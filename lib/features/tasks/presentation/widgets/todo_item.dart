import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../../common/build_context_extension.dart';
import '../application/tasks_controller.dart';
import '../../domain/task.dart';

const priorityMarkerWidth = 4.0;

class TodoItem extends ConsumerWidget {
  const TodoItem({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final item = ref.watch(currentTask);
    final basePriorityColor = _priorityColor(
      item.isCompleted ? '' : item.priority,
    );
    final fillColor = item.priority.isEmpty
        ? basePriorityColor.shade200
        : basePriorityColor.shade100;
    final priorityColor = item.priority.isEmpty || item.isCompleted
        ? basePriorityColor.shade300
        : basePriorityColor;

    return Slidable(
      startActionPane: item.isCompleted
          ? null
          : ActionPane(
              motion: const DrawerMotion(),
              children: [
                SlidableAction(
                  onPressed: (_) async => _completeTask(ref, item),
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  icon: Icons.check,
                  label: 'Done',
                ),
                SlidableAction(
                  onPressed: (_) => {},
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  icon: Icons.play_arrow,
                  label: 'Run',
                ),
              ],
            ),
      endActionPane: ActionPane(
        motion: const DrawerMotion(),
        children: [
          SlidableAction(
            onPressed: (_) async => _deleteTask(ref, item),
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
            borderRadius: const BorderRadius.all(_borderRadius),
          ),
        ],
      ),
      child: Container(
        decoration: BoxDecoration(
          //TODO: create themes
          color: fillColor,
          border: Border(
            top: BorderSide(color: Colors.grey.shade700),
            bottom: BorderSide(color: Colors.grey.shade700),
            right: BorderSide(color: Colors.grey.shade700),
          ),
          borderRadius: const BorderRadius.only(
            topRight: _borderRadius,
            bottomRight: _borderRadius,
          ),
        ),
        height: _itemExtent,
        child: Row(
          children: [
            _PriorityBar(color: priorityColor),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: _PriorityIndicator(
                priority: item.priority,
                color: priorityColor,
              ),
            ),
            Expanded(
              child: Text(
                item.text,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  decoration:
                      item.isCompleted ? TextDecoration.lineThrough : null,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //TODO: calculate
  static const _itemExtent = 80.0;
  static const _borderRadius = Radius.circular(8);

  Future<void> _completeTask(WidgetRef ref, Task task) async {
    final taskController = ref.read(tasksControllerProvider.notifier);
    await taskController.completeTask(task);
  }

  Future<void> _deleteTask(WidgetRef ref, Task task) async {
    //TODO: confirmation & undo
    final taskController = ref.read(tasksControllerProvider.notifier);
    await taskController.deleteTask(task);
  }
}

class _PriorityBar extends StatelessWidget {
  const _PriorityBar({super.key, required this.color});
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: priorityMarkerWidth,
      height: double.maxFinite,
      child: ColoredBox(color: color),
    );
  }
}

class _PriorityIndicator extends StatelessWidget {
  const _PriorityIndicator({required this.priority, required this.color});

  final String priority;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _indicatorSize,
      height: _indicatorSize,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          border: Border.all(),
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            priority,
            style: context.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  static const _indicatorSize = 32.0;
}

MaterialColor _priorityColor(String priority) => switch (priority) {
      'A' => Colors.red,
      'B' => Colors.orange,
      'C' => Colors.yellow,
      'D' => Colors.green,
      'E' => Colors.blue,
      'F' => Colors.deepPurple,
      '' => Colors.grey,
      _ => Colors.grey,
    };
