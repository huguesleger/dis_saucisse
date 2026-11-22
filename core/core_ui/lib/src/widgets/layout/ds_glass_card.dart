import 'dart:ui';

import 'package:core_ui/src/foundation/ds_colors.dart';
import 'package:core_ui/src/foundation/ds_radius.dart';
import 'package:core_ui/src/foundation/ds_spacing.dart';
import 'package:flutter/widgets.dart';

/// Light frosted card laid on a full screen photo: the photo stays visible, blurred, behind its content.
class DsGlassCard extends StatelessWidget {
  const DsGlassCard({super.key, required this.child, this.padding = const EdgeInsets.all(DsSpacing.m)});

  final Widget child;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) => ClipRRect(
    borderRadius: DsRadius.cardAll,
    child: BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: DsColors.background.withValues(alpha: 0.72),
          borderRadius: DsRadius.cardAll,
          border: Border.all(color: DsColors.background.withValues(alpha: 0.6)),
        ),
        child: Padding(padding: padding, child: child),
      ),
    ),
  );
}
