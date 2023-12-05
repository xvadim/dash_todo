import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../../common/build_context_extension.dart';
import '../../application/tasks_controller.dart';

const priorityMarkerWidth = 4.0;

class TodoItem extends ConsumerWidget {
  const TodoItem({super.key});

  //TODO: calculate?
  static const itemExtent = 80.0;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final item = ref.watch(currentTask);
    final priorityColor = _priorityColor(item.priority);
    return Slidable(
      startActionPane: ActionPane(
        motion: const DrawerMotion(),
        children: [
          SlidableAction(
            onPressed: (_) => {},
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
            onPressed: (_) => {},
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      child: Container(
        decoration: BoxDecoration(
          //TODO: create themes
          color: Colors.grey.shade200,
          border: Border(
            top: BorderSide(color: Colors.grey.shade600),
            bottom: BorderSide(color: Colors.grey.shade600),
            right: BorderSide(color: Colors.grey.shade600),
          ),
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(8),
            bottomRight: Radius.circular(8),
          ),
        ),
        height: itemExtent,
        child: Row(
          children: [
            Container(
              color: priorityColor,
              width: priorityMarkerWidth,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: _PriorityIndicator(priority: item.priority),
            ),
            Expanded(
              child: Text(
                item.text,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PriorityIndicator extends StatelessWidget {
  const _PriorityIndicator({required this.priority});

  final String priority;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 32,
      height: 32,
      child: priority.isEmpty
          ? const SizedBox.shrink()
          : Container(
              decoration: BoxDecoration(
                color: _priorityColor(priority),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(priority, style: context.textTheme.titleLarge),
              ),
            ),
    );
  }
}

Color _priorityColor(String priority) => switch (priority) {
      'A' => Colors.red,
      'B' => Colors.orange,
      'C' => Colors.yellow,
      'D' => Colors.green,
      'E' => Colors.blue,
      'F' => Colors.deepPurple,
      '' => Colors.grey.shade400,
      _ => Colors.grey.shade600,
    };
