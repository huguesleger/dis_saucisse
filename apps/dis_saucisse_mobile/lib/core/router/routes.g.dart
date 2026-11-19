// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
  $burstSortPageRoute,
  $freeSpacePageRoute,
  $homePageRoute,
  $pairComputerPageRoute,
  $sortingStartPageRoute,
  $qualityReviewPageRoute,
  $transferPageRoute,
];

RouteBase get $burstSortPageRoute => GoRouteData.$route(
  path: '/tri',
  name: 'burstSort',
  hasOverriddenOnExit: false,
  factory: $BurstSortPageRoute._fromState,
);

mixin $BurstSortPageRoute on GoRouteData {
  static BurstSortPageRoute _fromState(GoRouterState state) =>
      BurstSortPageRoute(eventId: state.uri.queryParameters['event-id']);

  BurstSortPageRoute get _self => this as BurstSortPageRoute;

  @override
  String get location => GoRouteData.$location(
    '/tri',
    queryParams: {if (_self.eventId != null) 'event-id': _self.eventId},
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) => context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $freeSpacePageRoute => GoRouteData.$route(
  path: '/liberer',
  name: 'freeSpace',
  hasOverriddenOnExit: false,
  factory: $FreeSpacePageRoute._fromState,
);

mixin $FreeSpacePageRoute on GoRouteData {
  static FreeSpacePageRoute _fromState(GoRouterState state) => const FreeSpacePageRoute();

  @override
  String get location => GoRouteData.$location('/liberer');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) => context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $homePageRoute => GoRouteData.$route(
  path: '/',
  name: 'home',
  hasOverriddenOnExit: false,
  factory: $HomePageRoute._fromState,
);

mixin $HomePageRoute on GoRouteData {
  static HomePageRoute _fromState(GoRouterState state) => const HomePageRoute();

  @override
  String get location => GoRouteData.$location('/');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) => context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $pairComputerPageRoute => GoRouteData.$route(
  path: '/associer',
  name: 'pairComputer',
  hasOverriddenOnExit: false,
  factory: $PairComputerPageRoute._fromState,
);

mixin $PairComputerPageRoute on GoRouteData {
  static PairComputerPageRoute _fromState(GoRouterState state) => const PairComputerPageRoute();

  @override
  String get location => GoRouteData.$location('/associer');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) => context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $sortingStartPageRoute => GoRouteData.$route(
  path: '/demarrage',
  name: 'sortingStart',
  hasOverriddenOnExit: false,
  factory: $SortingStartPageRoute._fromState,
);

mixin $SortingStartPageRoute on GoRouteData {
  static SortingStartPageRoute _fromState(GoRouterState state) => const SortingStartPageRoute();

  @override
  String get location => GoRouteData.$location('/demarrage');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) => context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $qualityReviewPageRoute => GoRouteData.$route(
  path: '/qualite/:issue',
  name: 'qualityReview',
  hasOverriddenOnExit: false,
  factory: $QualityReviewPageRoute._fromState,
);

mixin $QualityReviewPageRoute on GoRouteData {
  static QualityReviewPageRoute _fromState(GoRouterState state) => QualityReviewPageRoute(
    issue: _$QualityIssueEnumMap._$fromName(
      state.pathParameters['issue']!,
    )!,
  );

  QualityReviewPageRoute get _self => this as QualityReviewPageRoute;

  @override
  String get location => GoRouteData.$location(
    '/qualite/${Uri.encodeComponent(_$QualityIssueEnumMap[_self.issue]!)}',
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) => context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

const _$QualityIssueEnumMap = {
  QualityIssue.duplicates: 'duplicates',
  QualityIssue.blurry: 'blurry',
};

extension<T extends Enum> on Map<T, String> {
  T? _$fromName(String? value) => entries.where((element) => element.value == value).firstOrNull?.key;
}

RouteBase get $transferPageRoute => GoRouteData.$route(
  path: '/envoi',
  name: 'transfer',
  hasOverriddenOnExit: false,
  factory: $TransferPageRoute._fromState,
);

mixin $TransferPageRoute on GoRouteData {
  static TransferPageRoute _fromState(GoRouterState state) => const TransferPageRoute();

  @override
  String get location => GoRouteData.$location('/envoi');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) => context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}
