import 'dart:developer';

import 'package:core/core.dart';
import 'package:dis_saucisse_mobile/features/photo_library/data/data_sources/device_photo.dart';
import 'package:dis_saucisse_mobile/features/photo_library/data/data_sources/photo_library_data_source.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/photo_library_failure.dart';
import 'package:fpdart/fpdart.dart';
import 'package:photo_manager/photo_manager.dart';

class PhotoManagerDataSource implements PhotoLibraryDataSource {
  static const PermissionRequestOption _permissionOption = PermissionRequestOption(
    androidPermission: AndroidPermission(type: RequestType.image, mediaLocation: false),
  );

  @override
  TaskEither<AppFailure, PermissionState> permissionState() => TaskEither<AppFailure, PermissionState>.tryCatch(
    () => PhotoManager.getPermissionState(requestOption: _permissionOption),
    _failure,
  );

  @override
  TaskEither<AppFailure, PermissionState> requestPermission() => TaskEither<AppFailure, PermissionState>.tryCatch(
    () => PhotoManager.requestPermissionExtend(requestOption: _permissionOption),
    _failure,
  );

  @override
  TaskEither<AppFailure, Unit> openSettings() => TaskEither<AppFailure, Unit>.tryCatch(() async {
    await PhotoManager.openSetting();
    return unit;
  }, _failure);

  @override
  TaskEither<AppFailure, List<DevicePhoto>> loadPhotosCreatedSince(DateTime start) =>
      TaskEither<AppFailure, List<DevicePhoto>>.tryCatch(() async {
        final FilterOptionGroup filter = FilterOptionGroup(
          createTimeCond: DateTimeCond(min: start, max: DateTime.now()),
          orders: const <OrderOption>[OrderOption()],
        );
        final List<AssetPathEntity> allPhotos = await PhotoManager.getAssetPathList(
          type: RequestType.image,
          onlyAll: true,
          filterOption: filter,
        );
        final Set<String> messagingIds = await _messagingAlbumAssetIds(filter);
        final List<AssetEntity> assets = allPhotos.isEmpty ? <AssetEntity>[] : await _assetsOf(allPhotos.first);
        return assets
            .map(
              (AssetEntity asset) => DevicePhoto(
                id: asset.id,
                createdAt: asset.createDateTime,
                mediaSubtypes: asset.subtype,
                relativePath: asset.relativePath,
                isInMessagingAlbum: messagingIds.contains(asset.id),
              ),
            )
            .toList();
      }, _failure);

  Future<List<AssetEntity>> _assetsOf(AssetPathEntity path) async =>
      path.getAssetListRange(start: 0, end: await path.assetCountAsync);

  Future<Set<String>> _messagingAlbumAssetIds(FilterOptionGroup filter) async {
    final List<AssetPathEntity> albums = await PhotoManager.getAssetPathList(
      type: RequestType.image,
      hasAll: false,
      filterOption: filter,
    );
    final Iterable<AssetPathEntity> messagingAlbums = albums.where(
      (AssetPathEntity album) => album.name.toLowerCase().contains('whatsapp'),
    );
    final List<List<AssetEntity>> assets = await Future.wait(messagingAlbums.map(_assetsOf));
    return assets.expand((List<AssetEntity> album) => album).map((AssetEntity asset) => asset.id).toSet();
  }

  AppFailure _failure(Object error, StackTrace stackTrace) {
    log('Photo library unavailable', error: error, stackTrace: stackTrace, name: 'photo_library');
    return const PhotoLibraryUnavailableFailure();
  }
}
