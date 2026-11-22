import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_mobile/features/transfer/domain/entities/transfer_progress.dart';
import 'package:dis_saucisse_mobile/features/transfer/presentation/bloc/transfer_cubit.dart';
import 'package:dis_saucisse_mobile/features/transfer/presentation/widgets/transfer_details.dart';
import 'package:dis_saucisse_mobile/features/transfer/presentation/widgets/transfer_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dis_saucisse_mobile/core/i18n/translations.g.dart';

class TransferProgressView extends StatelessWidget {
  const TransferProgressView({
    super.key,
    required this.progress,
    required this.paused,
    this.waitingForComputer = false,
  });

  final TransferProgress progress;
  final bool paused;
  final bool waitingForComputer;

  @override
  Widget build(BuildContext context) => DsMeshBackground(
    meshHeight: 420,
    child: SafeArea(
      child: ListView(
        padding: const EdgeInsets.only(bottom: DsSpacing.l),
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.all(DsSpacing.m),
              child: DsRoundIconButton(
                icon: Icons.arrow_back_rounded,
                tooltip: t.transfer.backHome,
                onPressed: () => Navigator.of(context).maybePop(),
              ),
            ),
          ),
          TransferHeader(progress: progress, now: context.read<TransferCubit>().now),
          const SizedBox(height: DsSpacing.xl),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: DsSpacing.l),
            child: TransferDetails(
              progress: progress,
              paused: paused,
              waitingForComputer: waitingForComputer,
              onPause: context.read<TransferCubit>().pause,
              onResume: context.read<TransferCubit>().resume,
            ),
          ),
        ],
      ),
    ),
  );
}
