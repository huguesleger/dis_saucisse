import 'package:dis_saucisse_desktop/features/storage/data/mappers/storage_layout_mapper.dart';
import 'package:dis_saucisse_desktop/features/storage/domain/entities/month_folder_format.dart';
import 'package:dis_saucisse_desktop/features/storage/domain/entities/storage_layout.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('reads back a saved layout', () {
    final StorageLayout layout = StorageLayout.defaults.copyWith(
      byEvent: false,
      monthFormat: MonthFolderFormat.monthName,
      renameFiles: true,
    );

    expect(jsonToStorageLayout(storageLayoutToJson(layout)), layout);
  });

  test('falls back to the default layout when the saved one is unreadable', () {
    expect(jsonToStorageLayout(<String, Object>{'byYear': 'oui'}), StorageLayout.defaults);
  });
}
