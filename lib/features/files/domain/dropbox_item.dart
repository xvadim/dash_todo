import 'file_item.dart';

final class DropboxItem extends FileItem {
  DropboxItem({
    required super.name,
    required super.path,
    required super.isFile,
  });

  factory DropboxItem.fromMap(Map<Object?, Object?> itemMap) => DropboxItem(
        name: _safeCastToString(itemMap['name']),
        path: _safeCastToString(itemMap['pathLower']),
        isFile: itemMap['filesize'] != null,
      );

  static String _safeCastToString(Object? obj) => (obj is String) ? obj : '';
}
