import 'package:dis_saucisse_mobile/core/router/routes.dart';
import 'package:dis_saucisse_mobile/features/home/presentation/bloc/home_cubit.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/entities/event_id.dart';
import 'package:dis_saucisse_mobile/features/photo_quality/domain/entities/quality_issue.dart';
import 'package:flutter/widgets.dart';
import 'package:fpdart/fpdart.dart';

Future<void> openBurstSort(BuildContext context, {required HomeCubit cubit, required Option<EventId> eventId}) async {
  await BurstSortPageRoute(eventId: eventId.map((EventId id) => id.value).toNullable()).push<void>(context);
  await cubit.load();
}

Future<void> openQualityReview(BuildContext context, {required HomeCubit cubit, required QualityIssue issue}) async {
  await QualityReviewPageRoute(issue: issue).push<void>(context);
  await cubit.load();
}
