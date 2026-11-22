import 'package:bloc_test/bloc_test.dart';
import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/photo_id.dart';
import 'package:dis_saucisse_mobile/features/photo_quality/domain/entities/quality_group.dart';
import 'package:dis_saucisse_mobile/features/photo_quality/domain/entities/quality_issue.dart';
import 'package:dis_saucisse_mobile/features/photo_quality/presentation/bloc/quality_review_cubit.dart';
import 'package:dis_saucisse_mobile/features/photo_quality/presentation/quality_review_screen.dart';
import 'package:dis_saucisse_mobile/features/photo_quality/presentation/widgets/quality_photo_tile.dart';
import 'package:dis_saucisse_mobile/features/photo_quality/presentation/widgets/quality_photo_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import '../../../helpers/photo_fixtures.dart';

class _MockQualityReviewCubit extends MockCubit<QualityReviewState> implements QualityReviewCubit {}

void main() {
  late _MockQualityReviewCubit cubit;

  final QualityGroup series = QualityGroup(photos: saturdayPhotos.sublist(0, 3), best: some(saturdayPhotos[0]));

  Future<void> pumpScreen(WidgetTester tester, Set<PhotoId> selected) async {
    await tester.binding.setSurfaceSize(const Size(480, 1000));
    cubit = _MockQualityReviewCubit();
    whenListen(
      cubit,
      const Stream<QualityReviewState>.empty(),
      initialState: QualityReviewReady(groups: <QualityGroup>[series], selected: selected),
    );
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: GlobalMaterialLocalizations.delegates,
        supportedLocales: const <Locale>[Locale('fr')],
        locale: const Locale('fr'),
        home: BlocProvider<QualityReviewCubit>.value(
          value: cubit,
          child: const QualityReviewScreen(issue: QualityIssue.duplicates),
        ),
      ),
    );
  }

  testWidgets('shows one card per series with portrait tiles', (WidgetTester tester) async {
    await pumpScreen(tester, const <PhotoId>{});

    expect(find.text('Série de 3 photos'), findsOneWidget);
    expect(find.byType(QualityPhotoTile), findsNWidgets(3));
  });

  testWidgets('shows the discard button only when photos are to discard', (WidgetTester tester) async {
    await pumpScreen(tester, const <PhotoId>{});
    expect(find.byType(DsButton), findsNothing);

    await pumpScreen(tester, <PhotoId>{saturdayPhotos[1].id});
    expect(find.text('Écarter 1 photo'), findsOneWidget);
  });

  testWidgets('opens a photo in full screen and changes its status there', (WidgetTester tester) async {
    await pumpScreen(tester, const <PhotoId>{});

    await tester.tap(find.byType(QualityPhotoTile).at(1));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 600));
    expect(find.byType(QualityPhotoViewer), findsOneWidget);

    await tester.tap(find.text('Écarter'));

    verify(() => cubit.toggle(saturdayPhotos[1].id)).called(1);
  });

  testWidgets('shows the best photo of a series without the toggle', (WidgetTester tester) async {
    await pumpScreen(tester, const <PhotoId>{});

    await tester.tap(find.byType(QualityPhotoTile).first);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 600));

    expect(find.text('Meilleure de la série'), findsOneWidget);
    expect(find.text('Écarter'), findsNothing);
  });
}
