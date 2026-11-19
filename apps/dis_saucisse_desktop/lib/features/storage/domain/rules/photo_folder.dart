import 'package:dis_saucisse_desktop/features/storage/domain/entities/month_folder_format.dart';
import 'package:dis_saucisse_desktop/features/storage/domain/entities/storage_layout.dart';
import 'package:transfer_protocol/transfer_protocol.dart';

const List<String> _monthNames = <String>[
  'Janvier',
  'Février',
  'Mars',
  'Avril',
  'Mai',
  'Juin',
  'Juillet',
  'Août',
  'Septembre',
  'Octobre',
  'Novembre',
  'Décembre',
];

const String discardedFolderName = 'Écartées';

String _twoDigits(int value) => value.toString().padLeft(2, '0');

String safeFileName(String name) {
  final String cleaned = name.replaceAll(RegExp(r'[<>:"/\\|?*\x00-\x1F]'), ' ').replaceAll(RegExp(r'\s+'), ' ').trim();
  return cleaned.isEmpty || cleaned == '.' || cleaned == '..' ? 'photo' : cleaned;
}

String monthFolderName(DateTime date, MonthFolderFormat format) => switch (format) {
  MonthFolderFormat.yearMonthName => '${date.year}-${_twoDigits(date.month)} ${_monthNames[date.month - 1]}',
  MonthFolderFormat.monthNumberName => '${_twoDigits(date.month)} ${_monthNames[date.month - 1]}',
  MonthFolderFormat.monthName => _monthNames[date.month - 1],
};

String _isoDay(DateTime date) => '${date.year}-${_twoDigits(date.month)}-${_twoDigits(date.day)}';

List<String> photoFolderSegments(PhotoUpload upload, StorageLayout layout) {
  final DateTime event = upload.eventDate;
  return <String>[
    if (layout.byYear) '${event.year}',
    if (layout.byMonth) monthFolderName(event, layout.monthFormat),
    if (layout.byEvent)
      upload.eventName.match(() => _isoDay(event), (String name) => safeFileName('${_isoDay(event)} $name')),
    if (layout.discardedSubfolder && upload.decision == PhotoDecisionKind.discarded) discardedFolderName,
  ];
}

String storedFileName(PhotoUpload upload, StorageLayout layout) {
  final int dot = upload.fileName.lastIndexOf('.');
  final String extension = dot > 0 ? upload.fileName.substring(dot).toLowerCase() : '';
  final DateTime taken = upload.takenAt;
  return layout.renameFiles
      ? '${_isoDay(taken)} ${_twoDigits(taken.hour)}.${_twoDigits(taken.minute)}.${_twoDigits(taken.second)}$extension'
      : upload.fileName;
}

String availableFileName(String fileName, bool Function(String candidate) exists) {
  final String safe = safeFileName(fileName);
  final int dot = safe.lastIndexOf('.');
  final String base = dot > 0 ? safe.substring(0, dot) : safe;
  final String extension = dot > 0 ? safe.substring(dot) : '';
  return <String>[
    safe,
    for (int copy = 2; copy < 10000; copy++) '$base ($copy)$extension',
  ].firstWhere((String candidate) => !exists(candidate));
}

String eventKeyOf(PhotoUpload upload) =>
    '${upload.eventDate.toIso8601String()} ${upload.eventName.match(() => '', (String name) => name)}';
