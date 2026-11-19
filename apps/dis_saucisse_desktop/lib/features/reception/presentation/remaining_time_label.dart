import 'package:fpdart/fpdart.dart';

String receivedPhotosLabel(Option<Duration> remaining) => remaining.match(
  () => 'photos reçues',
  (Duration left) => left.inSeconds < 60
      ? 'photos reçues · encore quelques secondes'
      : 'photos reçues · encore ~${(left.inSeconds / 60).ceil()} min',
);
