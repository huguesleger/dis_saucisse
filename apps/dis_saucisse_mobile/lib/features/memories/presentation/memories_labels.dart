import 'package:dis_saucisse_mobile/core/i18n/translations.g.dart';
import 'package:dis_saucisse_mobile/core/formatting/french_dates.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/photo_month.dart';

String photoCountLabel(int count) =>
    count == 1 ? t.memories.photoCount.single : t.memories.photoCount.several(count: count);

String eventCountLabel(int count) => switch (count) {
  0 => t.memories.eventCount.zero,
  1 => t.memories.eventCount.single,
  _ => t.memories.eventCount.several(count: count),
};

String memoryMonthTitle(PhotoMonth month) => '${capitalizedFrenchMonthName(month.month)} ${month.year}';

String sentOnLabel(DateTime sentAt) => t.memories.sentOn(date: frenchShortDay(sentAt));
