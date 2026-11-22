import 'package:core/core.dart';

class PhotoLibraryUnavailableFailure extends AppFailure {
  const PhotoLibraryUnavailableFailure();
}

class SortingStartStorageFailure extends AppFailure {
  const SortingStartStorageFailure();
}

class IgnoredOriginsStorageFailure extends AppFailure {
  const IgnoredOriginsStorageFailure();
}

class PhotoAccessDeniedFailure extends AppFailure {
  const PhotoAccessDeniedFailure();
}
