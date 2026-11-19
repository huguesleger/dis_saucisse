import 'package:dis_saucisse_mobile/features/photo_events/domain/entities/event_library.dart';
import 'package:flutter/foundation.dart';

@immutable
sealed class EventLibraryLoad {
  const EventLibraryLoad();
}

final class EventLibraryNeedsSortingStart extends EventLibraryLoad {
  const EventLibraryNeedsSortingStart();
}

final class EventLibraryAccessDenied extends EventLibraryLoad {
  const EventLibraryAccessDenied();
}

final class EventLibraryLoaded extends EventLibraryLoad {
  const EventLibraryLoaded(this.library);

  final EventLibrary library;
}
