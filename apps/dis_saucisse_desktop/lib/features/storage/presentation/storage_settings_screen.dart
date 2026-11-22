import 'package:core_ui/core_ui.dart';
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
      StorageSettingsFailed() => Center(child: Text('Réglages illisibles pour le moment.', style: DsTextStyles.body)),
      final StorageSettingsLoaded loaded => Padding(
        padding: const EdgeInsets.fromLTRB(DsSpacing.xxl, DsSpacing.xxl, DsSpacing.xxl, DsSpacing.xl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text('Choisis où et comment les photos sont classées', style: DsTextStyles.caption.copyWith(fontSize: 13)),
            Text('Dossier de rangement', style: DsTextStyles.display),
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
                      onBrowse: context.read<StorageSettingsCubit>().chooseFolder,
                      onLayoutChanged: context.read<StorageSettingsCubit>().updateLayout,
                    ),
                  ),
                  SizedBox(
                    width: 250,
                    child: StoragePreviewCard(folderPath: loaded.folderPath, folders: storagePreview(loaded.layout)),
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
