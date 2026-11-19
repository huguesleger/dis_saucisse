import 'package:dis_saucisse_mobile/features/photo_events/domain/entities/event_id.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/entities/photo_event.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/rules/photo_grouping.dart';
import 'package:dis_saucisse_mobile/features/photo_events/presentation/event_labels.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/library_photo.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/photo_id.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/photo_origin.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';

PhotoEvent _event(List<DateTime> dates) => groupIntoEvents(
  dates.indexed
      .map(
        ((int, DateTime) entry) =>
            LibraryPhoto(id: PhotoId('${entry.$1}'), takenAt: entry.$2, origin: PhotoOrigin.camera),
      )
      .toList(),
  <EventId, String>{},
).single;

void main() {
  final PhotoEvent saturday = _event(<DateTime>[
    DateTime(2026, 11, 7, 14, 0, 0),
    DateTime(2026, 11, 7, 14, 0, 3),
    DateTime(2026, 11, 7, 15, 0),
  ]);

  test('names an unnamed one-day event after its day', () {
    expect(eventTitle(saturday), 'Samedi 7 novembre');
  });

  test('uses the name typed by the user', () {
    expect(eventTitle(saturday.copyWith(name: some('Anniversaire de mamie'))), 'Anniversaire de mamie');
  });

  test('describes the date and the number of photos', () {
    expect(eventSubtitle(saturday), 'Sam. 7 nov. · 3 photos');
  });

  test('counts the bursts to sort', () {
    expect(burstsToSortLabel(2), '2 rafales à trier');
    expect(burstsToSortLabel(1), '1 rafale à trier');
  });

  test('describes an event spanning several days', () {
    final PhotoEvent holidays = _event(<DateTime>[
      DateTime(2026, 8, 14, 20),
      DateTime(2026, 8, 14, 22),
      DateTime(2026, 8, 15, 0, 30),
      DateTime(2026, 8, 15, 2),
    ]);

    expect(eventTitle(holidays), 'Du 14 au 15 août');
    expect(eventSubtitle(holidays), '14 août – 15 août · 4 photos');
  });
}
