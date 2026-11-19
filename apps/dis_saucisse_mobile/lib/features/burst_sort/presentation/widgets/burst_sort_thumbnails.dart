import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_mobile/features/burst_sort/presentation/bloc/burst_sort_cubit.dart';
import 'package:dis_saucisse_mobile/features/burst_sort/presentation/widgets/burst_sort_thumbnail.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/library_photo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BurstSortThumbnails extends StatelessWidget {
  const BurstSortThumbnails({super.key, required this.state});

  final BurstSortInProgress state;

  @override
  Widget build(BuildContext context) => SizedBox(
    height: 56,
    child: ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: state.burst.photos.length,
      separatorBuilder: (BuildContext context, int index) => const SizedBox(width: DsSpacing.xs),
      itemBuilder: (BuildContext context, int index) {
        final LibraryPhoto photo = state.burst.photos[index];
        return BurstSortThumbnail(
          photoId: photo.id,
          decision: state.decisionOf(photo.id),
          selected: photo.id == state.cursor.photoId,
          onTap: () => context.read<BurstSortCubit>().showPhoto(photo.id),
        );
      },
    ),
  );
}
