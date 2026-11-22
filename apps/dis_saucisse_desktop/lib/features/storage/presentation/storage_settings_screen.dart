import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_desktop/core/presentation/widgets/failure_view.dart';
import 'package:dis_saucisse_desktop/features/storage/presentation/bloc/storage_settings_cubit.dart';
import 'package:dis_saucisse_desktop/features/storage/presentation/storage_settings_bone_mock.dart';
import 'package:dis_saucisse_desktop/features/storage/presentation/widgets/storage_settings_loaded_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StorageSettingsScreen extends StatelessWidget {
  const StorageSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocBuilder<StorageSettingsCubit, StorageSettingsState>(
    builder: (BuildContext context, StorageSettingsState state) => switch (state) {
      StorageSettingsLoading() => DsSkeletonizer(child: StorageSettingsLoadedView(state: storageSettingsBoneMock)),
      StorageSettingsFailed(:final failure) => FailureView(
        failure: failure,
        onRetry: context.read<StorageSettingsCubit>().load,
      ),
      final StorageSettingsLoaded loaded => StorageSettingsLoadedView(state: loaded),
    },
  );
}
