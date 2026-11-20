part of 'package:dis_saucisse_mobile/core/router/routes.dart';

@TypedStatefulShellRoute<MainShellRoute>(
  branches: <TypedStatefulShellBranch<StatefulShellBranchData>>[
    TypedStatefulShellBranch<PhotosBranch>(
      routes: <TypedRoute<RouteData>>[TypedGoRoute<HomePageRoute>(path: '/', name: 'home')],
    ),
    TypedStatefulShellBranch<MemoriesBranch>(
      routes: <TypedRoute<RouteData>>[TypedGoRoute<MemoriesPageRoute>(path: '/souvenirs', name: 'memories')],
    ),
    TypedStatefulShellBranch<SettingsBranch>(
      routes: <TypedRoute<RouteData>>[TypedGoRoute<SettingsPageRoute>(path: '/reglages', name: 'settings')],
    ),
  ],
)
class MainShellRoute extends StatefulShellRouteData {
  const MainShellRoute();

  @override
  Widget builder(BuildContext context, GoRouterState state, StatefulNavigationShell navigationShell) =>
      MultiBlocProvider(
        providers: <BlocProvider<Object?>>[
          BlocProvider<HomeCubit>(create: (_) => HomeCubit()..load()),
          BlocProvider<PhotoQualityCubit>(create: (_) => PhotoQualityCubit()),
          BlocProvider<MemoriesCubit>(create: (_) => MemoriesCubit()),
          BlocProvider<SettingsCubit>(create: (_) => SettingsCubit()),
        ],
        child: MainShell(navigationShell: navigationShell),
      );
}

class PhotosBranch extends StatefulShellBranchData {
  const PhotosBranch();
}

class MemoriesBranch extends StatefulShellBranchData {
  const MemoriesBranch();
}

class SettingsBranch extends StatefulShellBranchData {
  const SettingsBranch();
}
