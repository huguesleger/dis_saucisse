import 'package:transfer_protocol/transfer_protocol.dart';

final RegExp _heic = RegExp(r'\.(heic|heif)$', caseSensitive: false);

bool isHeic(String fileName) => _heic.hasMatch(fileName);

bool convertsHeicFor(ComputerPlatform platform) => switch (platform) {
  ComputerPlatform.windows => true,
  ComputerPlatform.macos => false,
};

String jpegFileName(String fileName) => fileName.replaceFirst(_heic, '.jpg');
