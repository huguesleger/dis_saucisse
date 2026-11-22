import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_mobile/core/i18n/translations.g.dart';
import 'package:dis_saucisse_mobile/core/formatting/french_dates.dart';
import 'package:dis_saucisse_mobile/features/memories/domain/entities/memory_month.dart';
import 'package:dis_saucisse_mobile/features/memories/presentation/widgets/memories_recap_stat.dart';
import 'package:flutter/widgets.dart';

class MemoriesRecapCard extends StatelessWidget {
  const MemoriesRecapCard({super.key, required this.memory});

  final MemoryMonth memory;

  @override
  Widget build(BuildContext context) => DecoratedBox(
    decoration: const BoxDecoration(
      borderRadius: DsRadius.cardAll,
      boxShadow: DsShadows.card,
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[DsColors.mustardLight, DsColors.peach, DsColors.blush],
      ),
    ),
    child: Padding(
      padding: const EdgeInsets.all(DsSpacing.l),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      t.memories.recap.caption,
                      style: DsTextStyles.caption.copyWith(color: DsColors.text, letterSpacing: 1),
                    ),
                    const SizedBox(height: DsSpacing.xxs),
                    Text(
                      t.memories.recap.title(month: frenchMonthName(memory.month.month)),
                      style: DsTextStyles.titleL,
                    ),
                  ],
                ),
              ),
              const DsMascot(width: 72),
            ],
          ),
          const SizedBox(height: DsSpacing.l),
          Row(
            spacing: DsSpacing.xs,
            children: <Widget>[
              Expanded(
                child: MemoriesRecapStat(
                  value: '${memory.photoCount}',
                  label: memory.photoCount == 1 ? t.memories.recap.photoSingle : t.memories.recap.photoSeveral,
                ),
              ),
              Expanded(
                child: MemoriesRecapStat(
                  value: '${memory.eventCount}',
                  label: memory.eventCount > 1 ? t.memories.recap.eventSeveral : t.memories.recap.eventSingle,
                ),
              ),
              Expanded(
                child: MemoriesRecapStat(value: byteSizeLabel(memory.byteCount), label: t.memories.recap.stored),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
