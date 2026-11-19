import 'package:core_ui/src/foundation/ds_colors.dart';
import 'package:core_ui/src/foundation/ds_gradients.dart';
import 'package:core_ui/src/foundation/ds_radius.dart';
import 'package:core_ui/src/foundation/ds_shadows.dart';
import 'package:core_ui/src/foundation/ds_spacing.dart';
import 'package:core_ui/src/foundation/ds_text_styles.dart';
import 'package:core_ui/src/widgets/buttons/ds_round_icon_button.dart';
import 'package:core_ui/src/widgets/chips/ds_glass_pill.dart';
import 'package:core_ui/src/widgets/media/ds_avatar_stack.dart';
import 'package:core_ui/src/widgets/media/ds_photo.dart';
import 'package:flutter/material.dart';

/// Event card with the title laid in white on its cover photo ("Anniversaire de mamie").
class DsEventPhotoCard extends StatelessWidget {
  const DsEventPhotoCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.badge,
    this.cover,
    this.placeholderIndex = 3,
    this.thumbnails = const <ImageProvider?>[],
    this.extraCount = 0,
    this.height = 200,
  });

  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final String? badge;
  final ImageProvider? cover;
  final int placeholderIndex;
  final List<ImageProvider?> thumbnails;
  final int extraCount;
  final double height;

  @override
  Widget build(BuildContext context) {
    final String? badgeLabel = badge;
    return DecoratedBox(
      decoration: const BoxDecoration(borderRadius: DsRadius.cardAll, boxShadow: DsShadows.card),
      child: ClipRRect(
        borderRadius: DsRadius.cardAll,
        child: SizedBox(
          height: height,
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              DsPhoto(image: cover, placeholderIndex: placeholderIndex, borderRadius: BorderRadius.zero),
              const DecoratedBox(decoration: BoxDecoration(gradient: DsGradients.photoScrim)),
              Material(
                type: MaterialType.transparency,
                child: InkWell(onTap: onTap),
              ),
              Padding(
                padding: const EdgeInsets.all(DsSpacing.m),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        if (badgeLabel != null) DsGlassPill(label: badgeLabel),
                        const Spacer(),
                        DsRoundIconButton(icon: Icons.north_east_rounded, tooltip: title, onPressed: onTap, size: 36),
                      ],
                    ),
                    const Spacer(),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(title, style: DsTextStyles.titleL.copyWith(color: DsColors.background)),
                              Text(
                                subtitle,
                                style: DsTextStyles.caption.copyWith(
                                  color: DsColors.background.withValues(alpha: 0.85),
                                ),
                              ),
                            ],
                          ),
                        ),
                        DsAvatarStack(images: thumbnails, extraCount: extraCount),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
