// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
  $burstSortPageRoute,
  $homePageRoute,
  $sortingStartPageRoute,
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
