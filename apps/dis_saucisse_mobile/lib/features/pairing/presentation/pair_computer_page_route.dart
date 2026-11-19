part of 'package:dis_saucisse_mobile/core/router/routes.dart';

@TypedGoRoute<PairComputerPageRoute>(path: '/associer', name: 'pairComputer')
class PairComputerPageRoute extends GoRouteData with $PairComputerPageRoute {
  const PairComputerPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      BlocProvider<PairComputerCubit>(create: (_) => PairComputerCubit(), child: const PairComputerScreen());
}
