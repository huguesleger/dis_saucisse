import 'package:flutter/foundation.dart';

@immutable
final class PhotoFile {
  const PhotoFile({required this.fileName, required this.bytes});

  final String fileName;
  final Uint8List bytes;
}
