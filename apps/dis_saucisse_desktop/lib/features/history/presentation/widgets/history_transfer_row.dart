import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_desktop/core/i18n/translations.g.dart';
import 'package:dis_saucisse_desktop/features/history/domain/entities/transfer_record.dart';
import 'package:dis_saucisse_desktop/features/history/presentation/history_dates.dart';
import 'package:flutter/material.dart';

class HistoryTransferRow extends StatelessWidget {
  const HistoryTransferRow({super.key, required this.record, required this.onOpen});

  final TransferRecord record;
  final VoidCallback onOpen;

  @override
  Widget build(BuildContext context) => DsSettingsTile(
    icon: Icons.photo_library_outlined,
    iconBackground: DsColors.mustardLight,
    title: historyDate(record.receivedAt),
    subtitle: t.history.transferRow.summary(
      photoCount: record.photoCount,
      eventCount: record.eventCount,
      size: byteSizeLabel(record.byteCount),
      phoneName: record.phoneName,
    ),
    trailing: Row(
      mainAxisSize: MainAxisSize.min,
      spacing: DsSpacing.s,
      children: <Widget>[
        record.rejectedCount == 0
            ? DsStatusBadge(label: t.history.transferRow.allVerified)
            : DsStatusBadge(
                label: t.history.transferRow.failed(count: record.rejectedCount),
                tone: DsStatusTone.alert,
              ),
        TextButton(
          onPressed: onOpen,
          child: Text(t.history.transferRow.open, style: DsTextStyles.bodyBold.copyWith(color: DsColors.sausage)),
        ),
      ],
    ),
  );
}
