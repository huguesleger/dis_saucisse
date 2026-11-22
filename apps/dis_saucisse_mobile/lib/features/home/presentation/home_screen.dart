import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_mobile/core/presentation/widgets/failure_view.dart';
import 'package:dis_saucisse_mobile/core/router/routes.dart';
import 'package:dis_saucisse_mobile/features/home/presentation/bloc/home_cubit.dart';
import 'package:dis_saucisse_mobile/features/home/presentation/home_bone_mock.dart';
import 'package:dis_saucisse_mobile/features/home/presentation/widgets/home_loaded_view.dart';
import 'package:dis_saucisse_mobile/features/photo_quality/presentation/bloc/photo_quality_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dis_saucisse_mobile/core/i18n/translations.g.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    body: DsMeshBackground(
      meshHeight: 340,
      child: BlocConsumer<HomeCubit, HomeState>(
        listenWhen: (HomeState previous, HomeState current) =>
            current is HomeNeedsSortingStart ||
            (current is HomeLoaded && (previous is! HomeLoaded || previous.library.photos != current.library.photos)),
        listener: (BuildContext context, HomeState state) => switch (state) {
          HomeNeedsSortingStart() => const SortingStartPageRoute().go(context),
          final HomeLoaded loaded => context.read<PhotoQualityCubit>().analyze(loaded.photosLeftToSort),
          HomeLoading() || HomeAccessDenied() || HomeFailed() => null,
        },
        builder: (BuildContext context, HomeState state) => switch (state) {
          HomeLoading() || HomeNeedsSortingStart() => DsSkeletonizer(child: HomeLoadedView(state: homeBoneMock)),
          HomeAccessDenied() => DsMessageView(
            title: t.home.accessDenied.title,
            message: t.home.accessDenied.message,
            placement: DsMessagePlacement.tab,
            primaryAction: DsMessageAction(
              label: t.home.accessDenied.openSettings,
              onPressed: context.read<HomeCubit>().openAccessSettings,
            ),
            secondaryAction: DsMessageAction(
              label: t.home.accessDenied.retry,
              onPressed: context.read<HomeCubit>().load,
            ),
          ),
          HomeFailed(:final failure) => FailureView(
            failure: failure,
            onRetry: context.read<HomeCubit>().load,
            placement: DsMessagePlacement.tab,
          ),
          final HomeLoaded loaded => HomeLoadedView(state: loaded),
        },
      ),
    ),
  );
}
