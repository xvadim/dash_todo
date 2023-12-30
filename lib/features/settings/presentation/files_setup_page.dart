import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../../routing/app_router.dart';
import '../data/settings_repository.dart';

// TODO: optimize, atm we rebuild the whole widget as it is pretty simple
// TODO: styling
class FilesSetupPage extends ConsumerStatefulWidget {
  const FilesSetupPage({super.key});

  @override
  ConsumerState<FilesSetupPage> createState() => _FilesSetupPageState();
}

class _FilesSetupPageState extends ConsumerState<FilesSetupPage> {
  @override
  void initState() {
    super.initState();
    final settingsRep = ref.read(settingsRepositoryProvider).requireValue;
    _files[0] = settingsRep.todoRemoteFile ?? _placeholder;
    _files[1] = settingsRep.archiveRemoteFile ?? _placeholder;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('settings.dropboxFilesSetupTitle'.tr())),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('settings.todoFile'.tr()),
              Text(_files[0]),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () async => _chooseFile(0),
                    child: Text('common.choose'.tr()),
                  ),
                ),
              ),
              const Divider(),
              Text('settings.archiveFile'.tr()),
              Text(_files[1]),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () async => _chooseFile(1),
                    child: Text('common.choose'.tr()),
                  ),
                ),
              ),
              const Divider(),
              const Expanded(
                child: Center(
                  child: FaIcon(
                    FontAwesomeIcons.dropbox,
                    color: Colors.blue,
                    size: 64,
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: !_isDoneEnabled ? null : () async => _done(),
                    child: Text('common.done'.tr()),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  final List<String> _files = [_placeholder, _placeholder];
  static const _placeholder = '?';

  Future<void> _chooseFile(int index) async {
    final fileName =
        await context.pushNamed<String?>(AppRoute.dropboxFilesSelector.name);
    if (fileName != null) {
      setState(() {
        _files[index] = fileName;
      });
    }
  }

  Future<void> _done() async {
    final settingsRep = ref.read(settingsRepositoryProvider).requireValue;
    await settingsRep.saveRemotePaths(
      todoFile: _files[0],
      archiveFile: _files[1],
    );
    if (mounted) {
      if (context.canPop()) {
        context.pop();
      } else {
        //It's a case after login to Dropbox and setup files
        //TODO: force download
        context.goNamed(AppRoute.tasks.name);
      }
    }
  }

  bool get _isDoneEnabled =>
      _files[0] != _placeholder && _files[1] != _placeholder;
}
