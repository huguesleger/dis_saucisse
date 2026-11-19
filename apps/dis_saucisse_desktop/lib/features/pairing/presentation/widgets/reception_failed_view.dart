import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_desktop/features/pairing/presentation/bloc/reception_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReceptionFailedView extends StatelessWidget {
  const ReceptionFailedView({super.key, required this.problem});

  final ReceptionProblem problem;

  @override
  Widget build(BuildContext context) => Center(
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 420),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: DsSpacing.m,
        children: <Widget>[
          const DsMascot(width: 160),
          Text(
            switch (problem) {
              ReceptionProblem.noNetwork => 'Pas de réseau Wi-Fi',
              ReceptionProblem.serverUnavailable => 'Réception impossible',
            },
            style: DsTextStyles.titleXl,
            textAlign: TextAlign.center,
          ),
          Text(
            switch (problem) {
              ReceptionProblem.noNetwork => 'Connecte l’ordinateur au Wi-Fi de la maison, puis réessaie.',
              ReceptionProblem.serverUnavailable =>
                'Une autre copie de Dis Saucisse ! est peut-être déjà ouverte sur cet ordinateur.',
            },
            style: DsTextStyles.body.copyWith(color: DsColors.textSoft),
            textAlign: TextAlign.center,
          ),
          DsButton(
            label: 'Réessayer',
            variant: DsButtonVariant.dark,
            expanded: false,
            onPressed: context.read<ReceptionCubit>().start,
          ),
        ],
      ),
    ),
  );
}
