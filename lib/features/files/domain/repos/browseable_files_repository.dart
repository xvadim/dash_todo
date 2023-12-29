import '../file_item.dart';
import 'base_files_repository.dart';

abstract class BrowseableFilesRepository extends BaseFilesRepository {
  /// Returns a list of entries in a given folder
  Future<List<FileItem>> listFolder([String folder = '']);

  /// Uploads given todo and archive files to the repository
  Future<void> uploadTasks({
    required String localTodoFile,
    required String localArchiveFile,
  });
}
