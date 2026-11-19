import 'dart:ui';

import 'package:core_ui/src/foundation/ds_colors.dart';
import 'package:core_ui/src/foundation/ds_radius.dart';
import 'package:core_ui/src/foundation/ds_spacing.dart';
import 'package:core_ui/src/foundation/ds_text_styles.dart';
import 'package:flutter/widgets.dart';

/// Frosted glass label laid on a photo ("Rafale 3 sur 9", "9 rafales à trier", "Netteté 96 %").
class DsGlassPill extends StatelessWidget {
  const DsGlassPill({super.key, required this.label, this.caption, this.icon});

  final String label;
  final String? caption;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final String? title = caption;
    final IconData? leadingIcon = icon;
    final TextStyle labelStyle = (title == null ? DsTextStyles.bodyBold : DsTextStyles.titleM).copyWith(
      color: DsColors.background,
    );
    return ClipRRect(
      borderRadius: title == null ? DsRadius.pillAll : DsRadius.mediumAll,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: DsColors.background.withValues(alpha: 0.22),
            borderRadius: title == null ? DsRadius.pillAll : DsRadius.mediumAll,
            border: Border.all(color: DsColors.background.withValues(alpha: 0.4)),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: DsSpacing.s, vertical: DsSpacing.xs - 2),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                if (title != null)
                  Text(title, style: DsTextStyles.caption.copyWith(color: DsColors.background.withValues(alpha: 0.85))),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    if (leadingIcon != null) ...<Widget>[
                      Icon(leadingIcon, size: 16, color: DsColors.background),
                      const SizedBox(width: DsSpacing.xxs),
                    ],
                    Text(label, style: labelStyle),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
