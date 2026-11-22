import 'package:core_ui/src/foundation/ds_colors.dart';
import 'package:flutter/material.dart';

/// Pull to refresh around a scrollable [child].
///
/// The [child] must be able to scroll even when its content is short: give a list
/// `AlwaysScrollableScrollPhysics`, or wrap a fixed layout in a `DsRefreshFillView`.
class DsRefresh extends StatelessWidget {
  const DsRefresh({super.key, required this.onRefresh, required this.child});

  /// Called when the user pulls down. The indicator spins until the returned future completes.
  final Future<void> Function() onRefresh;
  final Widget child;

  @override
  Widget build(BuildContext context) => RefreshIndicator(
    color: DsColors.text,
    backgroundColor: DsColors.mustardLight,
    onRefresh: onRefresh,
    child: child,
  );
}
