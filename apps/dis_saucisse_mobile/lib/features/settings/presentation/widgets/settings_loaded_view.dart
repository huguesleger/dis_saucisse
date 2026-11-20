import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_mobile/features/settings/presentation/bloc/settings_cubit.dart';
import 'package:dis_saucisse_mobile/features/settings/presentation/settings_navigation.dart';
import 'package:dis_saucisse_mobile/features/settings/presentation/widgets/settings_after_sending_group.dart';
import 'package:dis_saucisse_mobile/features/settings/presentation/widgets/settings_computer_card.dart';
import 'package:dis_saucisse_mobile/features/settings/presentation/widgets/settings_header.dart';
import 'package:dis_saucisse_mobile/features/settings/presentation/widgets/settings_ignored_group.dart';
import 'package:dis_saucisse_mobile/features/settings/presentation/widgets/settings_sorting_group.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsLoadedView extends StatelessWidget {
  const SettingsLoadedView({super.key, required this.state});

  final SettingsLoaded state;

  @override
  Widget build(BuildContext context) {
    final SettingsCubit cubit = context.read<SettingsCubit>();
    return SafeArea(
      bottom: false,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(DsSpacing.l, DsSpacing.m, DsSpacing.l, 140),
        children: <Widget>[
          const SettingsHeader(),
          const SizedBox(height: DsSpacing.xl),
          SettingsComputerCard(
            computer: state.computer,
            onChange: () => openPairComputer(context, cubit: cubit),
          ),
          const SizedBox(height: DsSpacing.xl),
          SettingsSortingGroup(
            startDate: state.startDate,
            onChangeStartDate: (DateTime current) => openStartDateSheet(context, cubit: cubit, current: current),
          ),
          const SizedBox(height: DsSpacing.xl),
          SettingsIgnoredGroup(ignoredOrigins: state.ignoredOrigins, onIgnoredChanged: cubit.ignoreOrigin),
          const SizedBox(height: DsSpacing.xl),
          SettingsAfterSendingGroup(onFreeSpace: () => openFreeSpace(context)),
        ],
      ),
    );
  }
}
