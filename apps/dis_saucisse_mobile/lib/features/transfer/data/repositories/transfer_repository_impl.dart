import 'package:core/core.dart';
import 'package:crypto/crypto.dart';
import 'package:dis_saucisse_mobile/features/pairing/data/data_sources/pairing_storage_data_source.dart';
import 'package:dis_saucisse_mobile/features/pairing/domain/entities/paired_computer.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/photo_id.dart';
import 'package:dis_saucisse_mobile/features/transfer/data/data_sources/photo_file.dart';
import 'package:dis_saucisse_mobile/features/transfer/data/data_sources/photo_file_data_source.dart';
import 'package:dis_saucisse_mobile/features/transfer/data/data_sources/sent_photo_data_source.dart';
import 'package:dis_saucisse_mobile/features/transfer/data/data_sources/transfer_api_data_source.dart';
import 'package:dis_saucisse_mobile/features/transfer/data/mappers/photo_upload_mapper.dart';
import 'package:dis_saucisse_mobile/features/transfer/domain/entities/transfer_item.dart';
import 'package:dis_saucisse_mobile/features/transfer/domain/transfer_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:transfer_protocol/transfer_protocol.dart';

class TransferRepositoryImpl implements TransferRepository {
  TransferRepositoryImpl({
    required TransferApiDataSource api,
    required PhotoFileDataSource files,
    required SentPhotoDataSource sentPhotos,
    required PairingStorageDataSource pairing,
    DateTime Function()? clock,
  }) : _api = api,
       _files = files,
       _sentPhotos = sentPhotos,
       _pairing = pairing,
       _clock = clock ?? DateTime.now;

  final TransferApiDataSource _api;
  final PhotoFileDataSource _files;
  final SentPhotoDataSource _sentPhotos;
  final PairingStorageDataSource _pairing;
  final DateTime Function() _clock;

  @override
  TaskEither<AppFailure, Set<PhotoId>> loadSentPhotoIds(ComputerId computer) =>
      _sentPhotos.loadSentPhotoIds(computer.value).map((Set<String> ids) => ids.map(PhotoId.new).toSet());

  @override
  TaskEither<AppFailure, Set<PhotoId>> startTransfer(PairedComputer computer, List<PhotoId> photos) =>
      _pairing.phoneIdentity().flatMap(
        (PairRequest phone) => _api
            .start(
              computer.host,
              computer.port,
              computer.token,
              TransferStartRequest(
                phoneId: phone.phoneId,
                phoneName: phone.phoneName,
                photoIds: photos.map((PhotoId id) => id.value).toList(),
              ),
            )
            .map((TransferStartResponse response) => response.missingPhotoIds.map(PhotoId.new).toSet()),
      );

  @override
  TaskEither<AppFailure, Unit> markAlreadyReceived(PairedComputer computer, List<PhotoId> photos) =>
      _sentPhotos.markSent(computer.id.value, photos.map((PhotoId id) => id.value).toList(), _clock());

  @override
  TaskEither<AppFailure, String> sendPhoto(PairedComputer computer, TransferItem item) =>
      TaskEither<AppFailure, String>.Do(($) async {
        final PairRequest phone = await $(_pairing.phoneIdentity());
        final PhotoFile file = await $(
          _files.loadPhotoFile(item.photo.id.value, convertHeicToJpeg: computer.platform == ComputerPlatform.windows),
        );
        final PhotoStoredResponse stored = await $(
          _api.upload(
            computer.host,
            computer.port,
            computer.token,
            transferItemToUpload(
              item,
              phone: phone.phoneId,
              fileName: file.fileName,
              sha256: sha256.convert(file.bytes).toString(),
            ),
            file.bytes,
          ),
        );
        await $(_sentPhotos.markSent(computer.id.value, <String>[item.photo.id.value], _clock()));
        return stored.folder;
      });

  @override
  TaskEither<AppFailure, Unit> finishTransfer(PairedComputer computer, int sentCount) =>
      _pairing.phoneIdentity().flatMap(
        (PairRequest phone) => _api.finish(
          computer.host,
          computer.port,
          computer.token,
          TransferFinishRequest(phoneId: phone.phoneId, sentCount: sentCount),
        ),
      );
}
