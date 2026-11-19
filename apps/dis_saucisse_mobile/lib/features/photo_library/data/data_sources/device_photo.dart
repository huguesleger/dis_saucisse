import 'package:flutter/foundation.dart';

@immutable
final class DevicePhoto {
  const DevicePhoto({
    required this.id,
    required this.createdAt,
    required this.mediaSubtypes,
    required this.relativePath,
    required this.isInMessagingAlbum,
  });

  final String id;
  final DateTime createdAt;
  final int mediaSubtypes;
  final String? relativePath;
  final bool isInMessagingAlbum;
}
