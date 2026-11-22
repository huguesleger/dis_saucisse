import 'package:bloc_test/bloc_test.dart';
import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_mobile/features/home/presentation/bloc/home_cubit.dart';
import 'package:dis_saucisse_mobile/features/home/presentation/home_screen.dart';
import 'package:dis_saucisse_mobile/features/home/presentation/widgets/home_loaded_view.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/photo_id.dart';
import 'package:dis_saucisse_mobile/features/photo_quality/domain/entities/photo_quality.dart';
import 'package:dis_saucisse_mobile/features/photo_quality/presentation/bloc/photo_quality_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

class _MockHomeCubit extends MockCubit<HomeState> implements HomeCubit {}

class _MockPhotoQualityCubit extends MockCubit<PhotoQualityState> implements PhotoQualityCubit {}

void main() {
  testWidgets('shows the skeleton of the home while loading', (WidgetTester tester) async {
    await tester.binding.setSurfaceSize(const Size(480, 1000));
    final _MockHomeCubit home = _MockHomeCubit();
    final _MockPhotoQualityCubit quality = _MockPhotoQualityCubit();
    whenListen(home, const Stream<HomeState>.empty(), initialState: const HomeLoading());
    whenListen(
      quality,
      const Stream<PhotoQualityState>.empty(),
      initialState: const PhotoQualityReady(<PhotoId, PhotoQuality>{}),
    );

    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: GlobalMaterialLocalizations.delegates,
        supportedLocales: const <Locale>[Locale('fr')],
        locale: const Locale('fr'),
        home: MultiBlocProvider(
          providers: <BlocProvider<dynamic>>[
            BlocProvider<HomeCubit>.value(value: home),
            BlocProvider<PhotoQualityCubit>.value(value: quality),
          ],
          child: const HomeScreen(),
        ),
      ),
    );

    expect(find.descendant(of: find.byType(DsSkeletonizer), matching: find.byType(HomeLoadedView)), findsOneWidget);
  });
}
