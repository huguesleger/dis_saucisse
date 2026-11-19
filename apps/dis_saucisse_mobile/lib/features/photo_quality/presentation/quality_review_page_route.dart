part of 'package:dis_saucisse_mobile/core/router/routes.dart';

@TypedGoRoute<QualityReviewPageRoute>(path: '/qualite/:issue', name: 'qualityReview')
class QualityReviewPageRoute extends GoRouteData with $QualityReviewPageRoute {
  const QualityReviewPageRoute({required this.issue});

  final QualityIssue issue;

  @override
  Widget build(BuildContext context, GoRouterState state) => BlocProvider<QualityReviewCubit>(
    create: (_) => QualityReviewCubit(issue: issue)..load(),
    child: QualityReviewScreen(issue: issue),
  );
}
