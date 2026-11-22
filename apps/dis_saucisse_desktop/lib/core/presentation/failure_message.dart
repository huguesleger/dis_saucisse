import 'package:core/core.dart';
import 'package:dis_saucisse_desktop/features/history/domain/history_failure.dart';
import 'package:dis_saucisse_desktop/features/storage/domain/storage_failure.dart';

final class FailureMessage {
  const FailureMessage({required this.title, required this.message});

  final String title;
  final String message;
}

FailureMessage failureMessage(AppFailure failure) => switch (failure) {
  HistoryStorageFailure() => const FailureMessage(
    title: 'Historique illisible',
    message: 'Je n’arrive pas à relire la liste des envois reçus sur ce PC. Réessaie dans un instant.',
  ),
  StorageSettingsFailure() => const FailureMessage(
    title: 'Réglages illisibles',
    message: 'Je n’arrive pas à relire où ranger tes photos. Réessaie, et relance l’app si ça continue.',
  ),
  _ => const FailureMessage(title: 'Oups !', message: 'Quelque chose s’est mal passé. Réessaie dans un instant.'),
};
