part of 'package:dis_saucisse_mobile/core/router/routes.dart';

@TypedGoRoute<FreeSpacePageRoute>(path: '/liberer', name: 'freeSpace')
class FreeSpacePageRoute extends GoRouteData with $FreeSpacePageRoute {
  const FreeSpacePageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      BlocProvider<FreeSpaceCubit>(create: (_) => FreeSpaceCubit()..load(), child: const FreeSpaceScreen());
}
