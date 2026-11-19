import 'package:core/core.dart';

class ComputerUnreachableFailure extends AppFailure {
  const ComputerUnreachableFailure();
}

class PairingRefusedFailure extends AppFailure {
  const PairingRefusedFailure();
}

class PairingStorageFailure extends AppFailure {
  const PairingStorageFailure();
}

class QrImageUnreadableFailure extends AppFailure {
  const QrImageUnreadableFailure();
}
