import 'package:core_ui/src/foundation/ds_colors.dart';
import 'package:core_ui/src/foundation/ds_spacing.dart';
import 'package:core_ui/src/foundation/ds_text_styles.dart';
import 'package:core_ui/src/widgets/layout/ds_icon_square.dart';
import 'package:flutter/material.dart';

/// Settings row: icon square, title, subtitle and a trailing widget (switch, chevron, button).
class DsSettingsTile extends StatelessWidget {
  const DsSettingsTile({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.trailing,
    this.iconBackground = DsColors.surfaceStrong,
    this.onTap,
  });

  final IconData icon;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final Color iconBackground;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final String? description = subtitle;
    final Widget? trailingWidget = trailing;
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: DsSpacing.m, vertical: DsSpacing.s),
        child: Row(
          children: <Widget>[
            DsIconSquare(icon: icon, background: iconBackground),
            const SizedBox(width: DsSpacing.s),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(title, style: DsTextStyles.bodyBold),
                  if (description != null) Text(description, style: DsTextStyles.caption),
                ],
              ),
            ),
            if (trailingWidget != null) ...<Widget>[const SizedBox(width: DsSpacing.s), trailingWidget],
          ],
        ),
      ),
    );
  }
}
