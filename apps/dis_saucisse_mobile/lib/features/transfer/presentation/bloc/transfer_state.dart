part of 'transfer_cubit.dart';

enum TransferProblem { unreachable, failed }

@immutable
sealed class TransferState {
  const TransferState();
}

final class TransferPreparing extends TransferState {
  const TransferPreparing();
}

final class TransferNeedsPairing extends TransferState {
  const TransferNeedsPairing();
}

final class TransferNothingToSend extends TransferState {
  const TransferNothingToSend();
}

final class TransferFailed extends TransferState {
  const TransferFailed(this.problem);

  final TransferProblem problem;
}

final class TransferSending extends TransferState {
  const TransferSending(this.progress);

  final TransferProgress progress;
}

final class TransferPaused extends TransferState {
  const TransferPaused(this.progress);

  final TransferProgress progress;
}

final class TransferFinished extends TransferState {
  const TransferFinished({
    required this.computerName,
    required this.sentCount,
    required this.eventCount,
    required this.sentBytes,
  });

  final String computerName;
  final int sentCount;
  final int eventCount;
  final int sentBytes;
}
