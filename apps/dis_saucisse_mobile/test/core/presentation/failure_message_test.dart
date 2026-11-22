import 'package:core/core.dart';
import 'package:dis_saucisse_mobile/core/presentation/failure_message.dart';
import 'package:dis_saucisse_mobile/features/burst_sort/domain/burst_sort_failure.dart';
import 'package:dis_saucisse_mobile/features/free_space/domain/free_space_failure.dart';
import 'package:dis_saucisse_mobile/features/pairing/domain/pairing_failure.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/photo_library_failure.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('explains a missing access to the photos', () {
    expect(failureMessage(const PhotoAccessDeniedFailure()).title, 'Je n’ai pas accès à tes photos');
  });

  test('tells that nothing was deleted when the deletion fails', () {
    expect(failureMessage(const PhotoDeletionFailure()).title, 'Rien n’a été supprimé');
  });

  test('tells that the computer cannot be reached', () {
    expect(failureMessage(const ComputerUnreachableFailure()).title, 'PC introuvable');
  });

  test('uses the same message for every storage failure', () {
    expect(
      failureMessage(const PhotoDecisionStorageFailure()).message,
      failureMessage(const SortingStartStorageFailure()).message,
    );
  });

  test('falls back to a generic message', () {
    expect(failureMessage(const UnknownFailure()).title, 'Oups !');
  });
}
