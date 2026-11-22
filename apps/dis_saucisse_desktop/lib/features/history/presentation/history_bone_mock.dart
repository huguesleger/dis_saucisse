import 'package:dis_saucisse_desktop/features/history/domain/entities/transfer_record.dart';
import 'package:dis_saucisse_desktop/features/history/presentation/bloc/history_cubit.dart';

final HistoryLoaded historyBoneMock = HistoryLoaded(
  records: <TransferRecord>[
    for (int index = 0; index < 4; index++)
      TransferRecord(
        receivedAt: DateTime(2026, 11, 20 - index * 4, 19),
        phoneName: 'Téléphone',
        photoCount: 42,
        rejectedCount: 0,
        byteCount: 120000000,
        eventCount: 3,
      ),
  ],
  selectedYear: 2026,
);
