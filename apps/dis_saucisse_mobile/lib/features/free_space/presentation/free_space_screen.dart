import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_mobile/core/presentation/widgets/failure_view.dart';
import 'package:dis_saucisse_mobile/features/free_space/presentation/bloc/free_space_cubit.dart';
import 'package:dis_saucisse_mobile/features/free_space/presentation/widgets/free_space_ready_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FreeSpaceScreen extends StatelessWidget {
  const FreeSpaceScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    body: BlocBuilder<FreeSpaceCubit, FreeSpaceState>(
      builder: (BuildContext context, FreeSpaceState state) => switch (state) {
        FreeSpaceLoading() || FreeSpaceDeleting() => const Center(child: DsLoader()),
        FreeSpaceNothingToFree() => const DsMessageView(
          title: 'Rien à libérer',
          message: 'Envoie d’abord des photos sur ton ordinateur : tu pourras ensuite faire de la place.',
          showBackButton: true,
        ),
        FreeSpaceFailed(:final failure) => FailureView(
          failure: failure,
          onRetry: context.read<FreeSpaceCubit>().load,
          showBackButton: true,
        ),
        FreeSpaceDone(:final int deletedCount, :final int freedBytes) => DsMessageView(
          title: '${byteSizeLabel(freedBytes)} libérés !',
          message:
              '$deletedCount photos sont dans la corbeille du téléphone. Elles restent rangées sur ton ordinateur.',
          showBackButton: true,
        ),
        final FreeSpaceReady ready => FreeSpaceReadyView(state: ready),
      },
    ),
  );
}
