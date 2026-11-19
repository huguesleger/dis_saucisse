import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:dis_saucisse_desktop/features/storage/data/data_sources/storage_target.dart';
import 'package:dis_saucisse_desktop/features/storage/domain/entities/storage_layout.dart';
import 'package:dis_saucisse_desktop/features/storage/domain/rules/photo_folder.dart';
import 'package:transfer_protocol/transfer_protocol.dart';

class ChecksumMismatchException implements Exception {
  const ChecksumMismatchException();
}

typedef StoredPhotoFile = ({String folder, String filePath});

class PhotoStorageDataSource {
  PhotoStorageDataSource(this._target);

  PhotoStorageDataSource.fixed(Directory root, {StorageLayout layout = StorageLayout.defaults})
    : _target = (() async => StorageTarget(root: root, layout: layout));

  final Future<StorageTarget> Function() _target;

  Future<Directory> currentRoot() async => (await _target()).root;

  Future<Set<String>> receivedPhotoIds(PhoneId phone) async =>
      ((await _readIndex(await currentRoot()))[phone.value] ?? <String>[]).toSet();

  Future<StoredPhotoFile> store(PhotoUpload upload, Stream<List<int>> body) async {
    final StorageTarget target = await _target();
    final List<String> folderSegments = photoFolderSegments(upload, target.layout);
    final Directory folder = await Directory(
      _join(<String>[target.root.path, ...folderSegments]),
    ).create(recursive: true);
    final Directory temporary = await Directory(
      _join(<String>[target.root.path, '.dis-saucisse', 'tmp']),
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
      storedFileName(upload, target.layout),
      (String candidate) => File(_join(<String>[folder.path, candidate])).existsSync(),
    );
    final File stored = await partial.rename(_join(<String>[folder.path, fileName]));
    await _markReceived(target.root, upload.phoneId, upload.photoId);
    return (folder: folderSegments.join('/'), filePath: stored.path);
  }

  File _index(Directory root) => File(_join(<String>[root.path, '.dis-saucisse', 'received.json']));

  Future<void> _markReceived(Directory root, PhoneId phone, String photoId) async {
    final Map<String, List<String>> index = await _readIndex(root);
    final Map<String, List<String>> updated = <String, List<String>>{
      ...index,
      phone.value: <String>{...?index[phone.value], photoId}.toList(),
    };
    await _index(root).parent.create(recursive: true);
    await _index(root).writeAsString(jsonEncode(updated));
  }

  Future<Map<String, List<String>>> _readIndex(Directory root) async => await _index(root).exists()
      ? (jsonDecode(await _index(root).readAsString()) as Map<String, dynamic>).map(
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
