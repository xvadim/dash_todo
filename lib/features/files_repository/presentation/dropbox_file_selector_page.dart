import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../domain/dropbox_item.dart';
import 'dropbox_files_controller.dart';

class DropboxFileSelectorPage extends StatelessWidget {
  const DropboxFileSelectorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('settings.dropboxFilesSelectorTitle'.tr()),
        ),
        body: const DropboxFileSelector(),
      ),
    );
  }
}

// TODO: a top item to move up
class DropboxFileSelector extends ConsumerWidget {
  const DropboxFileSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(dropboxFilesControllerProvider);
    return switch (state) {
      AsyncError(:final error) => Center(
          child: Text('Something went wrong: $error'),
        ),
      AsyncData(:final value) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Center(child: Text(value.folder)),
              ),
              Expanded(
                child: ListView.separated(
                  itemCount: value.content.length,
                  itemBuilder: (_, idx) => _DropboxItemWidget(
                    index: idx,
                    item: value.content[idx],
                    onPressed: (index, item) =>
                        _onItemTap(context, ref, value.folder, index, item),
                  ),
                  separatorBuilder: (_, __) => const Divider(),
                ),
              ),
            ],
          ),
        ),
      _ => const Center(child: CircularProgressIndicator()),
    };
  }

  Future<void> _onItemTap(
    BuildContext context,
    WidgetRef ref,
    String folder,
    int index,
    DropboxItem item,
  ) async {
    if (item.isFile) {
      context.pop('$folder/${item.name}');
    } else {
      await ref
          .read(dropboxFilesControllerProvider.notifier)
          .listFolder(item.path);
    }
  }
}

class _DropboxItemWidget extends StatelessWidget {
  const _DropboxItemWidget({
    required this.index,
    required this.item,
    required this.onPressed,
  });

  final int index;
  final DropboxItem item;
  final Function(int idx, DropboxItem item) onPressed;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: item.isFile
          ? const FaIcon(FontAwesomeIcons.fileLines)
          : const Icon(Icons.folder, color: Colors.yellow),
      title: Text('${item.isFile ? '' : '/'}${item.name}'),
      onTap: () => onPressed(index, item),
    );
  }
}
