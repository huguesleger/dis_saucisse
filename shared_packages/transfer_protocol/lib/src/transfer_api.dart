/// HTTP contract between the phone and the computer, on the local network.
abstract final class TransferApi {
  /// Port the computer listens on.
  static const int defaultPort = 47820;

  /// mDNS service type the computer advertises.
  static const String serviceType = '_dissaucisse._tcp';

  /// Header carrying the [PairingToken] on every request.
  static const String tokenHeader = 'x-dis-saucisse-token';

  /// `GET`: who is this computer.
  static const String statusPath = '/v1/status';

  /// `POST` a `PairRequest`, answered by a `PairResponse`.
  static const String pairPath = '/v1/pair';

  /// `POST` a `TransferStartRequest`, answered by a `TransferStartResponse`.
  static const String transferStartPath = '/v1/transfers/start';

  /// `POST` a `TransferFinishRequest` once every photo is uploaded.
  static const String transferFinishPath = '/v1/transfers/finish';

  /// Prefix of `PUT /v1/photos/{photoId}`: the body is the photo file, the headers a `PhotoUpload`.
  static const String photosPath = '/v1/photos/';

  /// Path where the photo [photoId] is uploaded.
  static String photoPath(String photoId) => '$photosPath${Uri.encodeComponent(photoId)}';
}
