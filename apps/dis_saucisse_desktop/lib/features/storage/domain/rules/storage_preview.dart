import 'package:dis_saucisse_desktop/features/storage/domain/entities/storage_layout.dart';
import 'package:dis_saucisse_desktop/features/storage/domain/rules/photo_folder.dart';
import 'package:fpdart/fpdart.dart';
import 'package:transfer_protocol/transfer_protocol.dart';

typedef PreviewFolder = ({int depth, String name});

final List<PhotoUpload> _examples = <PhotoUpload>[
  for (final (DateTime date, String name, PhotoDecisionKind decision) in <(DateTime, String, PhotoDecisionKind)>[
    (DateTime(2026, 11, 8), 'Anniversaire de mamie', PhotoDecisionKind.kept),
    (DateTime(2026, 11, 8), 'Anniversaire de mamie', PhotoDecisionKind.discarded),
    (DateTime(2026, 11, 16), 'Balade en forêt', PhotoDecisionKind.kept),
    (DateTime(2026, 10, 2), 'Goûter chez les voisins', PhotoDecisionKind.kept),
  ])
    PhotoUpload(
      phoneId: const PhoneId('preview'),
      photoId: '$date$decision',
      fileName: 'IMG_2034.jpg',
      takenAt: date,
      eventDate: date,
      eventName: some(name),
      decision: decision,
      sha256: '',
    ),
];

List<PreviewFolder> storagePreview(StorageLayout layout) {
  final List<List<String>> paths = _examples.map((PhotoUpload upload) => photoFolderSegments(upload, layout)).toList();
  final List<PreviewFolder> folders = <PreviewFolder>[];
  final Set<String> seen = <String>{};
  for (final List<String> path in paths) {
    for (int depth = 0; depth < path.length; depth++) {
      final String key = path.take(depth + 1).join('/');
      if (seen.add(key)) folders.add((depth: depth, name: path[depth]));
    }
  }
  return folders;
}
