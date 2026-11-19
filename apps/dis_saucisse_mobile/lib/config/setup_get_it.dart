import 'package:dis_saucisse_mobile/features/photo_library/data/data_sources/photo_library_data_source.dart';
import 'package:dis_saucisse_mobile/features/photo_library/data/data_sources/photo_manager_data_source.dart';
import 'package:dis_saucisse_mobile/features/photo_library/data/data_sources/shared_preferences_sorting_start_data_source.dart';
import 'package:dis_saucisse_mobile/features/photo_library/data/data_sources/sorting_start_data_source.dart';
import 'package:dis_saucisse_mobile/features/photo_library/data/repositories/photo_library_repository_impl.dart';
import 'package:dis_saucisse_mobile/features/photo_library/data/repositories/sorting_start_repository_impl.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/photo_library_repository.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/sorting_start_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GetIt getIt = GetIt.instance;

void configureDependencies() => getIt
  ..registerLazySingleton<PhotoLibraryDataSource>(PhotoManagerDataSource.new)
  ..registerLazySingleton<SortingStartDataSource>(
    () => SharedPreferencesSortingStartDataSource(SharedPreferencesAsync()),
  )
  ..registerLazySingleton<PhotoLibraryRepository>(() => PhotoLibraryRepositoryImpl(getIt.get()))
  ..registerLazySingleton<SortingStartRepository>(() => SortingStartRepositoryImpl(getIt.get()));
