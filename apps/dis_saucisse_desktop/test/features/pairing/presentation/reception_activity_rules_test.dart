import 'package:dis_saucisse_desktop/features/pairing/presentation/bloc/reception_cubit.dart';
import 'package:dis_saucisse_desktop/features/pairing/presentation/reception_activity_rules.dart';
import 'package:dis_saucisse_desktop/features/reception/domain/entities/reception_event.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:transfer_protocol/transfer_protocol.dart';

void main() {
  final DateTime now = DateTime(2026, 11, 22, 20);

  PhotoReceived photo(String folder, String file) => PhotoReceived(
    folder: folder,
    filePath: file,
    eventKey: folder,
    eventLabel: folder,
    byteCount: 100,
    decision: PhotoDecisionKind.kept,
  );

  ReceptionInProgress started() =>
      nextReceptionActivity(
            const ReceptionIdle(),
            const TransferStarted(phoneName: 'iPhone', photoCount: 3),
            now,
          )
          as ReceptionInProgress;

  test('starts a reception from idle', () {
    final ReceptionInProgress progress = started();

    expect((progress.phoneName, progress.expected, progress.received, progress.paused), ('iPhone', 3, 0, false));
  });

  test('counts the photos received in the same folder', () {
    final ReceptionActivity afterTwo = nextReceptionActivity(
      nextReceptionActivity(started(), photo('2026/Novembre', 'a.jpg'), now),
      photo('2026/Novembre', 'b.jpg'),
      now,
    );

    expect(afterTwo, isA<ReceptionInProgress>());
    final ReceptionInProgress progress = afterTwo as ReceptionInProgress;
    expect((progress.received, progress.byteCount, progress.folderPhotoCount), (2, 200, 2));
    expect(progress.folderPhotoPaths, <String>['a.jpg', 'b.jpg']);
    expect(progress.events['2026/Novembre']?.count, 2);
  });

  test('restarts the folder photos when the folder changes', () {
    final ReceptionInProgress progress =
        nextReceptionActivity(
              nextReceptionActivity(started(), photo('2026/Novembre', 'a.jpg'), now),
              photo('2026/Octobre', 'b.jpg'),
              now,
            )
            as ReceptionInProgress;

    expect(progress.folderPhotoCount, 1);
    expect(progress.folderPhotoPaths, <String>['b.jpg']);
    expect(progress.folders, <String>['2026/Novembre', '2026/Octobre']);
  });

  test('counts a rejected photo', () {
    final ReceptionInProgress progress =
        nextReceptionActivity(started(), const PhotoRejected(), now) as ReceptionInProgress;

    expect((progress.received, progress.rejected), (0, 1));
  });

  test('ends with a summary', () {
    final ReceptionActivity done = nextReceptionActivity(
      nextReceptionActivity(started(), photo('2026/Novembre', 'a.jpg'), now),
      const TransferFinished(photoCount: 1),
      now,
    );

    expect(done, isA<ReceptionDone>().having((ReceptionDone d) => d.received, 'received', 1));
  });

  test('ignores photos when no reception is running', () {
    expect(nextReceptionActivity(const ReceptionIdle(), photo('2026', 'a.jpg'), now), isA<ReceptionIdle>());
  });
}
