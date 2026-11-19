import 'package:core_ui/src/foundation/ds_colors.dart';
import 'package:core_ui/src/foundation/ds_radius.dart';
import 'package:core_ui/src/foundation/ds_shadows.dart';
import 'package:core_ui/src/foundation/ds_spacing.dart';
import 'package:flutter/material.dart';

/// White rounded card with a soft shadow.
class DsCard extends StatelessWidget {
  const DsCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(DsSpacing.m),
    this.color = DsColors.background,
    this.onTap,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final Color color;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) => DecoratedBox(
    decoration: const BoxDecoration(borderRadius: DsRadius.cardAll, boxShadow: DsShadows.card),
    child: Material(
      color: color,
      borderRadius: DsRadius.cardAll,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(padding: padding, child: child),
      ),
    ),
  );
}
