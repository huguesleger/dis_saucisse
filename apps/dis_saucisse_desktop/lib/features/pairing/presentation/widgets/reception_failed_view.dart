import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_desktop/core/i18n/translations.g.dart';
import 'package:dis_saucisse_desktop/features/pairing/presentation/bloc/reception_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReceptionFailedView extends StatelessWidget {
  const ReceptionFailedView({super.key, required this.problem});

  final ReceptionProblem problem;

  @override
  Widget build(BuildContext context) => DsMessageView(
    title: switch (problem) {
      ReceptionProblem.noNetwork => t.pairing.failed.noNetwork.title,
      ReceptionProblem.serverUnavailable => t.pairing.failed.serverUnavailable.title,
    },
    message: switch (problem) {
      ReceptionProblem.noNetwork => t.pairing.failed.noNetwork.message,
      ReceptionProblem.serverUnavailable => t.pairing.failed.serverUnavailable.message,
    },
    placement: DsMessagePlacement.panel,
    primaryAction: DsMessageAction(label: t.pairing.failed.retry, onPressed: context.read<ReceptionCubit>().start),
  );
}
