import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_mobile/features/free_space/presentation/bloc/free_space_cubit.dart';
import 'package:dis_saucisse_mobile/features/free_space/presentation/widgets/free_space_message_view.dart';
import 'package:dis_saucisse_mobile/features/free_space/presentation/widgets/free_space_ready_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FreeSpaceScreen extends StatelessWidget {
  const FreeSpaceScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    body: BlocBuilder<FreeSpaceCubit, FreeSpaceState>(
      builder: (BuildContext context, FreeSpaceState state) => switch (state) {
        FreeSpaceLoading() || FreeSpaceDeleting() => const Center(
          child: CircularProgressIndicator(color: DsColors.mustard),
        ),
        FreeSpaceNothingToFree() => const FreeSpaceMessageView(
          title: 'Rien à libérer',
          message: 'Envoie d’abord des photos sur ton ordinateur : tu pourras ensuite faire de la place.',
        ),
        FreeSpaceFailed() => const FreeSpaceMessageView(
          title: 'Rien n’a été supprimé',
          message: 'La suppression a été annulée ou n’a pas abouti. Tes photos sont toujours là.',
        ),
        FreeSpaceDone(:final int deletedCount, :final int freedBytes) => FreeSpaceMessageView(
          title: '${byteSizeLabel(freedBytes)} libérés !',
          message:
              '$deletedCount photos sont dans la corbeille du téléphone. Elles restent rangées sur ton ordinateur.',
        ),
        final FreeSpaceReady ready => FreeSpaceReadyView(state: ready),
      },
    ),
  );
}
