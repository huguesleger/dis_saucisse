import 'package:core/core.dart';
import 'package:dis_saucisse_desktop/features/history/domain/entities/transfer_record.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class HistoryRepository {
  TaskEither<AppFailure, List<TransferRecord>> loadHistory();

  TaskEither<AppFailure, Unit> saveTransfer(TransferRecord record);
}
