import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_desktop/features/pairing/presentation/bloc/reception_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReceptionFailedView extends StatelessWidget {
  const ReceptionFailedView({super.key, required this.problem});

  final ReceptionProblem problem;

  @override
  Widget build(BuildContext context) => DsMessageView(
    title: switch (problem) {
      ReceptionProblem.noNetwork => 'Pas de réseau Wi-Fi',
      ReceptionProblem.serverUnavailable => 'Réception impossible',
    },
    message: switch (problem) {
      ReceptionProblem.noNetwork => 'Connecte l’ordinateur au Wi-Fi de la maison, puis réessaie.',
      ReceptionProblem.serverUnavailable =>
        'Une autre copie de Dis Saucisse ! est peut-être déjà ouverte sur cet ordinateur.',
    },
    placement: DsMessagePlacement.panel,
    primaryAction: DsMessageAction(label: 'Réessayer', onPressed: context.read<ReceptionCubit>().start),
  );
}
