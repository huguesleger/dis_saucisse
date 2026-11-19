import 'package:dis_saucisse_desktop/features/history/domain/entities/transfer_record.dart';
import 'package:dis_saucisse_desktop/features/history/domain/entities/year_stats.dart';

List<int> historyYearsNewestFirst(List<TransferRecord> records) =>
    records.map((TransferRecord record) => record.receivedAt.year).toSet().toList()..sort((int a, int b) => b - a);

List<TransferRecord> recordsOfYear(List<TransferRecord> records, int year) =>
    records.where((TransferRecord record) => record.receivedAt.year == year).toList()
      ..sort((TransferRecord a, TransferRecord b) => b.receivedAt.compareTo(a.receivedAt));

YearStats statsOf(List<TransferRecord> records) => records.fold(
  (photoCount: 0, eventCount: 0, byteCount: 0, rejectedCount: 0),
  (YearStats total, TransferRecord record) => (
    photoCount: total.photoCount + record.photoCount,
    eventCount: total.eventCount + record.eventCount,
    byteCount: total.byteCount + record.byteCount,
    rejectedCount: total.rejectedCount + record.rejectedCount,
  ),
);
