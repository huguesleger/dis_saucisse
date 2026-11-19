import 'package:dis_saucisse_desktop/features/storage/domain/entities/storage_layout.dart';
import 'package:dis_saucisse_desktop/features/storage/domain/rules/storage_preview.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('shows each folder once, nested under its parent', () {
    expect(storagePreview(StorageLayout.defaults), <PreviewFolder>[
      (depth: 0, name: '2026', isContext: false),
      (depth: 1, name: '2026-11 Novembre', isContext: false),
      (depth: 2, name: '2026-11-08 Anniversaire de mamie', isContext: false),
      (depth: 3, name: 'Écartées', isContext: false),
      (depth: 2, name: '2026-11-16 Balade en forêt', isContext: false),
      (depth: 2, name: '2026-11-19 Goûter chez les voisins', isContext: false),
      (depth: 1, name: '2026-10 Octobre', isContext: true),
      (depth: 2, name: '2026-10-04 Cueillette de pommes', isContext: true),
    ]);
  });

  test('shows no folder when everything goes to the root', () {
    expect(
      storagePreview(
        StorageLayout.defaults.copyWith(byYear: false, byMonth: false, byEvent: false, discardedSubfolder: false),
      ),
      isEmpty,
    );
  });
}
