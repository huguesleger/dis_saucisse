import 'package:core_ui/src/foundation/ds_colors.dart';
import 'package:core_ui/src/foundation/ds_radius.dart';
import 'package:core_ui/src/foundation/ds_spacing.dart';
import 'package:core_ui/src/widgets/buttons/ds_round_icon_button.dart';
import 'package:core_ui/src/widgets/buttons/ds_round_icon_button_variant.dart';
import 'package:core_ui/src/widgets/chips/ds_glass_pill.dart';
import 'package:core_ui/src/widgets/feedback/ds_progress_bar.dart';
import 'package:core_ui/src/widgets/feedback/ds_status_badge.dart';
import 'package:core_ui/src/widgets/feedback/ds_status_tone.dart';
import 'package:core_ui/src/widgets/media/ds_photo.dart';
import 'package:flutter/material.dart';

class DsGallerySortingPieces extends StatelessWidget {
  const DsGallerySortingPieces({super.key});

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    spacing: DsSpacing.m,
    children: <Widget>[
      SizedBox(
        height: 220,
        child: Stack(
          children: <Widget>[
            const Positioned.fill(child: DsPhoto(placeholderIndex: 2, borderRadius: DsRadius.cardAll)),
            Positioned(
              top: DsSpacing.s,
              left: DsSpacing.s,
              right: DsSpacing.s,
              child: Row(
                children: <Widget>[
                  DsRoundIconButton(
                    icon: Icons.arrow_back_rounded,
                    tooltip: 'Retour',
                    variant: DsRoundIconButtonVariant.glass,
                    onPressed: () {},
                  ),
                  const Spacer(),
                  const DsGlassPill(label: 'Rafale 3 sur 9'),
                  const Spacer(),
                  DsRoundIconButton(
                    icon: Icons.more_horiz_rounded,
                    tooltip: 'Plus',
                    variant: DsRoundIconButtonVariant.glass,
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            const Positioned(
              left: DsSpacing.s,
              bottom: DsSpacing.s,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: DsSpacing.xs,
                children: <Widget>[
                  DsStatusBadge(label: 'Meilleure de la série', tone: DsStatusTone.highlight, icon: Icons.star_rounded),
                  Row(
                    spacing: DsSpacing.xs,
                    children: <Widget>[
                      DsGlassPill(caption: 'Netteté', label: '96 %'),
                      DsGlassPill(caption: 'Yeux ouverts', label: '4 / 4'),
                      DsGlassPill(caption: 'Sourires', label: '3'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      const DecoratedBox(
        decoration: BoxDecoration(color: DsColors.blush, borderRadius: DsRadius.mediumAll),
        child: Padding(
          padding: EdgeInsets.all(DsSpacing.m),
          child: DsProgressBar(value: 186 / 248),
        ),
      ),
      const Wrap(
        spacing: DsSpacing.xs,
        runSpacing: DsSpacing.xs,
        children: <Widget>[
          DsStatusBadge(label: 'Rangé'),
          DsStatusBadge(label: 'Tout vérifié', icon: Icons.check_rounded),
          DsStatusBadge(label: '12 rafales', tone: DsStatusTone.alert),
          DsStatusBadge(label: 'En attente', tone: DsStatusTone.neutral),
        ],
      ),
    ],
  );
}
