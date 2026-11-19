import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_desktop/features/storage/domain/entities/month_folder_format.dart';
import 'package:dis_saucisse_desktop/features/storage/domain/rules/storage_preview.dart';
import 'package:dis_saucisse_desktop/features/storage/presentation/bloc/storage_settings_cubit.dart';
import 'package:dis_saucisse_desktop/features/storage/presentation/widgets/storage_folder_card.dart';
import 'package:dis_saucisse_desktop/features/storage/presentation/widgets/storage_month_format_chips.dart';
import 'package:dis_saucisse_desktop/features/storage/presentation/widgets/storage_options_group.dart';
import 'package:dis_saucisse_desktop/features/storage/presentation/widgets/storage_preview_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StorageSettingsScreen extends StatelessWidget {
  const StorageSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocBuilder<StorageSettingsCubit, StorageSettingsState>(
    builder: (BuildContext context, StorageSettingsState state) => switch (state) {
      StorageSettingsLoading() => const Center(child: CircularProgressIndicator(color: DsColors.mustard)),
      StorageSettingsFailed() => Center(child: Text('Réglages illisibles pour le moment.', style: DsTextStyles.body)),
      final StorageSettingsLoaded loaded => ListView(
        padding: const EdgeInsets.all(DsSpacing.xxl),
        children: <Widget>[
          Text('Où et comment ranger les photos reçues', style: DsTextStyles.caption.copyWith(fontSize: 13)),
          Text('Dossier de rangement', style: DsTextStyles.display),
          const SizedBox(height: DsSpacing.xl),
          StorageFolderCard(
            folderPath: loaded.folderPath,
            onBrowse: context.read<StorageSettingsCubit>().chooseFolder,
          ),
          const SizedBox(height: DsSpacing.xl),
          StorageOptionsGroup(layout: loaded.layout, onChanged: context.read<StorageSettingsCubit>().updateLayout),
          if (loaded.layout.byMonth) ...<Widget>[
            const SizedBox(height: DsSpacing.l),
            StorageMonthFormatChips(
              selected: loaded.layout.monthFormat,
              onSelected: (MonthFolderFormat format) =>
                  context.read<StorageSettingsCubit>().updateLayout(loaded.layout.copyWith(monthFormat: format)),
            ),
          ],
          const SizedBox(height: DsSpacing.xl),
          StoragePreviewCard(folders: storagePreview(loaded.layout)),
          const SizedBox(height: DsSpacing.m),
          Text(
            'Les dossiers déjà existants sont réutilisés, rien n’est jamais écrasé.',
            style: DsTextStyles.caption,
          ),
        ],
      ),
    },
  );
}
