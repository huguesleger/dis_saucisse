import 'dart:io';

import 'package:dis_saucisse_desktop/features/storage/domain/entities/storage_layout.dart';
import 'package:flutter/foundation.dart';

@immutable
final class StorageTarget {
  const StorageTarget({required this.root, required this.layout});

  final Directory root;
  final StorageLayout layout;
}
