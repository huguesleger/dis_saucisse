import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_mobile/core/i18n/translations.g.dart';
import 'package:dis_saucisse_mobile/features/burst_sort/presentation/bloc/burst_sort_cubit.dart';
import 'package:dis_saucisse_mobile/features/burst_sort/presentation/widgets/burst_sort_thumbnails.dart';
import 'package:dis_saucisse_mobile/features/photo_events/presentation/event_labels.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BurstSortSheet extends StatelessWidget {
  const BurstSortSheet({super.key, required this.state});

  final BurstSortInProgress state;

  @override
  Widget build(BuildContext context) {
    final int photoCount = state.burst.photos.length;
    return DecoratedBox(
      decoration: const BoxDecoration(color: DsColors.pageBackground, borderRadius: DsRadius.sheetTop),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(DsSpacing.l, DsSpacing.l, DsSpacing.l, DsSpacing.m),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: DsSpacing.s,
            children: <Widget>[
              Text(eventTitle(state.event), style: DsTextStyles.titleL),
              Text(
                photoCount == 1
                    ? t.burstSort.sheet.photoCount.single
                    : t.burstSort.sheet.photoCount.several(count: photoCount),
                style: DsTextStyles.caption,
              ),
              BurstSortThumbnails(state: state),
              Text(
                t.burstSort.sheet.swipeHint,
                style: DsTextStyles.caption,
                textAlign: TextAlign.center,
              ),
              Row(
                spacing: DsSpacing.s,
                children: <Widget>[
                  Expanded(
                    child: DsButton(
                      label: t.burstSort.sheet.discard,
                      variant: DsButtonVariant.light,
                      onPressed: context.read<BurstSortCubit>().discard,
                    ),
                  ),
                  Expanded(
                    child: DsButton(label: t.burstSort.sheet.keep, onPressed: context.read<BurstSortCubit>().keep),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
