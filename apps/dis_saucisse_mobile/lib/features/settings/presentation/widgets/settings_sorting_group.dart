import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_mobile/core/formatting/french_dates.dart';
import 'package:dis_saucisse_mobile/core/i18n/translations.g.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';

class SettingsSortingGroup extends StatelessWidget {
  const SettingsSortingGroup({super.key, required this.startDate, required this.onChangeStartDate});

  final Option<DateTime> startDate;
  final ValueChanged<DateTime> onChangeStartDate;

  @override
  Widget build(BuildContext context) => DsSettingsGroup(
    title: t.settings.sorting.title,
    children: <Widget>[
      DsSettingsTile(
        icon: Icons.event_outlined,
        iconBackground: DsColors.skySoft,
        title: t.settings.sorting.startDate,
        subtitle: startDate.match(() => t.settings.sorting.notChosen, frenchLongDate),
        trailing: const Icon(Icons.chevron_right_rounded, color: DsColors.text),
        onTap: () => onChangeStartDate(startDate.getOrElse(DateTime.now)),
      ),
    ],
  );
}
