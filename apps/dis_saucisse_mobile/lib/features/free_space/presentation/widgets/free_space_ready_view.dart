import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_mobile/core/i18n/translations.g.dart';
import 'package:dis_saucisse_mobile/features/free_space/presentation/bloc/free_space_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FreeSpaceReadyView extends StatelessWidget {
  const FreeSpaceReadyView({super.key, required this.state});

  final FreeSpaceReady state;

  @override
  Widget build(BuildContext context) => DsMeshBackground(
    child: SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(DsSpacing.l),
        children: <Widget>[
          const Center(child: DsMascot(width: 140)),
          const SizedBox(height: DsSpacing.m),
          Text(t.freeSpace.ready.title, style: DsTextStyles.display),
          const SizedBox(height: DsSpacing.xs),
          Text(
            t.freeSpace.ready.subtitle,
            style: DsTextStyles.body.copyWith(color: DsColors.textSoft),
          ),
          const SizedBox(height: DsSpacing.xl),
          DsSettingsGroup(
            children: <Widget>[
              DsSettingsTile(
                icon: Icons.favorite_border_rounded,
                iconBackground: DsColors.mustardLight,
                title: t.freeSpace.ready.kept(count: state.photos.kept.length),
                subtitle: byteSizeLabel(state.photos.keptBytes),
                trailing: const Icon(Icons.check_rounded, color: DsColors.success),
              ),
              if (state.photos.discarded.isNotEmpty)
                DsSettingsTile(
                  icon: Icons.delete_outline_rounded,
                  iconBackground: DsColors.surfaceStrong,
                  title: t.freeSpace.ready.deleteDiscarded(count: state.photos.discarded.length),
                  subtitle: byteSizeLabel(state.photos.discardedBytes),
                  trailing: Switch(
                    value: state.includeDiscarded,
                    onChanged: context.read<FreeSpaceCubit>().includeDiscarded,
                  ),
                ),
            ],
          ),
          const SizedBox(height: DsSpacing.m),
          Text(
            t.freeSpace.ready.trashNote,
            style: DsTextStyles.caption,
          ),
          const SizedBox(height: DsSpacing.xl),
          DsButton(
            label: t.freeSpace.ready.free(size: byteSizeLabel(state.selectedBytes)),
            variant: DsButtonVariant.dark,
            onPressed: state.selected.isEmpty ? null : context.read<FreeSpaceCubit>().freeSpace,
          ),
          const SizedBox(height: DsSpacing.s),
          DsButton(
            label: t.freeSpace.ready.keep,
            variant: DsButtonVariant.light,
            onPressed: () => Navigator.of(context).maybePop(),
          ),
        ],
      ),
    ),
  );
}
