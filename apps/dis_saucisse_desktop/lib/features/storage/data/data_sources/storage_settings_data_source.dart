import 'dart:convert';
import 'dart:io';

import 'package:dis_saucisse_desktop/features/storage/data/data_sources/storage_target.dart';
import 'package:dis_saucisse_desktop/features/storage/data/mappers/storage_layout_mapper.dart';
import 'package:dis_saucisse_desktop/features/storage/domain/entities/storage_layout.dart';
import 'package:file_selector/file_selector.dart';
import 'package:macos_secure_bookmarks/macos_secure_bookmarks.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageSettingsDataSource {
  StorageSettingsDataSource(this._preferences);

  static const String _layoutKey = 'storage.layout';
  static const String _folderKey = 'storage.folder';
  static const String _bookmarkKey = 'storage.bookmark';

  final SharedPreferencesAsync _preferences;
  Future<Directory>? _resolvedFolder;

  static Directory get defaultFolder => Directory(
    <String>[
      Platform.environment[Platform.isWindows ? 'USERPROFILE' : 'HOME'] ?? '.',
      'Pictures',
      'Dis Saucisse',
    ].join(Platform.pathSeparator),
  );

  Future<StorageLayout> loadLayout() async {
    final String? stored = await _preferences.getString(_layoutKey);
    return stored == null ? StorageLayout.defaults : jsonToStorageLayout(jsonDecode(stored));
  }

  Future<void> saveLayout(StorageLayout layout) =>
      _preferences.setString(_layoutKey, jsonEncode(storageLayoutToJson(layout)));

  Future<String?> loadFolderPath() => _preferences.getString(_folderKey);

  Future<String?> pickAndSaveFolder() async {
    final String? path = await getDirectoryPath(confirmButtonText: 'Ranger ici');
    if (path == null) return null;
    await _preferences.setString(_folderKey, path);
    if (Platform.isMacOS) {
      await _preferences.setString(_bookmarkKey, await SecureBookmarks().bookmark(Directory(path)));
    }
    _resolvedFolder = null;
    return path;
  }

  Future<StorageTarget> currentTarget() async =>
      StorageTarget(root: await (_resolvedFolder ??= _resolveFolder()), layout: await loadLayout());

  Future<Directory> _resolveFolder() async {
    final String? path = await _preferences.getString(_folderKey);
    final String? bookmark = await _preferences.getString(_bookmarkKey);
    if (path == null) return defaultFolder;
    if (!Platform.isMacOS || bookmark == null) return Directory(path);
    final Directory folder = await SecureBookmarks().resolveBookmark(bookmark, isDirectory: true) as Directory;
    await SecureBookmarks().startAccessingSecurityScopedResource(folder);
    return folder;
  }
}
