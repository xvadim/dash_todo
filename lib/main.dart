import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'helpers/language_helper.dart';
import 'presentation/tasks_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
    <DeviceOrientation>[DeviceOrientation.portraitUp],
  );

  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: LanguageHelper.sLocales.values.toList(),
      fallbackLocale: LanguageHelper.kEnglishLocale,
      path: 'assets/languages',
      child: const DashTodoApp(),
    ),
  );
}

class DashTodoApp extends StatelessWidget {
  const DashTodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dash todO',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const TasksPage(title: 'Dash todO'),
    );
  }
}
