import 'package:core_ui/src/foundation/ds_colors.dart';
import 'package:core_ui/src/foundation/ds_text_styles.dart';
import 'package:flutter/material.dart';

/// Section title with an optional trailing text or action ("Novembre 2026 · 3 événements", "Tout voir").
class DsSectionHeader extends StatelessWidget {
  const DsSectionHeader({super.key, required this.title, this.trailing, this.onTrailingTap});

  final String title;
  final String? trailing;
  final VoidCallback? onTrailingTap;

  @override
  Widget build(BuildContext context) {
    final String? trailingText = trailing;
    return Row(
      children: <Widget>[
        Expanded(child: Text(title, style: DsTextStyles.titleM)),
        if (trailingText != null)
          GestureDetector(
            onTap: onTrailingTap,
            child: Text(trailingText, style: DsTextStyles.caption.copyWith(color: DsColors.textSoft)),
          ),
      ],
    );
  }
}
