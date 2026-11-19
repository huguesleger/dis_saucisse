import 'package:dis_saucisse_desktop/features/storage/domain/entities/month_folder_format.dart';
import 'package:dis_saucisse_desktop/features/storage/domain/entities/storage_layout.dart';

Map<String, Object> storageLayoutToJson(StorageLayout layout) => <String, Object>{
  'byYear': layout.byYear,
  'byMonth': layout.byMonth,
  'monthFormat': layout.monthFormat.name,
  'byEvent': layout.byEvent,
  'discardedSubfolder': layout.discardedSubfolder,
  'renameFiles': layout.renameFiles,
};

StorageLayout jsonToStorageLayout(Object? json) => switch (json) {
  {
    'byYear': final bool byYear,
    'byMonth': final bool byMonth,
    'monthFormat': final String monthFormat,
    'byEvent': final bool byEvent,
    'discardedSubfolder': final bool discardedSubfolder,
    'renameFiles': final bool renameFiles,
  } =>
    StorageLayout(
      byYear: byYear,
      byMonth: byMonth,
      monthFormat:
          MonthFolderFormat.values.where((MonthFolderFormat f) => f.name == monthFormat).firstOrNull ??
          StorageLayout.defaults.monthFormat,
      byEvent: byEvent,
      discardedSubfolder: discardedSubfolder,
      renameFiles: renameFiles,
    ),
  _ => StorageLayout.defaults,
};
