import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

class SettingsSwitch extends StatelessWidget {
  const SettingsSwitch({super.key, required this.value, this.onChanged});

  final bool value;
  final ValueChanged<bool>? onChanged;

  @override
  Widget build(BuildContext context) => Opacity(
    opacity: onChanged == null ? 0.4 : 1,
    child: Switch(
      value: value,
      onChanged: onChanged,
      thumbIcon: const WidgetStatePropertyAll<Icon>(Icon(Icons.circle, color: Colors.transparent)),
      thumbColor: WidgetStateProperty.resolveWith(
        (Set<WidgetState> states) =>
            states.contains(WidgetState.selected) ? DsColors.mustardLight : DsColors.background,
      ),
      trackColor: WidgetStateProperty.resolveWith(
        (Set<WidgetState> states) => states.contains(WidgetState.selected) ? DsColors.text : DsColors.pageBackground,
      ),
      trackOutlineColor: WidgetStateProperty.resolveWith(
        (Set<WidgetState> states) => states.contains(WidgetState.selected) ? DsColors.text : DsColors.border,
      ),
    ),
  );
}
