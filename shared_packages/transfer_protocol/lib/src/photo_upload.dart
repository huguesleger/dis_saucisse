import 'package:fpdart/fpdart.dart';
import 'package:transfer_protocol/src/identifiers.dart';
import 'package:transfer_protocol/src/photo_decision_kind.dart';

/// Description of an uploaded photo, carried by the headers of `PUT /v1/photos/{photoId}`.
final class PhotoUpload {
  const PhotoUpload({
    required this.phoneId,
    required this.photoId,
    required this.fileName,
    required this.takenAt,
    required this.eventDate,
    required this.eventName,
    required this.decision,
    required this.sha256,
  });

  static const String _phoneHeader = 'x-dis-saucisse-phone';
  static const String _fileNameHeader = 'x-dis-saucisse-file-name';
  static const String _takenAtHeader = 'x-dis-saucisse-taken-at';
  static const String _eventDateHeader = 'x-dis-saucisse-event-date';
  static const String _eventNameHeader = 'x-dis-saucisse-event-name';
  static const String _decisionHeader = 'x-dis-saucisse-decision';
  static const String _sha256Header = 'x-dis-saucisse-sha256';

  final PhoneId phoneId;
  final String photoId;
  final String fileName;
  final DateTime takenAt;
  final DateTime eventDate;
  final Option<String> eventName;
  final PhotoDecisionKind decision;

  /// Lowercase hexadecimal SHA-256 of the body, checked by the computer before storing.
  final String sha256;

  Map<String, String> toHeaders() => <String, String>{
    _phoneHeader: phoneId.value,
    _fileNameHeader: Uri.encodeComponent(fileName),
    _takenAtHeader: takenAt.toIso8601String(),
    _eventDateHeader: eventDate.toIso8601String(),
    _eventNameHeader: eventName.match(() => '', Uri.encodeComponent),
    _decisionHeader: decision.name,
    _sha256Header: sha256,
  };

  static Option<PhotoUpload> fromHeaders(String photoId, Map<String, String> headers) {
    final Option<DateTime> takenAt = Option<String>.fromNullable(
      headers[_takenAtHeader],
    ).flatMap((String value) => Option<DateTime>.fromNullable(DateTime.tryParse(value)));
    final Option<DateTime> eventDate = Option<String>.fromNullable(
      headers[_eventDateHeader],
    ).flatMap((String value) => Option<DateTime>.fromNullable(DateTime.tryParse(value)));
    final Option<PhotoDecisionKind> decision = Option<PhotoDecisionKind>.fromNullable(
      PhotoDecisionKind.values.where((PhotoDecisionKind kind) => kind.name == headers[_decisionHeader]).firstOrNull,
    );
    final String? phone = headers[_phoneHeader];
    final String? fileName = headers[_fileNameHeader];
    final String? sha256 = headers[_sha256Header];
    return phone == null || fileName == null || sha256 == null
        ? none()
        : takenAt.flatMap(
            (DateTime taken) => eventDate.flatMap(
              (DateTime event) => decision.map(
                (PhotoDecisionKind kind) => PhotoUpload(
                  phoneId: PhoneId(phone),
                  photoId: photoId,
                  fileName: Uri.decodeComponent(fileName),
                  takenAt: taken,
                  eventDate: event,
                  eventName: Option<String>.fromPredicate(
                    Uri.decodeComponent(headers[_eventNameHeader] ?? ''),
                    (String name) => name.isNotEmpty,
                  ),
                  decision: kind,
                  sha256: sha256,
                ),
              ),
            ),
          );
  }
}
