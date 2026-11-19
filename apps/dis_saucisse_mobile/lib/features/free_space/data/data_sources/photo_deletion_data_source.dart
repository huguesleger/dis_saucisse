import 'dart:developer';
import 'dart:io';

import 'package:core/core.dart';
import 'package:dis_saucisse_mobile/features/free_space/domain/free_space_failure.dart';
import 'package:fpdart/fpdart.dart';
import 'package:photo_manager/photo_manager.dart';

class PhotoDeletionDataSource {
  TaskEither<AppFailure, List<String>> moveToTrash(List<String> photoIds) =>
      Platform.isAndroid ? _androidTrash(photoIds).orElse((_) => _delete(photoIds)) : _delete(photoIds);

  TaskEither<AppFailure, List<String>> _androidTrash(List<String> photoIds) =>
      TaskEither<AppFailure, List<String>>.tryCatch(() async {
        final List<AssetEntity> assets = (await Future.wait(photoIds.map(AssetEntity.fromId))).nonNulls.toList();
        return PhotoManager.editor.android.moveToTrash(assets);
      }, _failure);

  TaskEither<AppFailure, List<String>> _delete(List<String> photoIds) =>
      TaskEither<AppFailure, List<String>>.tryCatch(() => PhotoManager.editor.deleteWithIds(photoIds), _failure);

  AppFailure _failure(Object error, StackTrace stackTrace) {
    log('Photos not deleted', error: error, stackTrace: stackTrace, name: 'free_space');
    return const PhotoDeletionFailure();
  }
}
