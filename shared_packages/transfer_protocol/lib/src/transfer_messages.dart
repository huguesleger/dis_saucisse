import 'package:fpdart/fpdart.dart';
import 'package:transfer_protocol/src/identifiers.dart';

List<String>? _stringList(Object? value) =>
    value is List<dynamic> && value.every((Object? id) => id is String) ? value.cast<String>() : null;

/// Sent by the phone before uploading: the photos it is about to send.
final class TransferStartRequest {
  const TransferStartRequest({required this.phoneId, required this.phoneName, required this.photoIds});

  final PhoneId phoneId;
  final String phoneName;
  final List<String> photoIds;

  Map<String, Object> toJson() => <String, Object>{
    'phoneId': phoneId.value,
    'phoneName': phoneName,
    'photoIds': photoIds,
  };

  static Option<TransferStartRequest> fromJson(Object? json) => switch (json) {
    {'phoneId': final String phoneId, 'phoneName': final String phoneName, 'photoIds': final Object? ids} =>
      Option<List<String>>.fromNullable(_stringList(ids)).map(
        (List<String> photoIds) =>
            TransferStartRequest(phoneId: PhoneId(phoneId), phoneName: phoneName, photoIds: photoIds),
      ),
    _ => none(),
  };
}

/// Answer of the computer: the photos it does not have yet, the only ones the phone must upload.
final class TransferStartResponse {
  const TransferStartResponse({required this.missingPhotoIds});

  final List<String> missingPhotoIds;

  Map<String, Object> toJson() => <String, Object>{'missingPhotoIds': missingPhotoIds};

  static Option<TransferStartResponse> fromJson(Object? json) => switch (json) {
    {'missingPhotoIds': final Object? ids} => Option<List<String>>.fromNullable(
      _stringList(ids),
    ).map((List<String> missing) => TransferStartResponse(missingPhotoIds: missing)),
    _ => none(),
  };
}

/// Answer of the computer once a photo is verified and stored.
final class PhotoStoredResponse {
  const PhotoStoredResponse({required this.folder});

  /// Folder of the photo, relative to the storage root ("2026/2026-11 Novembre/2026-11-08 Anniversaire").
  final String folder;

  Map<String, Object> toJson() => <String, Object>{'folder': folder};

  static Option<PhotoStoredResponse> fromJson(Object? json) => switch (json) {
    {'folder': final String folder} => some(PhotoStoredResponse(folder: folder)),
    _ => none(),
  };
}

/// Sent by the phone when every photo of the transfer is uploaded.
final class TransferFinishRequest {
  const TransferFinishRequest({required this.phoneId, required this.sentCount});

  final PhoneId phoneId;
  final int sentCount;

  Map<String, Object> toJson() => <String, Object>{'phoneId': phoneId.value, 'sentCount': sentCount};

  static Option<TransferFinishRequest> fromJson(Object? json) => switch (json) {
    {'phoneId': final String phoneId, 'sentCount': final int sentCount} => some(
      TransferFinishRequest(phoneId: PhoneId(phoneId), sentCount: sentCount),
    ),
    _ => none(),
  };
}
