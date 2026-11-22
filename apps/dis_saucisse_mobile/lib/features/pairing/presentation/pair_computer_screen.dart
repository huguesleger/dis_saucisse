import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_mobile/features/pairing/presentation/bloc/pair_computer_cubit.dart';
import 'package:dis_saucisse_mobile/features/pairing/presentation/widgets/pair_scanner_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dis_saucisse_mobile/core/i18n/translations.g.dart';

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
                t.pairing.pairingWith(computerName: computerName),
                style: DsTextStyles.titleM.copyWith(color: DsColors.background),
              ),
            ],
          ),
        ),
        PairComputerPaired(:final computer) => DsMessageView(
          title: t.pairing.paired.title,
          message: t.pairing.paired.message(computerName: computer.name),
          primaryAction: DsMessageAction(
            label: t.pairing.paired.backHome,
            onPressed: () => Navigator.of(context).maybePop(),
          ),
        ),
        PairComputerFailed(:final problem) => DsMessageView(
          title: switch (problem) {
            PairingProblem.invalidCode => t.pairing.invalidCode.title,
            PairingProblem.unreachable => t.pairing.unreachable.title,
            PairingProblem.refused => t.pairing.refused.title,
          },
          message: switch (problem) {
            PairingProblem.invalidCode => t.pairing.invalidCode.message,
            PairingProblem.unreachable => t.pairing.unreachable.message,
            PairingProblem.refused => t.pairing.refused.message,
          },
          primaryAction: DsMessageAction(label: t.pairing.retry, onPressed: context.read<PairComputerCubit>().retry),
        ),
      },
    ),
  );
}
