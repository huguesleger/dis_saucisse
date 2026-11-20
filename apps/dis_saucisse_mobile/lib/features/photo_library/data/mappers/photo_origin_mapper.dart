import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/photo_origin.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/rules/photos_to_sort.dart';

Set<PhotoOrigin> namesToPhotoOrigins(List<String>? names) => names == null
    ? defaultIgnoredOrigins
    : PhotoOrigin.values.where((PhotoOrigin origin) => names.contains(origin.name)).toSet();

List<String> photoOriginsToNames(Set<PhotoOrigin> origins) =>
    PhotoOrigin.values.where(origins.contains).map((PhotoOrigin origin) => origin.name).toList();
