import 'package:core/core.dart';
import 'package:dis_saucisse_mobile/core/i18n/translations.g.dart';
import 'package:dis_saucisse_mobile/features/burst_sort/domain/burst_sort_failure.dart';
import 'package:dis_saucisse_mobile/features/free_space/domain/free_space_failure.dart';
import 'package:dis_saucisse_mobile/features/memories/domain/memories_failure.dart';
import 'package:dis_saucisse_mobile/features/pairing/domain/pairing_failure.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/photo_events_failure.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/photo_library_failure.dart';
import 'package:dis_saucisse_mobile/features/photo_quality/domain/photo_quality_failure.dart';
import 'package:dis_saucisse_mobile/features/transfer/domain/transfer_failure.dart';

final class FailureMessage {
  const FailureMessage({required this.title, required this.message});

  final String title;
  final String message;
}

FailureMessage failureMessage(AppFailure failure) => switch (failure) {
  PhotoAccessDeniedFailure() => FailureMessage(
    title: t.failures.accessDenied.title,
    message: t.failures.accessDenied.message,
  ),
  PhotoLibraryUnavailableFailure() => FailureMessage(
    title: t.failures.libraryUnavailable.title,
    message: t.failures.libraryUnavailable.message,
  ),
  PhotoAnalysisFailure() => FailureMessage(
    title: t.failures.analysis.title,
    message: t.failures.analysis.message,
  ),
  PhotoDeletionFailure() => FailureMessage(
    title: t.failures.deletion.title,
    message: t.failures.deletion.message,
  ),
  SentPhotoHistoryFailure() => FailureMessage(
    title: t.failures.history.title,
    message: t.failures.history.message,
  ),
  ComputerUnreachableFailure() => FailureMessage(
    title: t.failures.computerUnreachable.title,
    message: t.failures.computerUnreachable.message,
  ),
  SortingStartStorageFailure() ||
  IgnoredOriginsStorageFailure() ||
  PhotoDecisionStorageFailure() ||
  EventNameStorageFailure() ||
  EventBoundaryStorageFailure() ||
  PhotoQualityStorageFailure() ||
  SentPhotoStorageFailure() ||
  PairingStorageFailure() => FailureMessage(
    title: t.failures.storage.title,
    message: t.failures.storage.message,
  ),
  _ => FailureMessage(title: t.failures.unknown.title, message: t.failures.unknown.message),
};
