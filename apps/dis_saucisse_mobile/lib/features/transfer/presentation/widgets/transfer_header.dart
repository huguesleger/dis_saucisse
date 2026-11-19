import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_mobile/features/transfer/domain/entities/transfer_progress.dart';
import 'package:dis_saucisse_mobile/features/transfer/presentation/remaining_time_label.dart';
import 'package:flutter/widgets.dart';

class TransferHeader extends StatelessWidget {
  const TransferHeader({super.key, required this.progress, required this.now});

  final TransferProgress progress;
  final DateTime now;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: DsSpacing.xl),
    child: Column(
      spacing: DsSpacing.s,
      children: <Widget>[
        Text('Envoi vers ${progress.computer.name}', style: DsTextStyles.bodyBold),
        const DsMascot(width: 150),
        Text('${progress.sent} / ${progress.total}', style: DsTextStyles.number),
        Text(
          'photos envoyées · ${remainingTimeLabel(progress.remainingTime(now))}',
          style: DsTextStyles.caption.copyWith(fontSize: 13),
        ),
        DsProgressBar(value: progress.total == 0 ? 0 : progress.sent / progress.total),
      ],
    ),
  );
}
