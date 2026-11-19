import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_mobile/features/burst_sort/presentation/bloc/burst_sort_cubit.dart';
import 'package:dis_saucisse_mobile/features/burst_sort/presentation/widgets/burst_sort_in_progress_view.dart';
import 'package:dis_saucisse_mobile/features/burst_sort/presentation/widgets/burst_sort_message_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BurstSortScreen extends StatelessWidget {
  const BurstSortScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: DsColors.pageBackground,
    body: BlocBuilder<BurstSortCubit, BurstSortState>(
      builder: (BuildContext context, BurstSortState state) => switch (state) {
        BurstSortLoading() => const Center(child: CircularProgressIndicator(color: DsColors.mustard)),
        BurstSortFailed() => const BurstSortMessageView(
          title: 'Oups !',
          message: "Je n'ai pas réussi à charger tes photos.",
        ),
        BurstSortFinished() => const BurstSortMessageView(
          title: 'Tout est trié !',
          message: 'Bravo, il ne reste plus aucune rafale à trier ici.',
        ),
        final BurstSortInProgress sorting => BurstSortInProgressView(state: sorting),
      },
    ),
  );
}
