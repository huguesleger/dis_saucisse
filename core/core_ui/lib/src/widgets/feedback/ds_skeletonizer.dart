import 'package:core_ui/src/foundation/ds_colors.dart';
import 'package:flutter/widgets.dart';
import 'package:skeletonizer/skeletonizer.dart';

/// Draws [child] as shimmering grey shapes while [enabled].
///
/// Give it the real layout filled with placeholder data: the page keeps its shape while it loads.
class DsSkeletonizer extends StatelessWidget {
  const DsSkeletonizer({super.key, required this.child, this.enabled = true, this.ignorePointers = true});

  final Widget child;
  final bool enabled;

  /// Blocks the taps on [child] while enabled. Turn it off when a parent must stay tappable.
  final bool ignorePointers;

  /// Shortest time a skeleton should stay on screen, so the shimmer does not flash.
  static const Duration minDuration = Duration(milliseconds: 500);

  static const ShimmerEffect _shimmer = ShimmerEffect(
    baseColor: DsColors.border,
    highlightColor: DsColors.surface,
    duration: Duration(milliseconds: 900),
  );

  @override
  Widget build(BuildContext context) => Skeletonizer(
    enabled: enabled,
    effect: _shimmer,
    ignorePointers: ignorePointers,
    textBoneBorderRadius: TextBoneBorderRadius(BorderRadius.circular(6)),
    child: child,
  );
}
