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

List<String> photoFolderSegments(PhotoUpload upload) {
  final DateTime event = upload.eventDate;
  final String month = '${event.year}-${_twoDigits(event.month)}';
  final String day = '$month-${_twoDigits(event.day)}';
  return <String>[
    '${event.year}',
    '$month ${_monthNames[event.month - 1]}',
    upload.eventName.match(() => day, (String name) => safeFileName('$day $name')),
    if (upload.decision == PhotoDecisionKind.discarded) discardedFolderName,
  ];
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
