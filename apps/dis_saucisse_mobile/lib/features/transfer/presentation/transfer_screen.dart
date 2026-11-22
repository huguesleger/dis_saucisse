import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_mobile/core/router/routes.dart';
import 'package:dis_saucisse_mobile/features/transfer/presentation/bloc/transfer_cubit.dart';
import 'package:dis_saucisse_mobile/features/transfer/presentation/widgets/transfer_done_view.dart';
import 'package:dis_saucisse_mobile/features/transfer/presentation/widgets/transfer_progress_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransferScreen extends StatelessWidget {
  const TransferScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final DsMessageAction backHome = DsMessageAction(
      label: 'Retour à l’accueil',
      onPressed: () => Navigator.of(context).maybePop(),
    );
    return Scaffold(
      body: BlocBuilder<TransferCubit, TransferState>(
        builder: (BuildContext context, TransferState state) => switch (state) {
          TransferPreparing() => const Center(child: DsLoader()),
          TransferNeedsPairing() => DsMessageView(
            title: 'Associe d’abord ton PC',
            message: 'Ouvre Dis Saucisse ! sur ton ordinateur et scanne son QR code.',
            primaryAction: DsMessageAction(
              label: 'Associer mon PC',
              onPressed: () => const PairComputerPageRoute().pushReplacement(context),
            ),
            secondaryAction: backHome,
          ),
          TransferNothingToSend() => DsMessageView(
            title: 'Rien à envoyer',
            message: 'Trie des photos : celles que tu gardes ou écartes partiront sur ton PC.',
            primaryAction: DsMessageAction(label: 'Revérifier', onPressed: context.read<TransferCubit>().start),
            secondaryAction: backHome,
          ),
          TransferFailed(:final TransferProblem problem) => DsMessageView(
            title: switch (problem) {
              TransferProblem.unreachable => 'PC introuvable',
              TransferProblem.failed => 'L’envoi s’est arrêté',
            },
            message: switch (problem) {
              TransferProblem.unreachable =>
                'Vérifie que le PC est allumé, que l’app est ouverte et que vous êtes sur le même Wi-Fi.',
              TransferProblem.failed => 'Les photos déjà envoyées sont à l’abri. Réessaie pour envoyer la suite.',
            },
            primaryAction: DsMessageAction(label: 'Réessayer', onPressed: context.read<TransferCubit>().start),
            secondaryAction: backHome,
          ),
          TransferSending(:final progress) => TransferProgressView(progress: progress, paused: false),
          TransferPaused(:final progress) => TransferProgressView(progress: progress, paused: true),
          TransferWaitingForComputer(:final progress) => TransferProgressView(
            progress: progress,
            paused: false,
            waitingForComputer: true,
          ),
          TransferFinished(:final computerName, :final sentCount, :final eventCount, :final sentBytes) =>
            TransferDoneView(
              computerName: computerName,
              sentCount: sentCount,
              eventCount: eventCount,
              sentBytes: sentBytes,
            ),
        },
      ),
    );
  }
}
