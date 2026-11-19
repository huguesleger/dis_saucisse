import 'package:core/core.dart';
import 'package:dis_saucisse_desktop/features/history/data/data_sources/history_data_source.dart';
import 'package:dis_saucisse_desktop/features/history/data/mappers/transfer_record_mapper.dart';
import 'package:dis_saucisse_desktop/features/history/domain/entities/transfer_record.dart';
import 'package:dis_saucisse_desktop/features/history/domain/history_repository.dart';
import 'package:fpdart/fpdart.dart';

class HistoryRepositoryImpl implements HistoryRepository {
  HistoryRepositoryImpl(this._dataSource);

  final HistoryDataSource _dataSource;

  @override
  TaskEither<AppFailure, List<TransferRecord>> loadHistory() => _dataSource.loadRecords().map(
    (List<Map<String, Object?>> records) => records
        .map(jsonToTransferRecord)
        .whereType<Some<TransferRecord>>()
        .map((Some<TransferRecord> r) => r.value)
        .toList(),
  );

  @override
  TaskEither<AppFailure, Unit> saveTransfer(TransferRecord record) =>
      _dataSource.addRecord(transferRecordToJson(record));
}
