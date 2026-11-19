import 'dart:ui';

import 'package:core_ui/src/foundation/ds_colors.dart';
import 'package:core_ui/src/foundation/ds_shadows.dart';
import 'package:core_ui/src/widgets/buttons/ds_round_icon_button_variant.dart';
import 'package:flutter/material.dart';

/// Round icon button ("calendrier", "envoi vers le PC", back button on a photo).
class DsRoundIconButton extends StatelessWidget {
  const DsRoundIconButton({
    super.key,
    required this.icon,
    required this.tooltip,
    required this.onPressed,
    this.variant = DsRoundIconButtonVariant.light,
    this.size = 44,
  });

  final IconData icon;
  final String tooltip;
  final VoidCallback? onPressed;
  final DsRoundIconButtonVariant variant;
  final double size;

  @override
  Widget build(BuildContext context) {
    final (Color background, Color foreground, double blur) = switch (variant) {
      DsRoundIconButtonVariant.light => (DsColors.background, DsColors.text, 0.0),
      DsRoundIconButtonVariant.dark => (DsColors.text, DsColors.mustardLight, 0.0),
      DsRoundIconButtonVariant.glass => (DsColors.background.withValues(alpha: 0.25), DsColors.background, 12.0),
    };
    return Tooltip(
      message: tooltip,
      child: DecoratedBox(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: variant == DsRoundIconButtonVariant.glass ? null : DsShadows.card,
        ),
        child: ClipOval(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
            child: Material(
              color: background,
              child: InkWell(
                onTap: onPressed,
                child: SizedBox.square(
                  dimension: size,
                  child: Icon(icon, color: foreground, size: size * 0.45),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
