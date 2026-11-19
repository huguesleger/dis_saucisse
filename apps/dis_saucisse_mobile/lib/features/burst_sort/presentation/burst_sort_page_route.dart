part of 'package:dis_saucisse_mobile/core/router/routes.dart';

@TypedGoRoute<BurstSortPageRoute>(path: '/tri', name: 'burstSort')
class BurstSortPageRoute extends GoRouteData with $BurstSortPageRoute {
  const BurstSortPageRoute({this.eventId});

  final String? eventId;

  @override
  Widget build(BuildContext context, GoRouterState state) => BlocProvider<BurstSortCubit>(
    create: (_) => BurstSortCubit(eventId: Option<String>.fromNullable(eventId).map(EventId.new))..load(),
    child: const BurstSortScreen(),
  );
}
