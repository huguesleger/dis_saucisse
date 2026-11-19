import 'package:core_ui/src/foundation/ds_colors.dart';
import 'package:core_ui/src/foundation/ds_radius.dart';
import 'package:core_ui/src/foundation/ds_spacing.dart';
import 'package:core_ui/src/foundation/ds_text_styles.dart';
import 'package:core_ui/src/widgets/navigation/ds_nav_destination.dart';
import 'package:flutter/material.dart';

/// Entry of the desktop sidebar ("Réception", "Dossier de rangement", "Historique").
class DsSidebarItem extends StatelessWidget {
  const DsSidebarItem({super.key, required this.destination, required this.selected, required this.onTap});

  final DsNavDestination destination;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final Color foreground = selected ? DsColors.mustardLight : DsColors.text;
    return Semantics(
      selected: selected,
      button: true,
      child: Material(
        color: selected ? DsColors.text : Colors.transparent,
        borderRadius: DsRadius.mediumAll,
        child: InkWell(
          onTap: onTap,
          borderRadius: DsRadius.mediumAll,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: DsSpacing.s, vertical: DsSpacing.s - 2),
            child: Row(
              children: <Widget>[
                Icon(destination.icon, size: 20, color: foreground),
                const SizedBox(width: DsSpacing.s),
                Expanded(
                  child: Text(destination.label, style: DsTextStyles.bodyBold.copyWith(color: foreground)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
