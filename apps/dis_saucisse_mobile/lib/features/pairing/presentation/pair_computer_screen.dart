import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_mobile/features/pairing/presentation/bloc/pair_computer_cubit.dart';
import 'package:dis_saucisse_mobile/features/pairing/presentation/widgets/pair_message_view.dart';
import 'package:dis_saucisse_mobile/features/pairing/presentation/widgets/pair_scanner_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PairComputerScreen extends StatelessWidget {
  const PairComputerScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: DsColors.text,
    body: BlocBuilder<PairComputerCubit, PairComputerState>(
      builder: (BuildContext context, PairComputerState state) => switch (state) {
        PairComputerScanning() => const PairScannerView(),
        PairComputerPairing(:final String computerName) => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: DsSpacing.m,
            children: <Widget>[
              const DsLoader(),
              Text(
                'Association avec $computerName…',
                style: DsTextStyles.titleM.copyWith(color: DsColors.background),
              ),
            ],
          ),
        ),
        PairComputerPaired(:final computer) => PairMessageView(
          title: 'C’est fait !',
          message: 'Ton téléphone est associé à ${computer.name}. Tu pourras y envoyer tes photos triées.',
          actionLabel: 'Retour à l’accueil',
          onAction: () => Navigator.of(context).maybePop(),
        ),
        PairComputerFailed(:final problem) => PairMessageView(
          title: switch (problem) {
            PairingProblem.invalidCode => 'Ce n’est pas le bon QR code',
            PairingProblem.unreachable => 'PC introuvable',
            PairingProblem.refused => 'Association refusée',
          },
          message: switch (problem) {
            PairingProblem.invalidCode => 'Scanne le QR code affiché dans l’app Dis Saucisse ! sur ton PC.',
            PairingProblem.unreachable =>
              'Vérifie que le PC est allumé, que l’app est ouverte et que vous êtes sur le même Wi-Fi.',
            PairingProblem.refused => 'Le QR code a peut-être changé. Scanne celui affiché en ce moment sur le PC.',
          },
          actionLabel: 'Réessayer',
          onAction: context.read<PairComputerCubit>().retry,
        ),
      },
    ),
  );
}
