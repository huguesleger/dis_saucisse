import 'package:dis_saucisse_desktop/core/i18n/translations.g.dart';
import 'package:fpdart/fpdart.dart';

String receivedPhotosLabel(Option<Duration> remaining) => remaining.match(
  () => t.reception.receivedPhotos.noEstimate,
  (Duration left) => left.inSeconds < 60
      ? t.reception.receivedPhotos.fewSeconds
      : t.reception.receivedPhotos.minutes(minutes: (left.inSeconds / 60).ceil()),
);
