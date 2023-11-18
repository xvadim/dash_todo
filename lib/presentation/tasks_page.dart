import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../common/consts.dart';

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
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(color: Colors.blue),
                child: Center(
                  child: Icon(Icons.person),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.settings),
                title: Text('menu.settings'.tr()),
                onTap: () => print('aa'),
              ),
              const Divider(),
              const AboutListTile(
                icon: Icon(Icons.info),
                // applicationIcon:
                // Image(image: AssetImage('app.iconSmall'.tr())),
                applicationName: appTitle,
                applicationVersion: '1.0.0',
                applicationLegalese: '© 2023-24 XBASoft',
                child: Text(appTitle),
              ),
            ],
          ),
        ),
        body: const Placeholder(),
      ),
    );
  }
}
