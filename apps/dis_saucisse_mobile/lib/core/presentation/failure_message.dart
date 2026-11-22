import 'package:core/core.dart';
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
  PhotoAccessDeniedFailure() => const FailureMessage(
    title: 'Je n’ai pas accès à tes photos',
    message: 'Autorise Dis Saucisse ! à lire tes photos dans les réglages du téléphone, puis reviens ici.',
  ),
  PhotoLibraryUnavailableFailure() => const FailureMessage(
    title: 'Tes photos ne répondent pas',
    message: 'Je n’arrive pas à lire la photothèque du téléphone. Réessaie dans un instant.',
  ),
  PhotoAnalysisFailure() => const FailureMessage(
    title: 'Analyse impossible',
    message: 'Je n’ai pas réussi à examiner tes photos. Réessaie dans un instant.',
  ),
  PhotoDeletionFailure() => const FailureMessage(
    title: 'Rien n’a été supprimé',
    message: 'La suppression a été annulée ou n’a pas abouti. Tes photos sont toujours là.',
  ),
  SentPhotoHistoryFailure() => const FailureMessage(
    title: 'Souvenirs introuvables',
    message: 'Je n’arrive pas à retrouver la liste des photos déjà envoyées sur ton PC.',
  ),
  ComputerUnreachableFailure() => const FailureMessage(
    title: 'PC introuvable',
    message: 'Vérifie que le PC est allumé, que l’app est ouverte et que vous êtes sur le même Wi-Fi.',
  ),
  SortingStartStorageFailure() ||
  IgnoredOriginsStorageFailure() ||
  PhotoDecisionStorageFailure() ||
  EventNameStorageFailure() ||
  EventBoundaryStorageFailure() ||
  PhotoQualityStorageFailure() ||
  SentPhotoStorageFailure() ||
  PairingStorageFailure() => const FailureMessage(
    title: 'Je perds le fil',
    message: 'Je n’arrive pas à relire ce que j’ai noté sur le téléphone. Réessaie, et relance l’app si ça continue.',
  ),
  _ => const FailureMessage(title: 'Oups !', message: 'Quelque chose s’est mal passé. Réessaie dans un instant.'),
};
