import 'package:core/core.dart';
import 'package:dis_saucisse_mobile/features/memories/domain/entities/sent_photo_record.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class MemoriesRepository {
  TaskEither<AppFailure, List<SentPhotoRecord>> loadSentPhotos();
}
