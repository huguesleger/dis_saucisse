import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_desktop/core/i18n/translations.g.dart';
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
        child: DsStatTile(
          value: '${stats.photoCount}',
          label: t.history.stats.photos(year: year),
        ),
      ),
      Expanded(
        child: DsStatTile(value: '${stats.eventCount}', label: t.history.stats.events),
      ),
      Expanded(
        child: DsStatTile(value: byteSizeLabel(stats.byteCount), label: t.history.stats.onDisk),
      ),
      Expanded(
        child: DsStatTile(value: '${stats.rejectedCount}', label: t.history.stats.lostPhotos),
      ),
    ],
  );
}
