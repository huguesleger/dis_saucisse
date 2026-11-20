import 'package:core_ui/core_ui.dart';
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
  Widget build(BuildContext context) => SafeArea(
    child: Padding(
      padding: const EdgeInsets.fromLTRB(DsSpacing.l, DsSpacing.l, DsSpacing.l, DsSpacing.m),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: DsSpacing.m,
        children: <Widget>[
          Text('Trier les photos depuis…', style: DsTextStyles.titleL),
          SortingStartOptions(
            choice: _choice,
            today: widget.today,
            onChoose: (SortingStartChoice choice) => setState(() => _choice = choice),
          ),
          DsButton(
            label: 'Valider',
            variant: DsButtonVariant.dark,
            onPressed: () => Navigator.of(context).pop(_choice.startDate(widget.today)),
          ),
        ],
      ),
    ),
  );
}
