import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../features/authentication/data/dropbox_auth_repository.dart';
import '../features/authentication/presentation/sign_in_page.dart';
import '../features/files/presentation/dropbox_file_selector_page.dart';
import '../features/settings/presentation/files_setup_page.dart';
import '../features/tasks/presentation/tasks_page.dart';

part 'app_router.g.dart';

enum AppRoute {
  signIn,
  tasks,
  filesSetup,
  dropboxFilesSelector,
}

final _rootNavigatorKey = GlobalKey<NavigatorState>();

const _signInPath = '/signIn';
const _tasksPath = '/tasks';
const _filesSetup = '/filesSetup';
const _dropboxFilesSelector = 'dropboxFilesSelector';

@riverpod
GoRouter goRouter(GoRouterRef ref) {
  //TODO: support local syncing & auth
  final dropboxAuthRepository = ref.watch(dropboxAuthRepositoryProvider);
  return GoRouter(
    initialLocation: _tasksPath,
    navigatorKey: _rootNavigatorKey,
    debugLogDiagnostics: true,
    redirect: (context, state) {
      final path = state.uri.path;
      final isAuthorized = dropboxAuthRepository.isAuthorized;
      if (isAuthorized) {
        if (path.startsWith(_signInPath)) {
          return _filesSetup;
        }
      } else {
        if (path != _signInPath) {
          return _signInPath;
        }
      }
      return null;
    },
    refreshListenable: dropboxAuthRepository.appUser,
    routes: [
      GoRoute(
        path: _signInPath,
        name: AppRoute.signIn.name,
        pageBuilder: (context, state) => const NoTransitionPage(
          child: SignInPage(),
        ),
      ),
      GoRoute(
        path: _tasksPath,
        name: AppRoute.tasks.name,
        pageBuilder: (context, state) => const NoTransitionPage(
          child: TasksPage(title: 'Dash todO'),
        ),
      ),
      GoRoute(
        path: _filesSetup,
        name: AppRoute.filesSetup.name,
        builder: (context, state) => const FilesSetupPage(),
        routes: [
          GoRoute(
            path: _dropboxFilesSelector,
            name: AppRoute.dropboxFilesSelector.name,
            builder: (context, state) => const DropboxFileSelectorPage(),
          ),
        ],
      ),
    ],
  );
}
