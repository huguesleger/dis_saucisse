import 'package:dis_saucisse_mobile/core/database/app_database.dart';
import 'package:dis_saucisse_mobile/features/burst_sort/data/data_sources/drift_photo_decision_data_source.dart';
import 'package:dis_saucisse_mobile/features/burst_sort/data/data_sources/photo_decision_data_source.dart';
import 'package:dis_saucisse_mobile/features/burst_sort/data/repositories/photo_decision_repository_impl.dart';
import 'package:dis_saucisse_mobile/features/burst_sort/domain/photo_decision_repository.dart';
import 'package:dis_saucisse_mobile/features/pairing/data/data_sources/pairing_api_data_source.dart';
import 'package:dis_saucisse_mobile/features/pairing/data/data_sources/pairing_storage_data_source.dart';
import 'package:dis_saucisse_mobile/features/pairing/data/data_sources/qr_image_data_source.dart';
import 'package:dis_saucisse_mobile/features/pairing/data/repositories/pairing_repository_impl.dart';
import 'package:dis_saucisse_mobile/features/pairing/domain/pairing_repository.dart';
import 'package:dis_saucisse_mobile/features/photo_events/data/data_sources/event_boundary_data_source.dart';
import 'package:dis_saucisse_mobile/features/photo_events/data/data_sources/event_name_data_source.dart';
import 'package:dis_saucisse_mobile/features/photo_events/data/data_sources/shared_preferences_event_boundary_data_source.dart';
import 'package:dis_saucisse_mobile/features/photo_events/data/data_sources/shared_preferences_event_name_data_source.dart';
import 'package:dis_saucisse_mobile/features/photo_events/data/repositories/event_boundary_repository_impl.dart';
import 'package:dis_saucisse_mobile/features/photo_events/data/repositories/event_name_repository_impl.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/event_boundary_repository.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/event_name_repository.dart';
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
  ..registerLazySingleton<SortingStartRepository>(() => SortingStartRepositoryImpl(getIt.get()))
  ..registerLazySingleton<EventNameDataSource>(() => SharedPreferencesEventNameDataSource(SharedPreferencesAsync()))
  ..registerLazySingleton<EventNameRepository>(() => EventNameRepositoryImpl(getIt.get()))
  ..registerLazySingleton<EventBoundaryDataSource>(
    () => SharedPreferencesEventBoundaryDataSource(SharedPreferencesAsync()),
  )
  ..registerLazySingleton<EventBoundaryRepository>(() => EventBoundaryRepositoryImpl(getIt.get()))
  ..registerLazySingleton<AppDatabase>(AppDatabase.new)
  ..registerLazySingleton<PhotoDecisionDataSource>(() => DriftPhotoDecisionDataSource(getIt.get()))
  ..registerLazySingleton<PhotoDecisionRepository>(() => PhotoDecisionRepositoryImpl(getIt.get()))
  ..registerLazySingleton<PairingApiDataSource>(PairingApiDataSource.new)
  ..registerLazySingleton<PairingStorageDataSource>(() => PairingStorageDataSource(SharedPreferencesAsync()))
  ..registerLazySingleton<QrImageDataSource>(QrImageDataSource.new)
  ..registerLazySingleton<PairingRepository>(
    () => PairingRepositoryImpl(api: getIt.get(), storage: getIt.get(), qrImages: getIt.get()),
  );
