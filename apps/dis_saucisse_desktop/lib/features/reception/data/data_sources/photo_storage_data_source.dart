import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:dis_saucisse_desktop/features/reception/domain/rules/photo_folder.dart';
import 'package:transfer_protocol/transfer_protocol.dart';

class ChecksumMismatchException implements Exception {
  const ChecksumMismatchException();
}

class PhotoStorageDataSource {
  PhotoStorageDataSource({Directory? root}) : _rootOverride = root;

  final Directory? _rootOverride;

  Directory get root =>
      _rootOverride ??
      Directory(
        <String>[
          Platform.environment[Platform.isWindows ? 'USERPROFILE' : 'HOME'] ?? '.',
          'Pictures',
          'Dis Saucisse',
        ].join(Platform.pathSeparator),
      );

  File get _index => File(_join(<String>[root.path, '.dis-saucisse', 'received.json']));

  Future<Set<String>> receivedPhotoIds(PhoneId phone) async =>
      ((await _readIndex())[phone.value] ?? <String>[]).toSet();

  Future<String> store(PhotoUpload upload, Stream<List<int>> body) async {
    final List<String> folderSegments = photoFolderSegments(upload);
    final Directory folder = await Directory(_join(<String>[root.path, ...folderSegments])).create(recursive: true);
    final Directory temporary = await Directory(
      _join(<String>[root.path, '.dis-saucisse', 'tmp']),
    ).create(recursive: true);
    final File partial = File(_join(<String>[temporary.path, '${DateTime.now().microsecondsSinceEpoch}.part']));
    final _DigestSink digestSink = _DigestSink();
    final ByteConversionSink hasher = sha256.startChunkedConversion(digestSink);
    final IOSink writer = partial.openWrite();
    await for (final List<int> chunk in body) {
      hasher.add(chunk);
      writer.add(chunk);
    }
    hasher.close();
    await writer.close();
    if (digestSink.value.toString() != upload.sha256.toLowerCase()) {
      await partial.delete();
      throw const ChecksumMismatchException();
    }
    final String fileName = availableFileName(
      upload.fileName,
      (String candidate) => File(_join(<String>[folder.path, candidate])).existsSync(),
    );
    await partial.rename(_join(<String>[folder.path, fileName]));
    await _markReceived(upload.phoneId, upload.photoId);
    return folderSegments.join('/');
  }

  Future<void> _markReceived(PhoneId phone, String photoId) async {
    final Map<String, List<String>> index = await _readIndex();
    final Map<String, List<String>> updated = <String, List<String>>{
      ...index,
      phone.value: <String>{...?index[phone.value], photoId}.toList(),
    };
    await _index.parent.create(recursive: true);
    await _index.writeAsString(jsonEncode(updated));
  }

  Future<Map<String, List<String>>> _readIndex() async => await _index.exists()
      ? (jsonDecode(await _index.readAsString()) as Map<String, dynamic>).map(
          (String phone, dynamic ids) => MapEntry<String, List<String>>(phone, List<String>.from(ids as List<dynamic>)),
        )
      : <String, List<String>>{};

  String _join(List<String> parts) => parts.join(Platform.pathSeparator);
}

class _DigestSink implements Sink<Digest> {
  late Digest value;

  @override
  void add(Digest data) => value = data;

  @override
  void close() {}
}
