import 'dart:math' show max;

import 'package:dis_saucisse_desktop/features/history/domain/entities/transfer_record.dart';
import 'package:dis_saucisse_desktop/features/pairing/presentation/bloc/reception_cubit.dart';
import 'package:dis_saucisse_desktop/features/reception/domain/entities/received_event.dart';
import 'package:dis_saucisse_desktop/features/reception/domain/entities/reception_event.dart';
import 'package:fpdart/fpdart.dart';

ReceptionActivity nextReceptionActivity(ReceptionActivity activity, ReceptionEvent event, DateTime now) =>
    switch ((event, activity)) {
      (TransferStarted(:final String phoneName, :final int photoCount), _) => ReceptionInProgress(
        phoneName: phoneName,
        expected: photoCount,
        received: 0,
        rejected: 0,
        byteCount: 0,
        folders: const <String>[],
        events: const <String, ReceivedEvent>{},
        startedAt: now,
        lastReceivedAt: now,
        folderPhotoPaths: const <String>[],
        folderPhotoCount: 0,
        paused: switch (activity) {
          ReceptionInProgress(:final bool paused) => paused,
          ReceptionIdle() || ReceptionDone() => false,
        },
      ),
      (final PhotoReceived photo, final ReceptionInProgress progress) => _withPhoto(progress, photo, now),
      (PhotoRejected(), final ReceptionInProgress progress) => progress.copyWith(rejected: progress.rejected + 1),
      (TransferFinished(), final ReceptionInProgress progress) => ReceptionDone(
        phoneName: progress.phoneName,
        received: progress.received,
        rejected: progress.rejected,
        folders: progress.folders,
        events: progress.events.values.toList(),
      ),
      (PhotoReceived() || PhotoRejected() || TransferFinished(), ReceptionIdle() || ReceptionDone()) => activity,
    };

ReceptionInProgress _withPhoto(ReceptionInProgress progress, PhotoReceived photo, DateTime now) {
  final bool sameFolder = progress.currentFolder == some(photo.folder);
  return progress.copyWith(
    received: progress.received + 1,
    byteCount: progress.byteCount + photo.byteCount,
    folders: <String>[...progress.folders.where((String known) => known != photo.folder), photo.folder],
    events: <String, ReceivedEvent>{
      ...progress.events,
      photo.eventKey: (label: photo.eventLabel, count: (progress.events[photo.eventKey]?.count ?? 0) + 1),
    },
    lastReceivedAt: now,
    folderPhotoPaths: sameFolder
        ? <String>[
            ...progress.folderPhotoPaths.skip(
              max(0, progress.folderPhotoPaths.length - ReceptionInProgress.shownFolderPhotos + 1),
            ),
            photo.filePath,
          ]
        : <String>[photo.filePath],
    folderPhotoCount: sameFolder ? progress.folderPhotoCount + 1 : 1,
  );
}

TransferRecord transferRecordOf(ReceptionInProgress progress, DateTime receivedAt) => TransferRecord(
  receivedAt: receivedAt,
  phoneName: progress.phoneName,
  photoCount: progress.received,
  rejectedCount: progress.rejected,
  byteCount: progress.byteCount,
  eventCount: progress.events.length,
);
