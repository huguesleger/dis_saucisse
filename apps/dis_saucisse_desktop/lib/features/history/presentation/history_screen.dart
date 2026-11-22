import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_desktop/core/presentation/widgets/failure_view.dart';
import 'package:dis_saucisse_desktop/core/router/routes.dart';
import 'package:dis_saucisse_desktop/features/history/presentation/bloc/history_cubit.dart';
import 'package:dis_saucisse_desktop/features/history/presentation/widgets/history_loaded_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocBuilder<HistoryCubit, HistoryState>(
    builder: (BuildContext context, HistoryState state) => switch (state) {
      HistoryLoading() => const Center(child: DsLoader()),
      HistoryFailed(:final failure) => FailureView(failure: failure, onRetry: context.read<HistoryCubit>().load),
      HistoryLoaded(records: <Object>[]) => DsMessageView(
        title: 'Aucune photo reçue pour l’instant',
        message:
            'Associe ton téléphone depuis l’écran Réception, puis envoie tes photos triées : chaque envoi apparaîtra ici.',
        placement: DsMessagePlacement.panel,
        primaryAction: DsMessageAction(
          label: 'Aller à la réception',
          onPressed: () => const ReceptionPageRoute().go(context),
        ),
      ),
      final HistoryLoaded loaded => HistoryLoadedView(state: loaded),
    },
  );
}
