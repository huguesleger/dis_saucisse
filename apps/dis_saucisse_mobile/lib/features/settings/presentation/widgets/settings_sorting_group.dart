import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_mobile/core/formatting/french_dates.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';

class SettingsSortingGroup extends StatelessWidget {
  const SettingsSortingGroup({super.key, required this.startDate, required this.onChangeStartDate});

  final Option<DateTime> startDate;
  final ValueChanged<DateTime> onChangeStartDate;

  @override
  Widget build(BuildContext context) => DsSettingsGroup(
    title: 'Tri',
    children: <Widget>[
      DsSettingsTile(
        icon: Icons.event_outlined,
        iconBackground: DsColors.skySoft,
        title: 'Photos à trier depuis le',
        subtitle: startDate.match(() => 'Pas encore choisi', frenchLongDate),
        trailing: const Icon(Icons.chevron_right_rounded, color: DsColors.text),
        onTap: () => onChangeStartDate(startDate.getOrElse(DateTime.now)),
      ),
    ],
  );
}
