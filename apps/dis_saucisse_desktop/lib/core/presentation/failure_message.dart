import 'package:core/core.dart';
import 'package:dis_saucisse_desktop/core/i18n/translations.g.dart';
import 'package:dis_saucisse_desktop/features/history/domain/history_failure.dart';
import 'package:dis_saucisse_desktop/features/storage/domain/storage_failure.dart';

final class FailureMessage {
  const FailureMessage({required this.title, required this.message});

  final String title;
  final String message;
}

FailureMessage failureMessage(AppFailure failure) => switch (failure) {
  HistoryStorageFailure() => FailureMessage(title: t.failures.history.title, message: t.failures.history.message),
  StorageSettingsFailure() => FailureMessage(
    title: t.failures.storageSettings.title,
    message: t.failures.storageSettings.message,
  ),
  _ => FailureMessage(title: t.failures.unknown.title, message: t.failures.unknown.message),
};
