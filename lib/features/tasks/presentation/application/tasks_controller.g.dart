// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tasks_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$projectsHash() => r'59cbe6b6c41d24e4c1e527e816ff0cbf0315c01f';

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
String _$filteredTasksHash() => r'23c480c869b452e3bf6aa103dc04133264c3a0be';

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
String _$tasksControllerHash() => r'1541e17c9cf6a9bf698c976768f523ad82a63d91';

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
