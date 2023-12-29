// The 'I' letter from SOLID
abstract class BaseFilesRepository {
  /// Downloads todo- and archive- files from a repository to temporary files
  /// Returns paths to downloaded files
  Future<(String? todoFile, String? archiveFile)> downloadTasks();
}
