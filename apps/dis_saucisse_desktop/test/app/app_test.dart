import 'package:dis_saucisse_desktop/app/app.dart';
import 'package:dis_saucisse_desktop/config/setup_get_it.dart';
import 'package:dis_saucisse_desktop/features/pairing/domain/entities/paired_phone.dart';
import 'package:dis_saucisse_desktop/features/pairing/domain/pairing_repository.dart';
import 'package:dis_saucisse_desktop/features/reception/domain/entities/reception_event.dart';
import 'package:dis_saucisse_desktop/features/reception/domain/reception_repository.dart';
import 'package:dis_saucisse_desktop/features/pairing/presentation/reception_screen.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:transfer_protocol/transfer_protocol.dart';

class _MockPairingRepository extends Mock implements PairingRepository {}

class _MockReceptionRepository extends Mock implements ReceptionRepository {}

void main() {
  late _MockPairingRepository repository;

  setUp(() {
    repository = _MockPairingRepository();
    final _MockReceptionRepository receptionRepository = _MockReceptionRepository();
    when(() => receptionRepository.events).thenAnswer((_) => const Stream<ReceptionEvent>.empty());
    getIt
      ..registerSingleton<PairingRepository>(repository)
      ..registerSingleton<ReceptionRepository>(receptionRepository);
    when(() => repository.pairedPhones).thenAnswer((_) => const Stream<PairedPhone>.empty());
    when(() => repository.stopReception()).thenReturn(TaskEither.right(unit));
    when(() => repository.loadPairedPhones()).thenReturn(TaskEither.right(<PairedPhone>[]));
    when(() => repository.startReception()).thenReturn(
      TaskEither.right(
        const PairingPayload(
          computerId: ComputerId('computer-1'),
          computerName: 'PC du salon',
          platform: ComputerPlatform.macos,
          host: '192.168.1.24',
          port: 47820,
          token: PairingToken('secret'),
        ),
      ),
    );
  });

  tearDown(getIt.reset);

  testWidgets('opens on the reception screen with the pairing QR code', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1280, 800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(const App());
    await tester.pumpAndSettle();

    expect(find.byType(ReceptionScreen), findsOneWidget);
    expect(find.text('Associer un téléphone'), findsOneWidget);
    expect(find.text('Scanne avec Dis Saucisse !'), findsOneWidget);
  });
}
