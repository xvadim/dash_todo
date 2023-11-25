import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'dash_todo_app.dart';
import 'features/settings/data/settings_repository.dart';
import 'helpers/language_helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
    <DeviceOrientation>[DeviceOrientation.portraitUp],
  );

  await EasyLocalization.ensureInitialized();

  final container = ProviderContainer();
  await container.read(settingsRepositoryProvider.future);

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
