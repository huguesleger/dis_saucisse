import 'package:core/core.dart';
import 'package:dis_saucisse_mobile/core/database/app_database.dart';
import 'package:dis_saucisse_mobile/features/burst_sort/data/data_sources/photo_decision_data_source.dart';
import 'package:dis_saucisse_mobile/features/burst_sort/data/mappers/photo_decision_mapper.dart';
import 'package:dis_saucisse_mobile/features/burst_sort/domain/entities/photo_decision.dart';
import 'package:dis_saucisse_mobile/features/burst_sort/domain/photo_decision_repository.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/photo_id.dart';
import 'package:fpdart/fpdart.dart';

class PhotoDecisionRepositoryImpl implements PhotoDecisionRepository {
  PhotoDecisionRepositoryImpl(this._dataSource, {DateTime Function()? clock}) : _clock = clock ?? DateTime.now;

  final PhotoDecisionDataSource _dataSource;
  final DateTime Function() _clock;

  @override
  TaskEither<AppFailure, Map<PhotoId, PhotoDecision>> loadDecisions() =>
      _dataSource.loadDecisions().map((List<PhotoDecisionRow> rows) => rowsToPhotoDecisions(rows));

  @override
  TaskEither<AppFailure, Unit> saveDecision(PhotoId photo, PhotoDecision decision) =>
      _dataSource.saveDecision(photoDecisionToRow(photo, decision, _clock()));
}
