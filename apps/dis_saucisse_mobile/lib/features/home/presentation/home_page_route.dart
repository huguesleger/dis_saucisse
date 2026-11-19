part of 'package:dis_saucisse_mobile/core/router/routes.dart';

@TypedGoRoute<HomePageRoute>(path: '/', name: 'home')
class HomePageRoute extends GoRouteData with $HomePageRoute {
  const HomePageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => MultiBlocProvider(
    providers: <BlocProvider<Object?>>[
      BlocProvider<HomeCubit>(create: (_) => HomeCubit()..load()),
      BlocProvider<PhotoQualityCubit>(create: (_) => PhotoQualityCubit()),
    ],
    child: const HomeScreen(),
  );
}
