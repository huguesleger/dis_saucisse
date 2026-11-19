part of 'package:dis_saucisse_desktop/core/router/routes.dart';

@TypedShellRoute<DesktopShellRoute>(
  routes: <TypedRoute<RouteData>>[
    TypedGoRoute<ReceptionPageRoute>(path: '/', name: 'reception'),
    TypedGoRoute<HistoryPageRoute>(path: '/historique', name: 'history'),
    TypedGoRoute<StoragePageRoute>(path: '/dossier', name: 'storage'),
  ],
)
class DesktopShellRoute extends ShellRouteData {
  const DesktopShellRoute();

  @override
  Widget builder(BuildContext context, GoRouterState state, Widget navigator) => BlocProvider<ReceptionCubit>(
    create: (_) => ReceptionCubit()..start(),
    child: DesktopShell(
      section: switch (state.uri.path) {
        '/historique' => DesktopSection.history,
        '/dossier' => DesktopSection.storage,
        _ => DesktopSection.reception,
      },
      onSelected: (DesktopSection section) => switch (section) {
        DesktopSection.reception => const ReceptionPageRoute().go(context),
        DesktopSection.history => const HistoryPageRoute().go(context),
        DesktopSection.storage => const StoragePageRoute().go(context),
      },
      child: navigator,
    ),
  );
}
