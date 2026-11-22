import 'package:bloc_test/bloc_test.dart';
import 'package:dis_saucisse_desktop/features/storage/domain/storage_failure.dart';
import 'package:dis_saucisse_desktop/features/storage/presentation/bloc/storage_settings_cubit.dart';
import 'package:dis_saucisse_desktop/features/storage/presentation/storage_settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockStorageSettingsCubit extends MockCubit<StorageSettingsState> implements StorageSettingsCubit {}

void main() {
  testWidgets('explains unreadable settings and retries', (WidgetTester tester) async {
    await tester.binding.setSurfaceSize(const Size(1100, 760));
    final _MockStorageSettingsCubit cubit = _MockStorageSettingsCubit();
    whenListen(
      cubit,
      const Stream<StorageSettingsState>.empty(),
      initialState: const StorageSettingsFailed(StorageSettingsFailure()),
    );
    when(() => cubit.load()).thenAnswer((_) async {});
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: BlocProvider<StorageSettingsCubit>.value(value: cubit, child: const StorageSettingsScreen()),
        ),
      ),
    );

    expect(find.text('Réglages illisibles'), findsOneWidget);
    await tester.tap(find.text('Réessayer'));

    verify(() => cubit.load()).called(1);
  });
}
