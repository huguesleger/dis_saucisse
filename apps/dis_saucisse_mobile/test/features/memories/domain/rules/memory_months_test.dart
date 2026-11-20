import 'package:dis_saucisse_mobile/features/memories/domain/entities/memory_month.dart';
import 'package:dis_saucisse_mobile/features/memories/domain/entities/sent_photo_record.dart';
import 'package:dis_saucisse_mobile/features/memories/domain/rules/memory_months.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/entities/event_boundaries.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/entities/event_id.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/entities/photo_event.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/rules/photo_grouping.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/library_photo.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/photo_id.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/photo_month.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../helpers/photo_fixtures.dart';

SentPhotoRecord sent(String id, DateTime sentAt, [int bytes = 1000]) =>
    SentPhotoRecord(photoId: PhotoId(id), sentAt: sentAt, byteCount: bytes);

void main() {
  final List<PhotoEvent> events = groupIntoEvents(
    <LibraryPhoto>[
      ...saturdayPhotos,
      photoTakenAt('october', DateTime(2025, 10, 4, 10)),
    ],
    const <EventId, String>{},
    const EventBoundaries.none(),
  );

  test('groups the sent photos by the month they were taken, newest month first', () {
    final List<MemoryMonth> months = memoryMonthsNewestFirst(<SentPhotoRecord>[
      sent('cake-1', DateTime(2026, 11, 8), 3000),
      sent('walk', DateTime(2026, 11, 9), 2000),
      sent('october', DateTime(2026, 11, 9), 500),
    ], events);

    expect(months.map((MemoryMonth memory) => memory.month), const <PhotoMonth>[
      PhotoMonth(year: 2026, month: 11),
      PhotoMonth(year: 2025, month: 10),
    ]);
    expect(months.first.photoCount, 2);
    expect(months.first.eventCount, 2);
    expect(months.first.byteCount, 5000);
    expect(months.first.lastSentAt, DateTime(2026, 11, 9));
    expect(months.first.photosOnPhone, const <PhotoId>[PhotoId('walk'), PhotoId('cake-1')]);
  });

  test('files a photo no longer on the phone under the month it was sent', () {
    final List<MemoryMonth> months = memoryMonthsNewestFirst(<SentPhotoRecord>[
      sent('deleted', DateTime(2026, 9, 2)),
    ], events);

    expect(months.single.month, const PhotoMonth(year: 2026, month: 9));
    expect(months.single.photosOnPhone, isEmpty);
    expect(months.single.eventCount, 0);
  });

  test('counts a photo sent to two computers once, with its latest sending', () {
    final List<MemoryMonth> months = memoryMonthsNewestFirst(<SentPhotoRecord>[
      sent('cake-1', DateTime(2026, 11, 8), 3000),
      sent('cake-1', DateTime(2026, 11, 12), 3100),
    ], events);

    expect(months.single.photoCount, 1);
    expect(months.single.byteCount, 3100);
    expect(months.single.lastSentAt, DateTime(2026, 11, 12));
  });

  test('lists the years and keeps the months of the selected one', () {
    final List<MemoryMonth> months = memoryMonthsNewestFirst(<SentPhotoRecord>[
      sent('cake-1', DateTime(2026, 11, 8)),
      sent('october', DateTime(2026, 11, 9)),
    ], events);

    expect(memoryYearsNewestFirst(months), <int>[2026, 2025]);
    expect(memoryMonthsOf(months, some(2025)).single.month, const PhotoMonth(year: 2025, month: 10));
    expect(memoryMonthsOf(months, none()), months);
  });
}
