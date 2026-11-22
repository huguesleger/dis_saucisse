import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_mobile/core/i18n/translations.g.dart';
import 'package:dis_saucisse_mobile/features/discarded_photos/presentation/bloc/discarded_photos_cubit.dart';
import 'package:dis_saucisse_mobile/features/discarded_photos/presentation/discarded_photos_navigation.dart';
import 'package:dis_saucisse_mobile/features/discarded_photos/presentation/widgets/discarded_photo_grid.dart';
import 'package:dis_saucisse_mobile/features/discarded_photos/presentation/widgets/discarded_photos_restore_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DiscardedPhotosReadyView extends StatelessWidget {
  const DiscardedPhotosReadyView({super.key, required this.state});

  final DiscardedPhotosReady state;

  String _countLabel(int count) =>
      count == 1 ? t.discarded.photoCount.single : t.discarded.photoCount.several(count: count);

  @override
  Widget build(BuildContext context) => DsMeshBackground(
    child: SafeArea(
      child: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(DsSpacing.l),
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: DsRoundIconButton(
                    icon: Icons.arrow_back_rounded,
                    tooltip: t.discarded.back,
                    onPressed: () => Navigator.of(context).maybePop(),
                  ),
                ),
                const SizedBox(height: DsSpacing.m),
                Text(t.discarded.title, style: DsTextStyles.display),
                const SizedBox(height: DsSpacing.xs),
                Text(t.discarded.intro, style: DsTextStyles.body.copyWith(color: DsColors.textSoft)),
                if (state.photos.onPhoneOnly.isNotEmpty) ...<Widget>[
                  const SizedBox(height: DsSpacing.xl),
                  DsSectionHeader(title: t.discarded.onPhone, trailing: _countLabel(state.photos.onPhoneOnly.length)),
                  const SizedBox(height: DsSpacing.s),
                  DiscardedPhotoGrid(
                    photos: state.photos.onPhoneOnly,
                    selected: state.selected,
                    onOpen: (int index) => openDiscardedPhoto(
                      context,
                      cubit: context.read<DiscardedPhotosCubit>(),
                      photos: state.photos.onPhoneOnly,
                      index: index,
                      canRestore: true,
                    ),
                    onToggle: context.read<DiscardedPhotosCubit>().toggle,
                  ),
                ],
                if (state.photos.alreadySent.isNotEmpty) ...<Widget>[
                  const SizedBox(height: DsSpacing.xl),
                  DsSectionHeader(
                    title: t.discarded.alreadySent.title,
                    trailing: _countLabel(state.photos.alreadySent.length),
                  ),
                  const SizedBox(height: DsSpacing.xs),
                  Text(t.discarded.alreadySent.message, style: DsTextStyles.caption),
                  const SizedBox(height: DsSpacing.s),
                  DiscardedPhotoGrid(
                    photos: state.photos.alreadySent,
                    selected: const {},
                    onOpen: (int index) => openDiscardedPhoto(
                      context,
                      cubit: context.read<DiscardedPhotosCubit>(),
                      photos: state.photos.alreadySent,
                      index: index,
                      canRestore: false,
                    ),
                    onToggle: null,
                  ),
                ],
              ],
            ),
          ),
          DiscardedPhotosRestoreButton(
            selectedCount: state.selected.length,
            onRestore: context.read<DiscardedPhotosCubit>().restoreSelected,
          ),
        ],
      ),
    ),
  );
}
