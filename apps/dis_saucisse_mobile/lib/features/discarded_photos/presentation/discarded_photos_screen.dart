import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_mobile/core/i18n/translations.g.dart';
import 'package:dis_saucisse_mobile/core/presentation/widgets/failure_view.dart';
import 'package:dis_saucisse_mobile/features/discarded_photos/presentation/bloc/discarded_photos_cubit.dart';
import 'package:dis_saucisse_mobile/features/discarded_photos/presentation/discarded_photos_bone_mock.dart';
import 'package:dis_saucisse_mobile/features/discarded_photos/presentation/widgets/discarded_photos_ready_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DiscardedPhotosScreen extends StatelessWidget {
  const DiscardedPhotosScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    body: BlocBuilder<DiscardedPhotosCubit, DiscardedPhotosState>(
      builder: (BuildContext context, DiscardedPhotosState state) => switch (state) {
        DiscardedPhotosLoading() => DsSkeletonizer(child: DiscardedPhotosReadyView(state: discardedPhotosBoneMock)),
        DiscardedPhotosFailed(:final failure) => FailureView(
          failure: failure,
          onRetry: context.read<DiscardedPhotosCubit>().load,
          showBackButton: true,
        ),
        DiscardedPhotosReady(:final photos) when photos.isEmpty => DsMessageView(
          title: t.discarded.empty.title,
          message: t.discarded.empty.message,
          showBackButton: true,
        ),
        final DiscardedPhotosReady ready => DiscardedPhotosReadyView(state: ready),
        DiscardedPhotosRestored(:final int restoredCount) => DsMessageView(
          title: restoredCount == 1
              ? t.discarded.restored.titleSingle
              : t.discarded.restored.titleSeveral(count: restoredCount),
          message: t.discarded.restored.message,
          showBackButton: true,
        ),
      },
    ),
  );
}
