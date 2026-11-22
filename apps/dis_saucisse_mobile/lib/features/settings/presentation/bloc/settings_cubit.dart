import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_mobile/config/setup_get_it.dart';
import 'package:dis_saucisse_mobile/features/pairing/domain/entities/paired_computer.dart';
import 'package:dis_saucisse_mobile/features/pairing/domain/pairing_repository.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/photo_origin.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/ignored_origins_repository.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/sorting_start_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';

part 'settings_state.dart';

class SettingsCubit extends SafeCubit<SettingsState> {
  SettingsCubit({
    PairingRepository? pairingRepository,
    SortingStartRepository? sortingStartRepository,
    IgnoredOriginsRepository? ignoredOriginsRepository,
    Duration? minimalLoading,
  }) : _pairingRepository = pairingRepository ?? getIt.get<PairingRepository>(),
       _sortingStartRepository = sortingStartRepository ?? getIt.get<SortingStartRepository>(),
       _ignoredOriginsRepository = ignoredOriginsRepository ?? getIt.get<IgnoredOriginsRepository>(),
       _minimalLoading = minimalLoading ?? DsLoader.minDuration,
       super(const SettingsLoading());

  final PairingRepository _pairingRepository;
  final SortingStartRepository _sortingStartRepository;
  final IgnoredOriginsRepository _ignoredOriginsRepository;
  final Duration _minimalLoading;

  Future<void> load() {
    if (state is SettingsFailed) emit(const SettingsLoading());
    final Duration minimalDelay = switch (state) {
      SettingsLoaded() => Duration.zero,
      SettingsLoading() || SettingsFailed() => _minimalLoading,
    };
    return TaskEither<AppFailure, SettingsState>.Do(($) async {
      final Option<PairedComputer> computer = await $(_pairingRepository.loadPairedComputer());
      final Option<DateTime> startDate = await $(_sortingStartRepository.loadStartDate());
      final Set<PhotoOrigin> ignoredOrigins = await $(_ignoredOriginsRepository.loadIgnoredOrigins());
      return SettingsLoaded(computer: computer, startDate: startDate, ignoredOrigins: ignoredOrigins);
    }).withMinimalDelay(minimalDelay).match(SettingsFailed.new, identity).map(emit).run();
  }

  Future<void> ignoreOrigin(PhotoOrigin origin, {required bool ignored}) => switch (state) {
    final SettingsLoaded loaded => _saveIgnoredOrigins(
      loaded,
      ignored ? <PhotoOrigin>{...loaded.ignoredOrigins, origin} : (loaded.ignoredOrigins.toSet()..remove(origin)),
    ),
    SettingsLoading() || SettingsFailed() => Future<void>.value(),
  };

  Future<void> changeStartDate(DateTime start) => switch (state) {
    final SettingsLoaded loaded =>
      _sortingStartRepository
          .saveStartDate(start)
          .match((AppFailure _) => loaded, (_) => loaded.copyWith(startDate: some(start)))
          .map(emit)
          .run(),
    SettingsLoading() || SettingsFailed() => Future<void>.value(),
  };

  Future<void> _saveIgnoredOrigins(SettingsLoaded loaded, Set<PhotoOrigin> origins) => _ignoredOriginsRepository
      .saveIgnoredOrigins(origins)
      .match((AppFailure _) => loaded, (_) => loaded.copyWith(ignoredOrigins: origins))
      .map(emit)
      .run();
}
