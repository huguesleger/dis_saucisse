import 'package:dis_saucisse_desktop/features/storage/domain/entities/storage_layout.dart';
import 'package:dis_saucisse_desktop/features/storage/presentation/bloc/storage_settings_cubit.dart';
import 'package:fpdart/fpdart.dart';

final StorageSettingsLoaded storageSettingsBoneMock = StorageSettingsLoaded(
  folderPath: some('/Users/vous/Images/Dis Saucisse'),
  layout: StorageLayout.defaults,
  currentYear: 2026,
);
