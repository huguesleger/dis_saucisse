import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_mobile/core/presentation/widgets/failure_view.dart';
import 'package:dis_saucisse_mobile/features/burst_sort/presentation/bloc/burst_sort_cubit.dart';
import 'package:dis_saucisse_mobile/features/burst_sort/presentation/widgets/burst_sort_in_progress_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BurstSortScreen extends StatelessWidget {
  const BurstSortScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final DsMessageAction backHome = DsMessageAction(
      label: "Retour à l'accueil",
      onPressed: () => Navigator.of(context).maybePop(),
    );
    return Scaffold(
      backgroundColor: DsColors.pageBackground,
      body: BlocBuilder<BurstSortCubit, BurstSortState>(
        builder: (BuildContext context, BurstSortState state) => switch (state) {
          BurstSortLoading() => const Center(child: DsLoader()),
          BurstSortFailed(:final failure) => FailureView(
            failure: failure,
            onRetry: context.read<BurstSortCubit>().load,
            secondaryAction: backHome,
          ),
          BurstSortFinished() => DsMessageView(
            title: 'Tout est trié !',
            message: 'Bravo, il ne reste plus aucune rafale à trier ici.',
            primaryAction: backHome,
          ),
          final BurstSortInProgress sorting => BurstSortInProgressView(state: sorting),
        },
      ),
    );
  }
}
