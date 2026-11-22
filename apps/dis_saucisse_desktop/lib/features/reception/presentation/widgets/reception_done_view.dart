import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_desktop/core/i18n/translations.g.dart';
import 'package:dis_saucisse_desktop/features/pairing/presentation/bloc/reception_cubit.dart';
import 'package:dis_saucisse_desktop/features/reception/domain/entities/received_event.dart';
import 'package:dis_saucisse_desktop/features/reception/presentation/widgets/reception_done_summary.dart';
import 'package:dis_saucisse_desktop/features/reception/presentation/widgets/reception_event_chip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReceptionDoneView extends StatelessWidget {
  const ReceptionDoneView({super.key, required this.done});

  final ReceptionDone done;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.all(DsSpacing.xxl),
    child: Column(
      children: <Widget>[
        const Spacer(),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 820),
          child: DsCard(
            color: DsColors.mustardLight,
            padding: const EdgeInsets.symmetric(horizontal: DsSpacing.xxl, vertical: DsSpacing.xxxl),
            child: Row(
              spacing: DsSpacing.xxl,
              children: <Widget>[
                const Expanded(flex: 4, child: DsMascot(width: 260)),
                Expanded(
                  flex: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(t.reception.done.title, style: DsTextStyles.number.copyWith(fontSize: 52)),
                      const SizedBox(height: DsSpacing.s),
                      ReceptionDoneSummary(
                        received: done.received,
                        rejected: done.rejected,
                        eventCount: done.events.length,
                      ),
                      const SizedBox(height: DsSpacing.m),
                      Wrap(
                        spacing: DsSpacing.xs,
                        runSpacing: DsSpacing.xs,
                        children: <Widget>[
                          for (final ReceivedEvent event in done.events) ReceptionEventChip(event: event),
                        ],
                      ),
                      const SizedBox(height: DsSpacing.l),
                      Wrap(
                        spacing: DsSpacing.s,
                        runSpacing: DsSpacing.s,
                        children: <Widget>[
                          DsButton(
                            label: t.reception.done.openFolder,
                            variant: DsButtonVariant.dark,
                            expanded: false,
                            onPressed: context.read<ReceptionCubit>().openStorageFolder,
                          ),
                          DsButton(
                            label: t.reception.done.close,
                            variant: DsButtonVariant.light,
                            expanded: false,
                            onPressed: context.read<ReceptionCubit>().closeSummary,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const Spacer(),
        Text(
          t.reception.done.phoneNext,
          style: DsTextStyles.caption,
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}
