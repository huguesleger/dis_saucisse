import 'package:dis_saucisse_desktop/features/storage/domain/entities/month_folder_format.dart';
import 'package:flutter/foundation.dart';

@immutable
final class StorageLayout {
  const StorageLayout({
    required this.byYear,
    required this.byMonth,
    required this.monthFormat,
    required this.byEvent,
    required this.discardedSubfolder,
    required this.renameFiles,
  });

  static const StorageLayout defaults = StorageLayout(
    byYear: true,
    byMonth: true,
    monthFormat: MonthFolderFormat.yearMonthName,
    byEvent: true,
    discardedSubfolder: true,
    renameFiles: false,
  );

  final bool byYear;
  final bool byMonth;
  final MonthFolderFormat monthFormat;
  final bool byEvent;
  final bool discardedSubfolder;
  final bool renameFiles;

  StorageLayout copyWith({
    bool? byYear,
    bool? byMonth,
    MonthFolderFormat? monthFormat,
    bool? byEvent,
    bool? discardedSubfolder,
    bool? renameFiles,
  }) => StorageLayout(
    byYear: byYear ?? this.byYear,
    byMonth: byMonth ?? this.byMonth,
    monthFormat: monthFormat ?? this.monthFormat,
    byEvent: byEvent ?? this.byEvent,
    discardedSubfolder: discardedSubfolder ?? this.discardedSubfolder,
    renameFiles: renameFiles ?? this.renameFiles,
  );

  @override
  bool operator ==(Object other) =>
      other is StorageLayout &&
      other.byYear == byYear &&
      other.byMonth == byMonth &&
      other.monthFormat == monthFormat &&
      other.byEvent == byEvent &&
      other.discardedSubfolder == discardedSubfolder &&
      other.renameFiles == renameFiles;

  @override
  int get hashCode => Object.hash(byYear, byMonth, monthFormat, byEvent, discardedSubfolder, renameFiles);
}
