import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_mobile/features/settings/presentation/bloc/settings_cubit.dart';
import 'package:dis_saucisse_mobile/features/settings/presentation/widgets/settings_loaded_view.dart';
import 'package:dis_saucisse_mobile/features/settings/presentation/widgets/settings_message_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    body: DsMeshBackground(
      meshHeight: 340,
      child: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (BuildContext context, SettingsState state) => switch (state) {
          SettingsLoading() => const Center(child: CircularProgressIndicator(color: DsColors.mustard)),
          SettingsFailed() => SettingsMessageView(onRetry: context.read<SettingsCubit>().load),
          final SettingsLoaded loaded => SettingsLoadedView(state: loaded),
        },
      ),
    ),
  );
}
