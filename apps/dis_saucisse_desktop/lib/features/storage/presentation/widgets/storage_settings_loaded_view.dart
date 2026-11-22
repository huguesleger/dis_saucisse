import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_desktop/core/i18n/translations.g.dart';
import 'package:dis_saucisse_desktop/features/storage/domain/rules/storage_preview.dart';
import 'package:dis_saucisse_desktop/features/storage/presentation/bloc/storage_settings_cubit.dart';
import 'package:dis_saucisse_desktop/features/storage/presentation/widgets/storage_options_card.dart';
import 'package:dis_saucisse_desktop/features/storage/presentation/widgets/storage_preview_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StorageSettingsLoadedView extends StatelessWidget {
  const StorageSettingsLoadedView({super.key, required this.state});

  final StorageSettingsLoaded state;

  @override
  Widget build(BuildContext context) => Padding(
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
                  folderPath: state.folderPath,
                  layout: state.layout,
                  currentYear: state.currentYear,
                  onBrowse: context.read<StorageSettingsCubit>().chooseFolder,
                  onLayoutChanged: context.read<StorageSettingsCubit>().updateLayout,
                ),
              ),
              SizedBox(
                width: 250,
                child: StoragePreviewCard(
                  folderPath: state.folderPath,
                  folders: storagePreview(state.layout, year: state.currentYear),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
