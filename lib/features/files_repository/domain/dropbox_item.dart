final class DropboxItem {
  DropboxItem._({
    required this.name,
    required this.path,
    required this.isFile,
  });
  final String name;
  final String path;
  final bool isFile;

  factory DropboxItem.fromMap(Map<Object?, Object?> itemMap) => DropboxItem._(
        name: _safeCastToString(itemMap['name']),
        path: _safeCastToString(itemMap['pathLower']),
        isFile: itemMap['filesize'] != null,
      );

  static String _safeCastToString(Object? obj) => (obj is String) ? obj : '';
}
