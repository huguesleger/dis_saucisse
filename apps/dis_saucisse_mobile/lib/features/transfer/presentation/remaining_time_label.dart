import 'package:fpdart/fpdart.dart';
import 'package:dis_saucisse_mobile/core/i18n/translations.g.dart';

String remainingTimeLabel(Option<Duration> remaining) => remaining.match(
  () => t.transfer.remainingTime.computing,
  (Duration duration) => duration.inSeconds < 60
      ? t.transfer.remainingTime.fewSeconds
      : t.transfer.remainingTime.minutes(minutes: duration.inMinutes + 1),
);
