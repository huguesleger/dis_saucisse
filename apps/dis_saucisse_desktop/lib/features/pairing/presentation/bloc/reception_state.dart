part of 'reception_cubit.dart';

enum ReceptionProblem { noNetwork, serverUnavailable }

@immutable
sealed class ReceptionState {
  const ReceptionState();
}

final class ReceptionStarting extends ReceptionState {
  const ReceptionStarting();
}

final class ReceptionFailed extends ReceptionState {
  const ReceptionFailed(this.problem);

  final ReceptionProblem problem;
}

final class ReceptionReady extends ReceptionState {
  const ReceptionReady({required this.invitation, required this.phones, required this.activity});

  final PairingPayload invitation;
  final List<PairedPhone> phones;
  final ReceptionActivity activity;

  ReceptionReady withPhone(PairedPhone phone) => copyWith(
    phones: <PairedPhone>[...phones.where((PairedPhone known) => known.id != phone.id), phone],
  );

  ReceptionReady copyWith({List<PairedPhone>? phones, ReceptionActivity? activity}) =>
      ReceptionReady(invitation: invitation, phones: phones ?? this.phones, activity: activity ?? this.activity);
}

@immutable
sealed class ReceptionActivity {
  const ReceptionActivity();
}

final class ReceptionIdle extends ReceptionActivity {
  const ReceptionIdle();
}

final class ReceptionInProgress extends ReceptionActivity {
  const ReceptionInProgress({
    required this.phoneName,
    required this.expected,
    required this.received,
    required this.rejected,
    required this.byteCount,
    required this.folders,
    required this.events,
    required this.startedAt,
    required this.lastReceivedAt,
    required this.folderPhotoPaths,
    required this.folderPhotoCount,
    this.paused = false,
  });

  static const int shownFolderPhotos = 12;

  final String phoneName;
  final int expected;
  final int received;
  final int rejected;
  final int byteCount;
  final List<String> folders;
  final Map<String, ReceivedEvent> events;
  final DateTime startedAt;
  final DateTime lastReceivedAt;
  final List<String> folderPhotoPaths;
  final int folderPhotoCount;
  final bool paused;

  ReceptionInProgress withPaused(bool value) => copyWith(paused: value);

  ReceptionInProgress copyWith({
    int? received,
    int? rejected,
    int? byteCount,
    List<String>? folders,
    Map<String, ReceivedEvent>? events,
    DateTime? lastReceivedAt,
    List<String>? folderPhotoPaths,
    int? folderPhotoCount,
    bool? paused,
  }) => ReceptionInProgress(
    phoneName: phoneName,
    expected: expected,
    received: received ?? this.received,
    rejected: rejected ?? this.rejected,
    byteCount: byteCount ?? this.byteCount,
    folders: folders ?? this.folders,
    events: events ?? this.events,
    startedAt: startedAt,
    lastReceivedAt: lastReceivedAt ?? this.lastReceivedAt,
    folderPhotoPaths: folderPhotoPaths ?? this.folderPhotoPaths,
    folderPhotoCount: folderPhotoCount ?? this.folderPhotoCount,
    paused: paused ?? this.paused,
  );

  Option<String> get currentFolder => Option<String>.fromNullable(folders.lastOrNull);
}

final class ReceptionDone extends ReceptionActivity {
  const ReceptionDone({
    required this.phoneName,
    required this.received,
    required this.rejected,
    required this.folders,
    required this.events,
  });

  final String phoneName;
  final int received;
  final int rejected;
  final List<String> folders;
  final List<ReceivedEvent> events;
}
