part of 'package:dis_saucisse_desktop/core/router/routes.dart';

@TypedGoRoute<ReceptionPageRoute>(path: '/', name: 'reception')
class ReceptionPageRoute extends GoRouteData with $ReceptionPageRoute {
  const ReceptionPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      BlocProvider<ReceptionCubit>(create: (_) => ReceptionCubit()..start(), child: const ReceptionScreen());
}
