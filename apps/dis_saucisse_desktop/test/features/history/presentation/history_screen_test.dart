import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_desktop/features/history/domain/entities/transfer_record.dart';
import 'package:dis_saucisse_desktop/features/history/domain/history_failure.dart';
import 'package:dis_saucisse_desktop/features/history/presentation/bloc/history_cubit.dart';
import 'package:dis_saucisse_desktop/features/history/presentation/history_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockHistoryCubit extends MockCubit<HistoryState> implements HistoryCubit {}

void main() {
  late _MockHistoryCubit cubit;

  Future<void> pumpScreen(WidgetTester tester, HistoryState state) async {
    await tester.binding.setSurfaceSize(const Size(1100, 760));
    cubit = _MockHistoryCubit();
    whenListen(cubit, const Stream<HistoryState>.empty(), initialState: state);
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: BlocProvider<HistoryCubit>.value(value: cubit, child: const HistoryScreen()),
        ),
      ),
    );
  }

  testWidgets('invites to pair the phone when nothing was received', (WidgetTester tester) async {
    await pumpScreen(tester, const HistoryLoaded(records: <TransferRecord>[], selectedYear: 2026));

    expect(find.text('Aucune photo reçue pour l’instant'), findsOneWidget);
    expect(find.text('Aller à la réception'), findsOneWidget);
  });

  testWidgets('explains an unreadable history and retries', (WidgetTester tester) async {
    await pumpScreen(tester, const HistoryFailed(HistoryStorageFailure()));
    when(() => cubit.load()).thenAnswer((_) async {});

    expect(find.text('Historique illisible'), findsOneWidget);
    await tester.tap(find.text('Réessayer'));

    verify(() => cubit.load()).called(1);
  });

  testWidgets('falls back to a generic message for an unexpected failure', (WidgetTester tester) async {
    await pumpScreen(tester, const HistoryFailed(UnknownFailure()));

    expect(find.byType(DsMessageView), findsOneWidget);
    expect(find.text('Oups !'), findsOneWidget);
  });
}
