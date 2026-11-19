import 'package:flutter/foundation.dart';
import 'package:transfer_protocol/transfer_protocol.dart';

@immutable
sealed class ReceptionEvent {
  const ReceptionEvent();
}

final class TransferStarted extends ReceptionEvent {
  const TransferStarted({required this.phoneName, required this.photoCount});

  final String phoneName;
  final int photoCount;
}

final class PhotoReceived extends ReceptionEvent {
  const PhotoReceived({required this.folder, required this.byteCount, required this.decision});

  final String folder;
  final int byteCount;
  final PhotoDecisionKind decision;
}

final class PhotoRejected extends ReceptionEvent {
  const PhotoRejected();
}

final class TransferFinished extends ReceptionEvent {
  const TransferFinished({required this.photoCount});

  final int photoCount;
}
