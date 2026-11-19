import 'package:dis_saucisse_desktop/features/pairing/data/data_sources/computer_advertiser_data_source.dart';
import 'package:dis_saucisse_desktop/features/pairing/data/data_sources/local_network_data_source.dart';
import 'package:dis_saucisse_desktop/features/pairing/data/data_sources/pairing_storage_data_source.dart';
import 'package:dis_saucisse_desktop/features/pairing/data/data_sources/reception_server_data_source.dart';
import 'package:dis_saucisse_desktop/features/pairing/data/data_sources/shared_preferences_pairing_storage_data_source.dart';
import 'package:dis_saucisse_desktop/features/pairing/data/repositories/pairing_repository_impl.dart';
import 'package:dis_saucisse_desktop/features/pairing/domain/pairing_repository.dart';
import 'package:dis_saucisse_desktop/features/reception/data/data_sources/photo_storage_data_source.dart';
import 'package:dis_saucisse_desktop/features/reception/data/repositories/reception_repository_impl.dart';
import 'package:dis_saucisse_desktop/features/reception/domain/reception_repository.dart';
import 'package:dis_saucisse_desktop/features/history/data/data_sources/history_data_source.dart';
import 'package:dis_saucisse_desktop/features/history/data/repositories/history_repository_impl.dart';
import 'package:dis_saucisse_desktop/features/history/domain/history_repository.dart';
import 'package:dis_saucisse_desktop/features/storage/data/data_sources/storage_settings_data_source.dart';
import 'package:dis_saucisse_desktop/features/storage/data/repositories/storage_settings_repository_impl.dart';
import 'package:dis_saucisse_desktop/features/storage/domain/storage_settings_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GetIt getIt = GetIt.instance;

void configureDependencies() => getIt
  ..registerLazySingleton<PairingStorageDataSource>(
    () => SharedPreferencesPairingStorageDataSource(SharedPreferencesAsync()),
  )
  ..registerLazySingleton<LocalNetworkDataSource>(LocalNetworkDataSource.new)
  ..registerLazySingleton<ComputerAdvertiserDataSource>(ComputerAdvertiserDataSource.new)
  ..registerLazySingleton<StorageSettingsDataSource>(() => StorageSettingsDataSource(SharedPreferencesAsync()))
  ..registerLazySingleton<PhotoStorageDataSource>(
    () => PhotoStorageDataSource(getIt.get<StorageSettingsDataSource>().currentTarget),
  )
  ..registerLazySingleton<ReceptionServerDataSource>(() => ReceptionServerDataSource(getIt.get()))
  ..registerLazySingleton<PairingRepository>(
    () => PairingRepositoryImpl(
      storage: getIt.get(),
      network: getIt.get(),
      server: getIt.get(),
      advertiser: getIt.get(),
    ),
  )
  ..registerLazySingleton<ReceptionRepository>(() => ReceptionRepositoryImpl(getIt.get()))
  ..registerLazySingleton<HistoryDataSource>(() => HistoryDataSource(SharedPreferencesAsync()))
  ..registerLazySingleton<HistoryRepository>(() => HistoryRepositoryImpl(getIt.get()))
  ..registerLazySingleton<StorageSettingsRepository>(() => StorageSettingsRepositoryImpl(getIt.get()));
