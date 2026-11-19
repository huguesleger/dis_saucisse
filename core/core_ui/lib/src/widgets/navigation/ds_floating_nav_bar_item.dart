import 'package:core_ui/src/foundation/ds_colors.dart';
import 'package:core_ui/src/widgets/navigation/ds_nav_destination.dart';
import 'package:flutter/material.dart';

/// One round tab of [DsFloatingNavBar]: a mustard disc when selected, a pale pink icon otherwise.
class DsFloatingNavBarItem extends StatelessWidget {
  const DsFloatingNavBarItem({super.key, required this.destination, required this.selected, required this.onTap});

  final DsNavDestination destination;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Semantics(
    selected: selected,
    button: true,
    label: destination.label,
    excludeSemantics: true,
    child: Tooltip(
      message: destination.label,
      child: InkResponse(
        onTap: onTap,
        radius: 32,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          width: 56,
          height: 56,
          decoration: BoxDecoration(color: selected ? DsColors.mustard : Colors.transparent, shape: BoxShape.circle),
          child: Icon(destination.icon, color: selected ? DsColors.text : DsColors.navInactive, size: 26),
        ),
      ),
    ),
  );
}
