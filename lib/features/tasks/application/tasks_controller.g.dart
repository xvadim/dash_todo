// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tasks_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$projectsHash() => r'a904d7d62ccd8eebe3af2971982fa48b34010297';

/// See also [projects].
@ProviderFor(projects)
final projectsProvider = AutoDisposeFutureProvider<Set<String>>.internal(
  projects,
  name: r'projectsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$projectsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ProjectsRef = AutoDisposeFutureProviderRef<Set<String>>;
String _$filteredTasksHash() => r'f7c584e3167dbf2c9e5d01b0e749e078859e97e3';

/// See also [filteredTasks].
@ProviderFor(filteredTasks)
final filteredTasksProvider = AutoDisposeProvider<AsyncValue<Todos>>.internal(
  filteredTasks,
  name: r'filteredTasksProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$filteredTasksHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef FilteredTasksRef = AutoDisposeProviderRef<AsyncValue<Todos>>;
String _$tasksControllerHash() => r'2b0504767c68faf3f3f44a3d87cf7e0516042aa3';

/// See also [TasksController].
@ProviderFor(TasksController)
final tasksControllerProvider =
    AsyncNotifierProvider<TasksController, Todos>.internal(
  TasksController.new,
  name: r'tasksControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$tasksControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$TasksController = AsyncNotifier<Todos>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
