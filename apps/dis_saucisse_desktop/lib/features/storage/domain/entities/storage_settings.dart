import 'package:dis_saucisse_desktop/features/storage/domain/entities/storage_layout.dart';
import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';

@immutable
final class StorageSettings {
  const StorageSettings({required this.folderPath, required this.layout});

  final Option<String> folderPath;
  final StorageLayout layout;
}
