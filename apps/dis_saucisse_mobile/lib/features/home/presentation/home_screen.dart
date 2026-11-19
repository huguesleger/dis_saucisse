import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_mobile/core/router/routes.dart';
import 'package:dis_saucisse_mobile/features/home/presentation/bloc/home_cubit.dart';
import 'package:dis_saucisse_mobile/features/home/presentation/widgets/home_loaded_view.dart';
import 'package:dis_saucisse_mobile/features/home/presentation/widgets/home_loading_view.dart';
import 'package:dis_saucisse_mobile/features/home/presentation/widgets/home_message_view.dart';
import 'package:dis_saucisse_mobile/features/photo_quality/presentation/bloc/photo_quality_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    body: DsMeshBackground(
      meshHeight: 340,
      child: BlocConsumer<HomeCubit, HomeState>(
        listenWhen: (HomeState previous, HomeState current) =>
            current is HomeNeedsSortingStart || (current is HomeLoaded && previous is! HomeLoaded),
        listener: (BuildContext context, HomeState state) => switch (state) {
          HomeNeedsSortingStart() => const SortingStartPageRoute().go(context),
          final HomeLoaded loaded => context.read<PhotoQualityCubit>().analyze(loaded.photosLeftToSort),
          HomeLoading() || HomeAccessDenied() || HomeFailed() => null,
        },
        builder: (BuildContext context, HomeState state) => switch (state) {
          HomeLoading() || HomeNeedsSortingStart() => const HomeLoadingView(),
          HomeAccessDenied() => HomeMessageView(
            title: "Je n'ai pas accès à tes photos",
            message: 'Autorise Dis Saucisse ! à lire tes photos dans les réglages, puis reviens ici.',
            primaryLabel: 'Ouvrir les réglages',
            onPrimary: context.read<HomeCubit>().openAccessSettings,
            secondaryLabel: "C'est fait, réessayer",
            onSecondary: context.read<HomeCubit>().load,
          ),
          HomeFailed() => HomeMessageView(
            title: 'Oups !',
            message: "Je n'ai pas réussi à lire tes photos.",
            primaryLabel: 'Réessayer',
            onPrimary: context.read<HomeCubit>().load,
          ),
          final HomeLoaded loaded => HomeLoadedView(state: loaded),
        },
      ),
    ),
  );
}
