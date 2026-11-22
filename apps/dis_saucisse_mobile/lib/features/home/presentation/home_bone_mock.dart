import 'package:dis_saucisse_mobile/features/home/presentation/bloc/home_cubit.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/entities/event_boundaries.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/entities/event_id.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/entities/event_library.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/library_photo.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/photo_id.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/photo_origin.dart';
import 'package:fpdart/fpdart.dart';

final HomeLoaded homeBoneMock = HomeLoaded(
  library: EventLibrary(
    photos: <LibraryPhoto>[
      for (final (String event, DateTime day) in _events)
        for (int index = 0; index < 4; index++)
          LibraryPhoto(
            id: PhotoId('bone-$event-$index'),
            takenAt: day.add(Duration(minutes: index)),
            origin: PhotoOrigin.camera,
          ),
    ],
    names: <EventId, String>{
      for (final (String event, DateTime _) in _events) EventId('bone-$event-0'): 'Une belle journée',
    },
    boundaries: const EventBoundaries.none(),
    decisions: const {},
  ),
  selectedMonth: none(),
);

final List<(String, DateTime)> _events = <(String, DateTime)>[
  ('beach', DateTime(2026, 1, 24, 15)),
  ('birthday', DateTime(2026, 1, 10, 18)),
  ('walk', DateTime(2025, 12, 28, 11)),
];
