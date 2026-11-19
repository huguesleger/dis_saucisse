import 'package:core/core.dart';
import 'package:dis_saucisse_mobile/features/pairing/domain/entities/paired_computer.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/photo_id.dart';
import 'package:dis_saucisse_mobile/features/transfer/domain/entities/sent_photo.dart';
import 'package:dis_saucisse_mobile/features/transfer/domain/entities/transfer_item.dart';
import 'package:fpdart/fpdart.dart';
import 'package:transfer_protocol/transfer_protocol.dart';

abstract interface class TransferRepository {
  TaskEither<AppFailure, Set<PhotoId>> loadSentPhotoIds(ComputerId computer);

  TaskEither<AppFailure, Set<PhotoId>> startTransfer(PairedComputer computer, List<PhotoId> photos);

  TaskEither<AppFailure, Unit> markAlreadyReceived(PairedComputer computer, List<PhotoId> photos);

  TaskEither<AppFailure, SentPhoto> sendPhoto(PairedComputer computer, TransferItem item);

  TaskEither<AppFailure, Unit> finishTransfer(PairedComputer computer, int sentCount);
}
