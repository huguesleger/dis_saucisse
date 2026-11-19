import 'package:fpdart/fpdart.dart';

String remainingTimeLabel(Option<Duration> remaining) => remaining.match(
  () => 'calcul du temps restant…',
  (Duration duration) => duration.inSeconds < 60 ? 'encore quelques secondes' : 'encore ~${duration.inMinutes + 1} min',
);
