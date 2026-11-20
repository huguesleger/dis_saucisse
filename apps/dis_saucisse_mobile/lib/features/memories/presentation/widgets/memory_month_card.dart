import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_mobile/features/memories/domain/entities/memory_month.dart';
import 'package:dis_saucisse_mobile/features/memories/presentation/memories_labels.dart';
import 'package:dis_saucisse_mobile/features/memories/presentation/widgets/memory_month_mosaic.dart';
import 'package:flutter/material.dart';

class MemoryMonthCard extends StatelessWidget {
  const MemoryMonthCard({super.key, required this.memory});

  final MemoryMonth memory;

  @override
  Widget build(BuildContext context) => DsCard(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(child: Text(memoryMonthTitle(memory.month), style: DsTextStyles.titleM)),
            const DsStatusBadge(label: 'Sur le PC', icon: Icons.check_rounded),
          ],
        ),
        const SizedBox(height: DsSpacing.xxs),
        Text(
          '${sentOnLabel(memory.lastSentAt)} · ${photoCountLabel(memory.photoCount)} · '
          '${eventCountLabel(memory.eventCount)}',
          style: DsTextStyles.caption,
        ),
        const SizedBox(height: DsSpacing.s),
        MemoryMonthMosaic(photoCount: memory.photoCount, photosOnPhone: memory.photosOnPhone),
      ],
    ),
  );
}
