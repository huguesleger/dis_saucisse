// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [$desktopShellRoute];

RouteBase get $desktopShellRoute => ShellRouteData.$route(
  factory: $DesktopShellRouteExtension._fromState,
  routes: [
    GoRouteData.$route(
      path: '/',
      name: 'reception',
      hasOverriddenOnExit: false,
      factory: $ReceptionPageRoute._fromState,
    ),
    GoRouteData.$route(
      path: '/historique',
      name: 'history',
      hasOverriddenOnExit: false,
      factory: $HistoryPageRoute._fromState,
    ),
    GoRouteData.$route(
      path: '/dossier',
      name: 'storage',
      hasOverriddenOnExit: false,
      factory: $StoragePageRoute._fromState,
    ),
  ],
);

extension $DesktopShellRouteExtension on DesktopShellRoute {
  static DesktopShellRoute _fromState(GoRouterState state) => const DesktopShellRoute();
}

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

mixin $HistoryPageRoute on GoRouteData {
  static HistoryPageRoute _fromState(GoRouterState state) => const HistoryPageRoute();

  @override
  String get location => GoRouteData.$location('/historique');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) => context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $StoragePageRoute on GoRouteData {
  static StoragePageRoute _fromState(GoRouterState state) => const StoragePageRoute();

  @override
  String get location => GoRouteData.$location('/dossier');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) => context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}
