import 'package:core/core.dart';
import 'package:dis_saucisse_mobile/features/pairing/data/data_sources/pairing_api_data_source.dart';
import 'package:dis_saucisse_mobile/features/pairing/data/data_sources/pairing_storage_data_source.dart';
import 'package:dis_saucisse_mobile/features/pairing/data/data_sources/qr_image_data_source.dart';
import 'package:dis_saucisse_mobile/features/pairing/data/data_sources/stored_paired_computer.dart';
import 'package:dis_saucisse_mobile/features/pairing/data/mappers/paired_computer_mapper.dart';
import 'package:dis_saucisse_mobile/features/pairing/domain/entities/paired_computer.dart';
import 'package:dis_saucisse_mobile/features/pairing/domain/pairing_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:transfer_protocol/transfer_protocol.dart';

class PairingRepositoryImpl implements PairingRepository {
  PairingRepositoryImpl({
    required PairingApiDataSource api,
    required PairingStorageDataSource storage,
    required QrImageDataSource qrImages,
  }) : _api = api,
       _storage = storage,
       _qrImages = qrImages;

  final PairingApiDataSource _api;
  final PairingStorageDataSource _storage;
  final QrImageDataSource _qrImages;

  @override
  TaskEither<AppFailure, Option<String>> readQrCodeFromImage(String imagePath) => _qrImages.readQrCode(imagePath);

  @override
  TaskEither<AppFailure, Option<PairedComputer>> loadPairedComputer() => _storage.loadComputer().map(
    (Option<StoredPairedComputer> stored) => stored.flatMap(storedToPairedComputer),
  );

  @override
  TaskEither<AppFailure, PairedComputer> pairWith(PairingPayload invitation) =>
      TaskEither<AppFailure, PairedComputer>.Do(($) async {
        final PairRequest phone = await $(_storage.phoneIdentity());
        final PairResponse response = await $(_api.pair(invitation, phone));
        final PairedComputer computer = invitationToPairedComputer(invitation, response);
        await $(_storage.saveComputer(pairedComputerToStored(computer)));
        return computer;
      });
}
