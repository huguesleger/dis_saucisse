import 'package:dis_saucisse_mobile/features/burst_sort/presentation/bloc/burst_sort_cubit.dart';
import 'package:dis_saucisse_mobile/features/burst_sort/presentation/widgets/burst_sort_photo.dart';
import 'package:dis_saucisse_mobile/features/burst_sort/presentation/widgets/burst_sort_sheet.dart';
import 'package:dis_saucisse_mobile/features/burst_sort/presentation/widgets/burst_sort_top_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BurstSortInProgressView extends StatelessWidget {
  const BurstSortInProgressView({super.key, required this.state});

  final BurstSortInProgress state;

  @override
  Widget build(BuildContext context) => Column(
    children: <Widget>[
      Expanded(
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            BurstSortPhoto(
              photoId: state.cursor.photoId,
              onKeep: context.read<BurstSortCubit>().keep,
              onDiscard: context.read<BurstSortCubit>().discard,
            ),
            const Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: 160,
              child: IgnorePointer(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: <Color>[Color(0x803A1520), Color(0x003A1520)],
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: BurstSortTopBar(
                burstPosition: state.cursor.burstIndex + 1,
                burstCount: state.event.bursts.length,
                onBack: () => Navigator.of(context).maybePop(),
              ),
            ),
          ],
        ),
      ),
      BurstSortSheet(state: state),
    ],
  );
}
