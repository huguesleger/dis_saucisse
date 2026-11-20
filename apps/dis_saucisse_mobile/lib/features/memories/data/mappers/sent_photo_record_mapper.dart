import 'package:dis_saucisse_mobile/core/database/app_database.dart';
import 'package:dis_saucisse_mobile/features/memories/domain/entities/sent_photo_record.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/photo_id.dart';

SentPhotoRecord photoTransferRowToSentPhotoRecord(PhotoTransferRow row) =>
    SentPhotoRecord(photoId: PhotoId(row.photoId), sentAt: row.sentAt, byteCount: row.byteCount);
