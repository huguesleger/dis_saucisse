import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_mobile/core/i18n/translations.g.dart';
import 'package:flutter/material.dart';

class DiscardedPhotoBadge extends StatelessWidget {
  const DiscardedPhotoBadge({super.key});

  @override
  Widget build(BuildContext context) => DecoratedBox(
    decoration: const BoxDecoration(color: DsColors.mustardLight, borderRadius: DsRadius.pillAll),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: DsSpacing.m, vertical: DsSpacing.xs),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: DsSpacing.xxs,
        children: <Widget>[
          const Icon(Icons.computer_rounded, size: 18, color: DsColors.onMustard),
          Text(t.discarded.viewer.badge.alreadySent, style: DsTextStyles.label.copyWith(color: DsColors.onMustard)),
        ],
      ),
    ),
  );
}
