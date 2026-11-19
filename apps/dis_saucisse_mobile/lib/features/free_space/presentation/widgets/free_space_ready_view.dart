import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
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
          Text('Libérer de la place', style: DsTextStyles.display),
          const SizedBox(height: DsSpacing.xs),
          Text(
            'Ces photos sont déjà rangées et vérifiées sur ton ordinateur.',
            style: DsTextStyles.body.copyWith(color: DsColors.textSoft),
          ),
          const SizedBox(height: DsSpacing.xl),
          DsSettingsGroup(
            children: <Widget>[
              DsSettingsTile(
                icon: Icons.favorite_border_rounded,
                iconBackground: DsColors.mustardLight,
                title: '${state.photos.kept.length} photos gardées',
                subtitle: byteSizeLabel(state.photos.keptBytes),
                trailing: const Icon(Icons.check_rounded, color: DsColors.success),
              ),
              if (state.photos.discarded.isNotEmpty)
                DsSettingsTile(
                  icon: Icons.delete_outline_rounded,
                  iconBackground: DsColors.surfaceStrong,
                  title: 'Supprimer aussi les ${state.photos.discarded.length} écartées',
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
            'Elles partent dans la corbeille du téléphone : tu peux les récupérer pendant 30 jours.',
            style: DsTextStyles.caption,
          ),
          const SizedBox(height: DsSpacing.xl),
          DsButton(
            label: 'Libérer ${byteSizeLabel(state.selectedBytes)}',
            variant: DsButtonVariant.dark,
            onPressed: state.selected.isEmpty ? null : context.read<FreeSpaceCubit>().freeSpace,
          ),
          const SizedBox(height: DsSpacing.s),
          DsButton(
            label: 'Garder sur le téléphone',
            variant: DsButtonVariant.light,
            onPressed: () => Navigator.of(context).maybePop(),
          ),
        ],
      ),
    ),
  );
}
