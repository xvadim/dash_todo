import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/tasks_controller.dart';
import '../../application/tasks_filter_contoller.dart';

class ProjectChooser extends ConsumerWidget {
  const ProjectChooser({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(projectsProvider);
    final selectedProject = ref.watch(
      tasksFilterControllerProvider.select((f) => f.project),
    );
    if (state case AsyncData(value: final projects)) {
      return DropdownMenu<String>(
        initialSelection: selectedProject ?? projects.first,
        onSelected: (String? value) {
          if (value != null) {
            ref.read(tasksFilterControllerProvider.notifier).setProject(
                  value,
                );
          }
        },
        dropdownMenuEntries:
            projects.map<DropdownMenuEntry<String>>((String value) {
          return DropdownMenuEntry<String>(value: value, label: value);
        }).toList(),
        inputDecorationTheme: const InputDecorationTheme(
          border: InputBorder.none,
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
