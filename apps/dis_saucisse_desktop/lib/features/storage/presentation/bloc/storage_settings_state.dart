part of 'storage_settings_cubit.dart';

@immutable
sealed class StorageSettingsState {
  const StorageSettingsState();
}

final class StorageSettingsLoading extends StorageSettingsState {
  const StorageSettingsLoading();
}

final class StorageSettingsFailed extends StorageSettingsState {
  const StorageSettingsFailed(this.failure);

  final AppFailure failure;
}

final class StorageSettingsLoaded extends StorageSettingsState {
  const StorageSettingsLoaded({required this.folderPath, required this.layout, required this.currentYear});

  final Option<String> folderPath;
  final StorageLayout layout;
  final int currentYear;

  StorageSettingsLoaded copyWith({Option<String>? folderPath, StorageLayout? layout}) => StorageSettingsLoaded(
    folderPath: folderPath ?? this.folderPath,
    layout: layout ?? this.layout,
    currentYear: currentYear,
  );

  @override
  bool operator ==(Object other) =>
      other is StorageSettingsLoaded &&
      other.folderPath == folderPath &&
      other.layout == layout &&
      other.currentYear == currentYear;

  @override
  int get hashCode => Object.hash(folderPath, layout, currentYear);
}
