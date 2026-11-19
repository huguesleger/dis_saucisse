import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_desktop/features/reception/domain/entities/received_event.dart';
import 'package:flutter/material.dart';

class ReceptionEventChip extends StatelessWidget {
  const ReceptionEventChip({super.key, required this.event});

  final ReceivedEvent event;

  @override
  Widget build(BuildContext context) => DecoratedBox(
    decoration: const BoxDecoration(color: DsColors.background, borderRadius: DsRadius.pillAll),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: DsSpacing.s, vertical: DsSpacing.xs),
      child: Text('${event.label} · ${event.count}', style: DsTextStyles.bodyBold.copyWith(fontSize: 13)),
    ),
  );
}
