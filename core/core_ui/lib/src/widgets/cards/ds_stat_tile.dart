import 'package:core_ui/src/foundation/ds_colors.dart';
import 'package:core_ui/src/foundation/ds_spacing.dart';
import 'package:core_ui/src/foundation/ds_text_styles.dart';
import 'package:core_ui/src/widgets/layout/ds_card.dart';
import 'package:core_ui/src/widgets/layout/ds_icon_square.dart';
import 'package:flutter/material.dart';

/// Bento tile with an icon, a big value and a label ("31 doublons", "186 vérifiées").
class DsStatTile extends StatelessWidget {
  const DsStatTile({
    super.key,
    required this.value,
    required this.label,
    this.icon,
    this.iconBackground = DsColors.mustardLight,
    this.onTap,
  });

  final String value;
  final String label;
  final IconData? icon;
  final Color iconBackground;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final IconData? leadingIcon = icon;
    return DsCard(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (leadingIcon != null || onTap != null)
            Padding(
              padding: const EdgeInsets.only(bottom: DsSpacing.s),
              child: Row(
                children: <Widget>[
                  if (leadingIcon != null) DsIconSquare(icon: leadingIcon, background: iconBackground),
                  const Spacer(),
                  if (onTap != null) const Icon(Icons.chevron_right_rounded, color: DsColors.text),
                ],
              ),
            ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: <Widget>[
              Text(value, style: DsTextStyles.titleXl.copyWith(fontSize: 28)),
              const SizedBox(width: DsSpacing.xs),
              Flexible(
                child: Text(label, style: DsTextStyles.caption, overflow: TextOverflow.ellipsis),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
