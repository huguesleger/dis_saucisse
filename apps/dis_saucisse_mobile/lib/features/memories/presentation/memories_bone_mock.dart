import 'package:dis_saucisse_mobile/features/memories/domain/entities/memory_month.dart';
import 'package:dis_saucisse_mobile/features/memories/presentation/bloc/memories_cubit.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/photo_id.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/photo_month.dart';
import 'package:fpdart/fpdart.dart';

final MemoriesLoaded memoriesBoneMock = MemoriesLoaded(
  months: <MemoryMonth>[
    for (final (int year, int month) in <(int, int)>[(2026, 1), (2025, 12), (2025, 11)])
      MemoryMonth(
        month: PhotoMonth(year: year, month: month),
        photoCount: 42,
        eventCount: 3,
        byteCount: 120000000,
        lastSentAt: DateTime(year, month, 28),
        photosOnPhone: <PhotoId>[for (int index = 0; index < 4; index++) PhotoId('bone-$year-$month-$index')],
      ),
  ],
  selectedYear: none(),
);
