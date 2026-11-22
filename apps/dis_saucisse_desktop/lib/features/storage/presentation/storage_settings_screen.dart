import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_desktop/core/i18n/translations.g.dart';
import 'package:dis_saucisse_desktop/core/presentation/widgets/failure_view.dart';
import 'package:dis_saucisse_desktop/features/storage/domain/rules/storage_preview.dart';
import 'package:dis_saucisse_desktop/features/storage/presentation/bloc/storage_settings_cubit.dart';
import 'package:dis_saucisse_desktop/features/storage/presentation/widgets/storage_options_card.dart';
import 'package:dis_saucisse_desktop/features/storage/presentation/widgets/storage_preview_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StorageSettingsScreen extends StatelessWidget {
  const StorageSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocBuilder<StorageSettingsCubit, StorageSettingsState>(
    builder: (BuildContext context, StorageSettingsState state) => switch (state) {
      StorageSettingsLoading() => const Center(child: DsLoader()),
      StorageSettingsFailed(:final failure) => FailureView(
        failure: failure,
        onRetry: context.read<StorageSettingsCubit>().load,
      ),
      final StorageSettingsLoaded loaded => Padding(
        padding: const EdgeInsets.fromLTRB(DsSpacing.xxl, DsSpacing.xxl, DsSpacing.xxl, DsSpacing.xl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(t.storage.header.subtitle, style: DsTextStyles.caption.copyWith(fontSize: 13)),
            Text(t.storage.header.title, style: DsTextStyles.display),
            const SizedBox(height: DsSpacing.l),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                spacing: DsSpacing.l,
                children: <Widget>[
                  Expanded(
                    child: StorageOptionsCard(
                      folderPath: loaded.folderPath,
                      layout: loaded.layout,
                      currentYear: loaded.currentYear,
                      onBrowse: context.read<StorageSettingsCubit>().chooseFolder,
                      onLayoutChanged: context.read<StorageSettingsCubit>().updateLayout,
                    ),
                  ),
                  SizedBox(
                    width: 250,
                    child: StoragePreviewCard(
                      folderPath: loaded.folderPath,
                      folders: storagePreview(loaded.layout, year: loaded.currentYear),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    },
  );
}
