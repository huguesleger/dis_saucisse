import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_mobile/features/memories/presentation/bloc/memories_cubit.dart';
import 'package:dis_saucisse_mobile/features/memories/presentation/widgets/memories_loaded_view.dart';
import 'package:dis_saucisse_mobile/features/memories/presentation/widgets/memories_loading_view.dart';
import 'package:dis_saucisse_mobile/features/memories/presentation/widgets/memories_message_view.dart';
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
          MemoriesLoading() => const MemoriesLoadingView(),
          MemoriesFailed() => MemoriesMessageView(
            title: 'Oups !',
            message: "Je n'ai pas réussi à retrouver tes souvenirs.",
            actionLabel: 'Réessayer',
            onAction: context.read<MemoriesCubit>().load,
          ),
          MemoriesLoaded(months: <Object>[]) => const MemoriesMessageView(
            title: 'Pas encore de souvenirs',
            message: 'Envoie tes premières photos sur le PC : elles apparaîtront ici, rangées par mois.',
          ),
          final MemoriesLoaded loaded => MemoriesLoadedView(state: loaded),
        },
      ),
    ),
  );
}
