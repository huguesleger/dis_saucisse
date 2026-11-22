import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_desktop/features/history/domain/entities/transfer_record.dart';
import 'package:dis_saucisse_desktop/features/history/presentation/bloc/history_cubit.dart';
import 'package:dis_saucisse_desktop/features/history/presentation/widgets/history_header.dart';
import 'package:dis_saucisse_desktop/features/history/presentation/widgets/history_stats_row.dart';
import 'package:dis_saucisse_desktop/features/history/presentation/widgets/history_transfer_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HistoryLoadedView extends StatelessWidget {
  const HistoryLoadedView({super.key, required this.state});

  final HistoryLoaded state;

  @override
  Widget build(BuildContext context) => ListView(
    padding: const EdgeInsets.all(DsSpacing.xxl),
    children: <Widget>[
      HistoryHeader(
        years: state.years,
        selectedYear: state.selectedYear,
        onSelectYear: context.read<HistoryCubit>().selectYear,
      ),
      const SizedBox(height: DsSpacing.xl),
      HistoryStatsRow(stats: state.stats, year: state.selectedYear),
      const SizedBox(height: DsSpacing.xl),
      DsSettingsGroup(
        title: 'Envois',
        children: <Widget>[
          for (final TransferRecord record in state.yearRecords)
            HistoryTransferRow(record: record, onOpen: context.read<HistoryCubit>().openStorageFolder),
        ],
      ),
    ],
  );
}
