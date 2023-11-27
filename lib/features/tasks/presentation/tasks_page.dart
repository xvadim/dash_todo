import 'package:flutter/material.dart';

import '../../../common_widgets/app_drawer.dart';

class TasksPage extends StatelessWidget {
  const TasksPage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(title),
        ),
        drawer: const Drawer(child: AppDrawer()),
        body: const Placeholder(),
      ),
    );
  }
}
