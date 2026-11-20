import 'package:dis_saucisse_mobile/core/formatting/french_dates.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/photo_month.dart';

String photoCountLabel(int count) => count == 1 ? '1 photo' : '$count photos';

String eventCountLabel(int count) => switch (count) {
  0 => 'aucun événement',
  1 => '1 événement',
  _ => '$count événements',
};

String memoryMonthTitle(PhotoMonth month) => '${capitalizedFrenchMonthName(month.month)} ${month.year}';

String sentOnLabel(DateTime sentAt) => 'Envoyé le ${frenchShortDay(sentAt)}';
