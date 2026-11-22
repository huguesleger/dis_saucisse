import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_mobile/core/i18n/translations.g.dart';
import 'package:dis_saucisse_mobile/features/photo_library/presentation/sorting_start/sorting_start_choice.dart';
import 'package:dis_saucisse_mobile/features/photo_library/presentation/sorting_start/widgets/sorting_start_options.dart';
import 'package:flutter/material.dart';

class SettingsStartDateSheet extends StatefulWidget {
  const SettingsStartDateSheet({super.key, required this.current, required this.today});

  final DateTime current;
  final DateTime today;

  @override
  State<SettingsStartDateSheet> createState() => _SettingsStartDateSheetState();
}

class _SettingsStartDateSheetState extends State<SettingsStartDateSheet> {
  late SortingStartChoice _choice = CustomSortingStart(widget.current);

  @override
  Widget build(BuildContext context) => DsBottomSheet(
    title: t.settings.startDateSheet.title,
    child: SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: DsSpacing.m,
        children: <Widget>[
          SortingStartOptions(
            choice: _choice,
            today: widget.today,
            onChoose: (SortingStartChoice choice) => setState(() => _choice = choice),
          ),
          DsButton(
            label: t.settings.startDateSheet.confirm,
            variant: DsButtonVariant.dark,
            onPressed: () => Navigator.of(context).pop(_choice.startDate(widget.today)),
          ),
        ],
      ),
    ),
  );
}
