part of 'package:dis_saucisse_mobile/core/router/routes.dart';

@TypedGoRoute<TransferPageRoute>(path: '/envoi', name: 'transfer')
class TransferPageRoute extends GoRouteData with $TransferPageRoute {
  const TransferPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      BlocProvider<TransferCubit>(create: (_) => TransferCubit()..start(), child: const TransferScreen());
}
