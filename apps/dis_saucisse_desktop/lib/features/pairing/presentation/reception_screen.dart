import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_desktop/features/pairing/presentation/bloc/reception_cubit.dart';
import 'package:dis_saucisse_desktop/features/pairing/presentation/widgets/reception_failed_view.dart';
import 'package:dis_saucisse_desktop/features/pairing/presentation/widgets/reception_ready_view.dart';
import 'package:dis_saucisse_desktop/features/reception/presentation/widgets/reception_done_view.dart';
import 'package:dis_saucisse_desktop/features/reception/presentation/widgets/reception_progress_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReceptionScreen extends StatelessWidget {
  const ReceptionScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocBuilder<ReceptionCubit, ReceptionState>(
    builder: (BuildContext context, ReceptionState state) => switch (state) {
      ReceptionStarting() => const Center(child: CircularProgressIndicator(color: DsColors.mustard)),
      ReceptionFailed(:final problem) => ReceptionFailedView(problem: problem),
      final ReceptionReady ready => switch (ready.activity) {
        ReceptionIdle() => ReceptionReadyView(state: ready),
        final ReceptionInProgress progress => ReceptionProgressView(progress: progress),
        final ReceptionDone done => ReceptionDoneView(done: done),
      },
    },
  );
}
