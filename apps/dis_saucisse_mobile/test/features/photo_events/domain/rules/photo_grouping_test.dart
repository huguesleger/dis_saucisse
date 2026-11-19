import 'package:dis_saucisse_mobile/features/photo_events/domain/entities/event_id.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/entities/month_events.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/entities/photo_burst.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/entities/photo_event.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/rules/photo_grouping.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/library_photo.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/photo_id.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/photo_month.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/photo_origin.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';

LibraryPhoto _photo(String id, DateTime takenAt) =>
    LibraryPhoto(id: PhotoId(id), takenAt: takenAt, origin: PhotoOrigin.camera);

List<String> _ids(List<LibraryPhoto> photos) => photos.map((LibraryPhoto photo) => photo.id.value).toList();

void main() {
  group('groupIntoBursts', () {
    test('keeps photos taken within 10 seconds in the same burst', () {
      final List<PhotoBurst> bursts = groupIntoBursts(<LibraryPhoto>[
        _photo('a', DateTime(2026, 11, 8, 14, 0, 0)),
        _photo('b', DateTime(2026, 11, 8, 14, 0, 4)),
        _photo('c', DateTime(2026, 11, 8, 14, 0, 14)),
        _photo('d', DateTime(2026, 11, 8, 14, 0, 30)),
      ]);

      expect(bursts.map((PhotoBurst burst) => _ids(burst.photos)), <List<String>>[
        <String>['a', 'b', 'c'],
        <String>['d'],
      ]);
    });

    test('sorts the photos chronologically first', () {
      final List<PhotoBurst> bursts = groupIntoBursts(<LibraryPhoto>[
        _photo('late', DateTime(2026, 11, 8, 14, 0, 5)),
        _photo('early', DateTime(2026, 11, 8, 14, 0, 0)),
      ]);

      expect(_ids(bursts.single.photos), <String>['early', 'late']);
    });
  });

  group('groupIntoEvents', () {
    final List<LibraryPhoto> photos = <LibraryPhoto>[
      _photo('cake', DateTime(2026, 11, 8, 14, 0)),
      _photo('candles', DateTime(2026, 11, 8, 16, 30)),
      _photo('walk', DateTime(2026, 11, 16, 10, 0)),
    ];

    test('starts a new event after a gap of more than 3 hours', () {
      final List<PhotoEvent> events = groupIntoEvents(photos, <EventId, String>{});

      expect(events.map((PhotoEvent event) => _ids(event.photos)), <List<String>>[
        <String>['cake', 'candles'],
        <String>['walk'],
      ]);
    });

    test('identifies an event by its first photo and gives it its saved name', () {
      final List<PhotoEvent> events = groupIntoEvents(photos, <EventId, String>{
        const EventId('cake'): 'Anniversaire de mamie',
      });

      expect(events.first.id, const EventId('cake'));
      expect(events.first.name, some('Anniversaire de mamie'));
      expect(events.last.name, none<String>());
    });
  });

  test('groups events by month, newest month and newest event first', () {
    final List<MonthEvents> groups = eventsByMonthNewestFirst(
      groupIntoEvents(<LibraryPhoto>[
        _photo('oct', DateTime(2026, 10, 2, 10)),
        _photo('nov-1', DateTime(2026, 11, 8, 10)),
        _photo('nov-2', DateTime(2026, 11, 16, 10)),
      ], <EventId, String>{}),
    );

    expect(groups.map((MonthEvents group) => group.month), const <PhotoMonth>[
      PhotoMonth(year: 2026, month: 11),
      PhotoMonth(year: 2026, month: 10),
    ]);
    expect(groups.first.events.map((PhotoEvent event) => event.id), const <EventId>[
      EventId('nov-2'),
      EventId('nov-1'),
    ]);
  });
}
