import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'dash_todo_app.dart';
import 'features/authentication/data/dropbox_auth_repository.dart';
import 'features/authentication/presentation/application/app_user_controller.dart';
import 'features/settings/data/settings_repository.dart';
import 'common/language_helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
    <DeviceOrientation>[DeviceOrientation.portraitUp],
  );

  await EasyLocalization.ensureInitialized();

  final container = await _initContainer();

  runApp(
    UncontrolledProviderScope(
      container: container,
      child: EasyLocalization(
        supportedLocales: LanguageHelper.sLocales.values.toList(),
        fallbackLocale: LanguageHelper.kEnglishLocale,
        path: 'assets/languages',
        child: const DashTodoApp(),
      ),
    ),
  );
}

Future<ProviderContainer> _initContainer() async {
  final container = ProviderContainer();
  await container.read(settingsRepositoryProvider.future);
  //TODO: move to initState of the TasksPage
  //TODO: login only when needed
  final dbProvider = container.read(dropboxAuthRepositoryProvider);
  if (dbProvider.isAuthorized) {
    await dbProvider.login();
  }
  final appUserCtr = container.read(appUserControllerProvider);
  await appUserCtr.loadUser();
  return container;
}
