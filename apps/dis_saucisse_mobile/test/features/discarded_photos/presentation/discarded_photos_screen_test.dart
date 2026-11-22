import 'package:bloc_test/bloc_test.dart';
import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_mobile/features/discarded_photos/domain/entities/discarded_photos.dart';
import 'package:dis_saucisse_mobile/features/discarded_photos/presentation/bloc/discarded_photos_cubit.dart';
import 'package:dis_saucisse_mobile/features/discarded_photos/presentation/discarded_photos_screen.dart';
import 'package:dis_saucisse_mobile/features/discarded_photos/presentation/widgets/discarded_photo_badge.dart';
import 'package:dis_saucisse_mobile/features/discarded_photos/presentation/widgets/discarded_photo_tile.dart';
import 'package:dis_saucisse_mobile/features/discarded_photos/presentation/widgets/discarded_photo_viewer.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/photo_id.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../helpers/photo_fixtures.dart';

class _MockDiscardedPhotosCubit extends MockCubit<DiscardedPhotosState> implements DiscardedPhotosCubit {}

void main() {
  late _MockDiscardedPhotosCubit cubit;

  setUpAll(() => registerFallbackValue(<PhotoId>{}));

  Future<void> pumpScreen(WidgetTester tester, DiscardedPhotosState state) async {
    await tester.binding.setSurfaceSize(const Size(480, 1000));
    cubit = _MockDiscardedPhotosCubit();
    whenListen(cubit, const Stream<DiscardedPhotosState>.empty(), initialState: state);
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: GlobalMaterialLocalizations.delegates,
        supportedLocales: const <Locale>[Locale('fr')],
        locale: const Locale('fr'),
        home: BlocProvider<DiscardedPhotosCubit>.value(value: cubit, child: const DiscardedPhotosScreen()),
      ),
    );
  }

  DiscardedPhotosReady ready({Set<PhotoId> selected = const <PhotoId>{}}) => DiscardedPhotosReady(
    photos: DiscardedPhotos(onPhoneOnly: saturdayPhotos.sublist(0, 2), alreadySent: saturdayPhotos.sublist(2)),
    selected: selected,
  );

  testWidgets('shows the restore button only once a photo is selected', (WidgetTester tester) async {
    await pumpScreen(tester, ready());

    expect(find.byType(DsButton), findsNothing);
  });

  testWidgets('restores the selected photos', (WidgetTester tester) async {
    await pumpScreen(tester, ready(selected: <PhotoId>{const PhotoId('cake-1')}));
    when(() => cubit.restoreSelected()).thenAnswer((_) async {});

    await tester.tap(find.text('Remettre 1 photo à trier'));

    verify(() => cubit.restoreSelected()).called(1);
  });

  testWidgets('cannot select a photo already on the computer', (WidgetTester tester) async {
    await pumpScreen(tester, ready());

    final Iterable<DiscardedPhotoTile> tiles = tester.widgetList<DiscardedPhotoTile>(find.byType(DiscardedPhotoTile));
    expect(tiles.where((DiscardedPhotoTile tile) => tile.onToggle == null), hasLength(2));
    expect(find.text('Déjà sur ton PC'), findsOneWidget);
  });

  testWidgets('says when nothing was discarded', (WidgetTester tester) async {
    await pumpScreen(
      tester,
      const DiscardedPhotosReady(
        photos: DiscardedPhotos(onPhoneOnly: [], alreadySent: []),
        selected: <PhotoId>{},
      ),
    );

    expect(find.text('Aucune photo écartée'), findsOneWidget);
  });

  testWidgets('opens a photo in full screen and puts it back to sort', (WidgetTester tester) async {
    await pumpScreen(tester, ready());
    when(() => cubit.restore(any())).thenAnswer((_) async {});

    await tester.tap(find.byType(DiscardedPhotoTile).first);
    await tester.pumpAndSettle();
    expect(find.byType(DiscardedPhotoViewer), findsOneWidget);
    expect(find.bySemanticsLabel('Photo 1 sur 2'), findsOneWidget);

    await tester.tap(find.text('Remettre à trier'));
    await tester.pumpAndSettle();

    expect(find.byType(DiscardedPhotoViewer), findsNothing);
    verify(() => cubit.restore(<PhotoId>{const PhotoId('cake-1')})).called(1);
  });

  testWidgets('shows a photo already on the computer without the restore action', (WidgetTester tester) async {
    await pumpScreen(tester, ready());

    await tester.tap(find.byType(DiscardedPhotoTile).last);
    await tester.pumpAndSettle();

    expect(find.text('Remettre à trier'), findsNothing);
    expect(find.widgetWithText(DiscardedPhotoBadge, 'Sur ton PC'), findsOneWidget);
  });
}
