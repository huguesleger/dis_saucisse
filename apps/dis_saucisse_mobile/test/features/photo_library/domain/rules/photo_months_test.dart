import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/library_photo.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/photo_id.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/photo_month.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/photo_origin.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/rules/photo_months.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/rules/photos_to_sort.dart';
import 'package:flutter_test/flutter_test.dart';

LibraryPhoto _photo(String id, DateTime takenAt, [PhotoOrigin origin = PhotoOrigin.camera]) =>
    LibraryPhoto(id: PhotoId(id), takenAt: takenAt, origin: origin);

void main() {
  final List<LibraryPhoto> photos = <LibraryPhoto>[
    _photo('1', DateTime(2026, 9, 2)),
    _photo('2', DateTime(2026, 11, 8)),
    _photo('3', DateTime(2025, 12, 24)),
    _photo('4', DateTime(2026, 11, 9)),
  ];

  test('lists the months newest first, once each', () {
    expect(photoMonthsNewestFirst(photos), const <PhotoMonth>[
      PhotoMonth(year: 2026, month: 11),
      PhotoMonth(year: 2026, month: 9),
      PhotoMonth(year: 2025, month: 12),
    ]);
  });

  test('counts the photos of a month', () {
    expect(countPhotosIn(photos, const PhotoMonth(year: 2026, month: 11)), 2);
  });

  test('keeps only camera photos to sort', () {
    final List<LibraryPhoto> mixed = <LibraryPhoto>[
      _photo('1', DateTime(2026, 11, 8)),
      _photo('2', DateTime(2026, 11, 8), PhotoOrigin.screenshot),
      _photo('3', DateTime(2026, 11, 8), PhotoOrigin.messagingApp),
    ];

    expect(photosToSort(mixed).map((LibraryPhoto photo) => photo.id), const <PhotoId>[PhotoId('1')]);
  });
}
