// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [$receptionPageRoute];

RouteBase get $receptionPageRoute => GoRouteData.$route(
  path: '/',
  name: 'reception',
  hasOverriddenOnExit: false,
  factory: $ReceptionPageRoute._fromState,
);

mixin $ReceptionPageRoute on GoRouteData {
  static ReceptionPageRoute _fromState(GoRouterState state) => const ReceptionPageRoute();

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
