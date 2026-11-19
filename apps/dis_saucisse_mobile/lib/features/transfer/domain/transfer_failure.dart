import 'package:core/core.dart';

class PhotoFileUnavailableFailure extends AppFailure {
  const PhotoFileUnavailableFailure();
}

class TransferRejectedFailure extends AppFailure {
  const TransferRejectedFailure();
}

class SentPhotoStorageFailure extends AppFailure {
  const SentPhotoStorageFailure();
}

class ComputerPausedFailure extends AppFailure {
  const ComputerPausedFailure();
}
