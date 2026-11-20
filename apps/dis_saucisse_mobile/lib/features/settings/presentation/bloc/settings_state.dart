part of 'settings_cubit.dart';

@immutable
sealed class SettingsState {
  const SettingsState();
}

final class SettingsLoading extends SettingsState {
  const SettingsLoading();
}

final class SettingsFailed extends SettingsState {
  const SettingsFailed();
}

final class SettingsLoaded extends SettingsState {
  const SettingsLoaded({required this.computer, required this.startDate, required this.ignoredOrigins});

  final Option<PairedComputer> computer;
  final Option<DateTime> startDate;
  final Set<PhotoOrigin> ignoredOrigins;

  SettingsLoaded copyWith({Option<DateTime>? startDate, Set<PhotoOrigin>? ignoredOrigins}) => SettingsLoaded(
    computer: computer,
    startDate: startDate ?? this.startDate,
    ignoredOrigins: ignoredOrigins ?? this.ignoredOrigins,
  );
}
