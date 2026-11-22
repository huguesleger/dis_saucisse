import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_desktop/features/history/domain/entities/transfer_record.dart';
import 'package:dis_saucisse_desktop/features/history/presentation/bloc/history_cubit.dart';
import 'package:dis_saucisse_desktop/features/history/presentation/widgets/history_stats_row.dart';
import 'package:dis_saucisse_desktop/features/history/presentation/widgets/history_transfer_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocBuilder<HistoryCubit, HistoryState>(
    builder: (BuildContext context, HistoryState state) => switch (state) {
      HistoryLoading() => const Center(child: DsLoader()),
      HistoryFailed() => Center(child: Text('Historique illisible pour le moment.', style: DsTextStyles.body)),
      final HistoryLoaded loaded => ListView(
        padding: const EdgeInsets.all(DsSpacing.xxl),
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Tout ce qui a été reçu sur ce PC', style: DsTextStyles.caption.copyWith(fontSize: 13)),
                    Text('Historique', style: DsTextStyles.display),
                  ],
                ),
              ),
              Wrap(
                spacing: DsSpacing.xs,
                children: <Widget>[
                  for (final int year in loaded.years)
                    DsFilterChip(
                      label: '$year',
                      selected: year == loaded.selectedYear,
                      onSelected: () => context.read<HistoryCubit>().selectYear(year),
                    ),
                ],
              ),
            ],
          ),
          const SizedBox(height: DsSpacing.xl),
          HistoryStatsRow(stats: loaded.stats, year: loaded.selectedYear),
          const SizedBox(height: DsSpacing.xl),
          loaded.yearRecords.isEmpty
              ? Text('Aucun envoi reçu pour l’instant.', style: DsTextStyles.body.copyWith(color: DsColors.textSoft))
              : DsSettingsGroup(
                  title: 'Envois',
                  children: <Widget>[
                    for (final TransferRecord record in loaded.yearRecords)
                      HistoryTransferRow(record: record, onOpen: context.read<HistoryCubit>().openStorageFolder),
                  ],
                ),
        ],
      ),
    },
  );
}
