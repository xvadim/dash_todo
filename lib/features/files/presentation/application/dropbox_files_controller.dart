import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/dropbox_files_repository.dart';
import '../../domain/file_item.dart';

part 'dropbox_files_controller.g.dart';

final class ListFolderResult {
  ListFolderResult({required this.folder, required this.content});
  final String folder;
  final List<FileItem> content;
}

@riverpod
class DropboxFilesController extends _$DropboxFilesController {
  @override
  FutureOr<ListFolderResult> build() async {
    return _listFolder();
  }

  Future<void> listFolder(String folder) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _listFolder(folder));
  }

  Future<ListFolderResult> _listFolder([String folder = '']) async {
    final dropboxFilesRepo = ref.watch(dropboxFilesRepositoryProvider);
    final folderContent = await dropboxFilesRepo.listFolder(folder);
    return ListFolderResult(folder: folder, content: folderContent);
  }
}
