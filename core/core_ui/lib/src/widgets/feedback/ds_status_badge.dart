import 'package:core_ui/src/foundation/ds_colors.dart';
import 'package:core_ui/src/foundation/ds_radius.dart';
import 'package:core_ui/src/foundation/ds_spacing.dart';
import 'package:core_ui/src/foundation/ds_text_styles.dart';
import 'package:core_ui/src/widgets/feedback/ds_status_tone.dart';
import 'package:flutter/widgets.dart';

/// Small status pill ("Rangé", "Tout vérifié", "Meilleure de la série").
class DsStatusBadge extends StatelessWidget {
  const DsStatusBadge({super.key, required this.label, this.tone = DsStatusTone.success, this.icon});

  final String label;
  final DsStatusTone tone;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final (Color background, Color foreground) = switch (tone) {
      DsStatusTone.success => (DsColors.successSoft, DsColors.success),
      DsStatusTone.highlight => (DsColors.mustard, DsColors.onMustard),
      DsStatusTone.alert => (DsColors.sausage, DsColors.onSausage),
      DsStatusTone.neutral => (DsColors.surface, DsColors.text),
    };
    final IconData? leadingIcon = icon;
    return DecoratedBox(
      decoration: BoxDecoration(color: background, borderRadius: DsRadius.pillAll),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: DsSpacing.s - 2, vertical: DsSpacing.xxs),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            if (leadingIcon != null) ...<Widget>[
              Icon(leadingIcon, size: 14, color: foreground),
              const SizedBox(width: DsSpacing.xxs),
            ],
            Flexible(
              child: Text(
                label,
                style: DsTextStyles.caption.copyWith(color: foreground, fontSize: 12),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
