part of 'package:dis_saucisse_desktop/core/router/routes.dart';

class StoragePageRoute extends GoRouteData with $StoragePageRoute {
  const StoragePageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => BlocProvider<StorageSettingsCubit>(
    create: (_) => StorageSettingsCubit()..load(),
    child: const StorageSettingsScreen(),
  );
}
