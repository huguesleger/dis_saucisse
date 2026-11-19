import 'package:core_ui/src/foundation/ds_colors.dart';
import 'package:core_ui/src/foundation/ds_radius.dart';
import 'package:core_ui/src/foundation/ds_spacing.dart';
import 'package:core_ui/src/foundation/ds_text_styles.dart';
import 'package:core_ui/src/widgets/buttons/ds_button_variant.dart';
import 'package:flutter/material.dart';

/// Pill shaped button of the design system.
class DsButton extends StatelessWidget {
  const DsButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = DsButtonVariant.primary,
    this.icon,
    this.expanded = true,
  });

  final String label;
  final VoidCallback? onPressed;
  final DsButtonVariant variant;
  final IconData? icon;
  final bool expanded;

  @override
  Widget build(BuildContext context) {
    final (Color background, Color foreground, Color border) = switch (variant) {
      DsButtonVariant.primary => (DsColors.mustard, DsColors.onMustard, DsColors.mustard),
      DsButtonVariant.dark => (DsColors.text, DsColors.mustardLight, DsColors.text),
      DsButtonVariant.secondary => (DsColors.surface, DsColors.text, DsColors.border),
      DsButtonVariant.light => (DsColors.background, DsColors.text, DsColors.background),
    };
    final ButtonStyle style = FilledButton.styleFrom(
      backgroundColor: background,
      foregroundColor: foreground,
      disabledBackgroundColor: background.withValues(alpha: 0.5),
      disabledForegroundColor: foreground.withValues(alpha: 0.6),
      minimumSize: Size(expanded ? double.infinity : 0, 52),
      padding: const EdgeInsets.symmetric(horizontal: DsSpacing.xl),
      shape: const RoundedRectangleBorder(borderRadius: DsRadius.pillAll),
      side: BorderSide(color: border),
      textStyle: DsTextStyles.label,
      elevation: 0,
    );
    final Widget text = Text(label);
    final IconData? leadingIcon = icon;
    return leadingIcon == null
        ? FilledButton(onPressed: onPressed, style: style, child: text)
        : FilledButton.icon(onPressed: onPressed, style: style, icon: Icon(leadingIcon, size: 20), label: text);
  }
}
