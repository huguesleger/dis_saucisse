part of 'package:dis_saucisse_desktop/core/router/routes.dart';

class HistoryPageRoute extends GoRouteData with $HistoryPageRoute {
  const HistoryPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      BlocProvider<HistoryCubit>(create: (_) => HistoryCubit()..load(), child: const HistoryScreen());
}
