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
  const StorageSettingsLoaded({required this.folderPath, required this.layout});

  final Option<String> folderPath;
  final StorageLayout layout;

  StorageSettingsLoaded copyWith({Option<String>? folderPath, StorageLayout? layout}) =>
      StorageSettingsLoaded(folderPath: folderPath ?? this.folderPath, layout: layout ?? this.layout);

  @override
  bool operator ==(Object other) =>
      other is StorageSettingsLoaded && other.folderPath == folderPath && other.layout == layout;

  @override
  int get hashCode => Object.hash(folderPath, layout);
}
