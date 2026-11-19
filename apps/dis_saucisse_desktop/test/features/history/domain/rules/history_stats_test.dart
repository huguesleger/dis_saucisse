import 'package:dis_saucisse_desktop/features/history/domain/entities/transfer_record.dart';
import 'package:dis_saucisse_desktop/features/history/domain/rules/history_stats.dart';
import 'package:flutter_test/flutter_test.dart';

TransferRecord _record(DateTime receivedAt, {int photos = 10, int events = 2}) => TransferRecord(
  receivedAt: receivedAt,
  phoneName: 'iPhone',
  photoCount: photos,
  rejectedCount: 1,
  byteCount: 1000,
  eventCount: events,
);

void main() {
  final List<TransferRecord> records = <TransferRecord>[
    _record(DateTime(2025, 12, 24)),
    _record(DateTime(2026, 3, 1), photos: 4, events: 1),
    _record(DateTime(2026, 11, 8)),
  ];

  test('lists the years newest first', () {
    expect(historyYearsNewestFirst(records), <int>[2026, 2025]);
  });

  test('keeps the transfers of a year, newest first', () {
    expect(recordsOfYear(records, 2026).map((TransferRecord r) => r.receivedAt), <DateTime>[
      DateTime(2026, 11, 8),
      DateTime(2026, 3, 1),
    ]);
  });

  test('adds up the transfers of a year', () {
    expect(statsOf(recordsOfYear(records, 2026)), (photoCount: 14, eventCount: 3, byteCount: 2000, rejectedCount: 2));
  });
}
