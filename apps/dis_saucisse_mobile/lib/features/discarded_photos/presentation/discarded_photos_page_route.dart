part of 'package:dis_saucisse_mobile/core/router/routes.dart';

@TypedGoRoute<DiscardedPhotosPageRoute>(path: '/ecartees', name: 'discardedPhotos')
class DiscardedPhotosPageRoute extends GoRouteData with $DiscardedPhotosPageRoute {
  const DiscardedPhotosPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => BlocProvider<DiscardedPhotosCubit>(
    create: (_) => DiscardedPhotosCubit()..load(),
    child: const DiscardedPhotosScreen(),
  );
}
