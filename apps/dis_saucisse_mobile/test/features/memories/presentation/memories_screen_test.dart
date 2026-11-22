import 'package:bloc_test/bloc_test.dart';
import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_mobile/features/memories/presentation/bloc/memories_cubit.dart';
import 'package:dis_saucisse_mobile/features/memories/presentation/memories_screen.dart';
import 'package:dis_saucisse_mobile/features/memories/presentation/widgets/memories_loaded_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

class _MockMemoriesCubit extends MockCubit<MemoriesState> implements MemoriesCubit {}

void main() {
  testWidgets('shows the skeleton of the memories while loading', (WidgetTester tester) async {
    await tester.binding.setSurfaceSize(const Size(480, 1000));
    final _MockMemoriesCubit memories = _MockMemoriesCubit();
    whenListen(memories, const Stream<MemoriesState>.empty(), initialState: const MemoriesLoading());

    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: GlobalMaterialLocalizations.delegates,
        supportedLocales: const <Locale>[Locale('fr')],
        locale: const Locale('fr'),
        home: BlocProvider<MemoriesCubit>.value(value: memories, child: const MemoriesScreen()),
      ),
    );

    expect(
      find.descendant(of: find.byType(DsSkeletonizer), matching: find.byType(MemoriesLoadedView)),
      findsOneWidget,
    );
  });
}
