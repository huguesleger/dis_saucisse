import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_desktop/features/history/domain/entities/year_stats.dart';
import 'package:flutter/material.dart';

class HistoryStatsRow extends StatelessWidget {
  const HistoryStatsRow({super.key, required this.stats, required this.year});

  final YearStats stats;
  final int year;

  @override
  Widget build(BuildContext context) => Row(
    spacing: DsSpacing.m,
    children: <Widget>[
      Expanded(
        child: DsStatTile(value: '${stats.photoCount}', label: 'photos rangées en $year'),
      ),
      Expanded(
        child: DsStatTile(value: '${stats.eventCount}', label: 'événements'),
      ),
      Expanded(
        child: DsStatTile(value: byteSizeLabel(stats.byteCount), label: 'sur le disque'),
      ),
      Expanded(
        child: DsStatTile(value: '${stats.rejectedCount}', label: 'photo perdue'),
      ),
    ],
  );
}
