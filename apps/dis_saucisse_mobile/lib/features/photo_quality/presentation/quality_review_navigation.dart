import 'package:dis_saucisse_mobile/features/photo_quality/domain/entities/quality_group.dart';
import 'package:dis_saucisse_mobile/features/photo_quality/domain/entities/quality_issue.dart';
import 'package:dis_saucisse_mobile/features/photo_quality/presentation/bloc/quality_review_cubit.dart';
import 'package:dis_saucisse_mobile/features/photo_quality/presentation/widgets/quality_photo_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> openQualityPhoto(
  BuildContext context, {
  required QualityReviewCubit cubit,
  required QualityIssue issue,
  required QualityGroup group,
  required int index,
}) => Navigator.of(context, rootNavigator: true).push<void>(
  MaterialPageRoute<void>(
    fullscreenDialog: true,
    builder: (BuildContext context) => BlocProvider<QualityReviewCubit>.value(
      value: cubit,
      child: QualityPhotoViewer(issue: issue, group: group, initialIndex: index),
    ),
  ),
);
