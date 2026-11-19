import 'package:fpdart/fpdart.dart';

Option<Duration> remainingTime({
  required DateTime startedAt,
  required DateTime lastReceivedAt,
  required int received,
  required int expected,
}) => received == 0 || expected <= received
    ? none()
    : some(lastReceivedAt.difference(startedAt) * ((expected - received) / received));
