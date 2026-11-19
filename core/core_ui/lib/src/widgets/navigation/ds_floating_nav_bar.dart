import 'package:core_ui/src/foundation/ds_colors.dart';
import 'package:core_ui/src/foundation/ds_radius.dart';
import 'package:core_ui/src/foundation/ds_shadows.dart';
import 'package:core_ui/src/foundation/ds_spacing.dart';
import 'package:core_ui/src/widgets/navigation/ds_floating_nav_bar_item.dart';
import 'package:core_ui/src/widgets/navigation/ds_nav_destination.dart';
import 'package:flutter/widgets.dart';

/// Floating dark pill navigation bar of the mobile app, detached from the bottom edge.
class DsFloatingNavBar extends StatelessWidget {
  const DsFloatingNavBar({
    super.key,
    required this.destinations,
    required this.selectedIndex,
    required this.onDestinationSelected,
  });

  final List<DsNavDestination> destinations;
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;

  @override
  Widget build(BuildContext context) => DecoratedBox(
    decoration: const BoxDecoration(
      color: DsColors.text,
      borderRadius: DsRadius.pillAll,
      boxShadow: DsShadows.floating,
    ),
    child: Padding(
      padding: const EdgeInsets.all(DsSpacing.xs - 2),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          for (final (int index, DsNavDestination destination) in destinations.indexed)
            Padding(
              padding: EdgeInsets.only(left: index == 0 ? 0 : DsSpacing.xs),
              child: DsFloatingNavBarItem(
                destination: destination,
                selected: index == selectedIndex,
                onTap: () => onDestinationSelected(index),
              ),
            ),
        ],
      ),
    ),
  );
}
