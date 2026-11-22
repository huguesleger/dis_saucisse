import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_mobile/core/i18n/translations.g.dart';
import 'package:flutter/material.dart';

class DiscardedPhotoSelectDot extends StatelessWidget {
  const DiscardedPhotoSelectDot({super.key, required this.isSelected, required this.onTap});

  static const double _dotSize = 26;

  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Semantics(
    button: true,
    label: isSelected ? t.discarded.tile.unselect : t.discarded.tile.select,
    child: GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(DsSpacing.xs),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          width: _dotSize,
          height: _dotSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isSelected ? DsColors.mustard : DsColors.text.withValues(alpha: 0.25),
            border: Border.all(color: isSelected ? DsColors.mustard : DsColors.background, width: 2),
          ),
          child: isSelected ? const Icon(Icons.check_rounded, size: 16, color: DsColors.onMustard) : null,
        ),
      ),
    ),
  );
}
