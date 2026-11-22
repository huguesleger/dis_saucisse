import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_mobile/core/router/routes.dart';
import 'package:dis_saucisse_mobile/features/transfer/presentation/bloc/transfer_cubit.dart';
import 'package:dis_saucisse_mobile/features/transfer/presentation/widgets/transfer_done_view.dart';
import 'package:dis_saucisse_mobile/features/transfer/presentation/widgets/transfer_progress_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dis_saucisse_mobile/core/i18n/translations.g.dart';

class TransferScreen extends StatelessWidget {
  const TransferScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final DsMessageAction backHome = DsMessageAction(
      label: t.transfer.backHome,
      onPressed: () => Navigator.of(context).maybePop(),
    );
    return Scaffold(
      body: BlocBuilder<TransferCubit, TransferState>(
        builder: (BuildContext context, TransferState state) => switch (state) {
          TransferPreparing() => const Center(child: DsLoader()),
          TransferNeedsPairing() => DsMessageView(
            title: t.transfer.needsPairing.title,
            message: t.transfer.needsPairing.message,
            primaryAction: DsMessageAction(
              label: t.transfer.needsPairing.pair,
              onPressed: () => const PairComputerPageRoute().pushReplacement(context),
            ),
            secondaryAction: backHome,
          ),
          TransferNothingToSend() => DsMessageView(
            title: t.transfer.nothingToSend.title,
            message: t.transfer.nothingToSend.message,
            primaryAction: DsMessageAction(
              label: t.transfer.nothingToSend.recheck,
              onPressed: context.read<TransferCubit>().start,
            ),
            secondaryAction: backHome,
          ),
          TransferFailed(:final TransferProblem problem) => DsMessageView(
            title: switch (problem) {
              TransferProblem.unreachable => t.transfer.unreachable.title,
              TransferProblem.failed => t.transfer.failed.title,
            },
            message: switch (problem) {
              TransferProblem.unreachable => t.transfer.unreachable.message,
              TransferProblem.failed => t.transfer.failed.message,
            },
            primaryAction: DsMessageAction(label: t.transfer.retry, onPressed: context.read<TransferCubit>().start),
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
