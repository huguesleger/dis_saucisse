import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_mobile/core/router/routes.dart';
import 'package:dis_saucisse_mobile/features/settings/presentation/bloc/settings_cubit.dart';
import 'package:dis_saucisse_mobile/features/settings/presentation/widgets/settings_start_date_sheet.dart';
import 'package:flutter/material.dart';

Future<void> openPairComputer(BuildContext context, {required SettingsCubit cubit}) async {
  await const PairComputerPageRoute().push<void>(context);
  await cubit.load();
}

Future<void> openFreeSpace(BuildContext context) => const FreeSpacePageRoute().push<void>(context);

Future<void> openStartDateSheet(BuildContext context, {required SettingsCubit cubit, required DateTime current}) async {
  final DateTime? start = await DsBottomSheet.show<DateTime>(
    context,
    builder: (BuildContext context) => SettingsStartDateSheet(current: current, today: DateTime.now()),
  );
  if (start != null) await cubit.changeStartDate(start);
}
