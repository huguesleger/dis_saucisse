import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_mobile/core/i18n/translations.g.dart';
import 'package:dis_saucisse_mobile/core/presentation/widgets/failure_view.dart';
import 'package:dis_saucisse_mobile/features/memories/presentation/bloc/memories_cubit.dart';
import 'package:dis_saucisse_mobile/features/memories/presentation/memories_bone_mock.dart';
import 'package:dis_saucisse_mobile/features/memories/presentation/widgets/memories_loaded_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MemoriesScreen extends StatelessWidget {
  const MemoriesScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    body: DsMeshBackground(
      meshHeight: 340,
      child: BlocBuilder<MemoriesCubit, MemoriesState>(
        builder: (BuildContext context, MemoriesState state) => switch (state) {
          MemoriesLoading() => DsSkeletonizer(child: MemoriesLoadedView(state: memoriesBoneMock)),
          MemoriesFailed(:final failure) => FailureView(
            failure: failure,
            onRetry: context.read<MemoriesCubit>().load,
            placement: DsMessagePlacement.tab,
          ),
          MemoriesLoaded(months: <Object>[]) => DsRefresh(
            onRefresh: context.read<MemoriesCubit>().load,
            child: DsRefreshFillView(
              child: DsMessageView(
                title: t.memories.empty.title,
                message: t.memories.empty.message,
                placement: DsMessagePlacement.tab,
              ),
            ),
          ),
          final MemoriesLoaded loaded => MemoriesLoadedView(state: loaded),
        },
      ),
    ),
  );
}
