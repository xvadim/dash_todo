import 'package:flutter/material.dart';

import 'presentation/tasks_page.dart';

void main() {
  runApp(const DashTodoApp());
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
