part of 'package:dis_saucisse_mobile/core/router/routes.dart';

@TypedGoRoute<SortingStartPageRoute>(path: '/demarrage', name: 'sortingStart')
class SortingStartPageRoute extends GoRouteData with $SortingStartPageRoute {
  const SortingStartPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      BlocProvider<SortingStartCubit>(create: (_) => SortingStartCubit(), child: const SortingStartScreen());
}
