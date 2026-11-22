import 'package:dis_saucisse_desktop/features/storage/domain/entities/storage_layout.dart';
import 'package:dis_saucisse_desktop/features/storage/domain/rules/photo_folder.dart';
import 'package:fpdart/fpdart.dart';
import 'package:transfer_protocol/transfer_protocol.dart';

typedef PreviewFolder = ({int depth, String name, bool isContext});

const int previewMonth = 11;

List<PhotoUpload> _examples(int year) => <PhotoUpload>[
  for (final (DateTime date, String name, PhotoDecisionKind decision) in <(DateTime, String, PhotoDecisionKind)>[
    (DateTime(year, previewMonth, 8), 'Anniversaire de mamie', PhotoDecisionKind.kept),
    (DateTime(year, previewMonth, 8), 'Anniversaire de mamie', PhotoDecisionKind.discarded),
    (DateTime(year, previewMonth, 16), 'Balade en forêt', PhotoDecisionKind.kept),
    (DateTime(year, previewMonth, 19), 'Goûter chez les voisins', PhotoDecisionKind.kept),
    (DateTime(year, previewMonth - 1, 4), 'Cueillette de pommes', PhotoDecisionKind.kept),
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

List<PreviewFolder> storagePreview(StorageLayout layout, {required int year}) {
  final List<PreviewFolder> folders = <PreviewFolder>[];
  final Set<String> seen = <String>{};
  for (final PhotoUpload upload in _examples(year)) {
    final List<String> path = photoFolderSegments(upload, layout);
    for (int depth = 0; depth < path.length; depth++) {
      final String key = path.take(depth + 1).join('/');
      if (seen.add(key)) folders.add((depth: depth, name: path[depth], isContext: !_isPreviewMonth(upload)));
    }
  }
  return folders;
}

bool _isPreviewMonth(PhotoUpload upload) => upload.eventDate.month == previewMonth;
