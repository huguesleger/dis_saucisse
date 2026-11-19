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
}
