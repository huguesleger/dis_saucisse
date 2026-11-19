import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_desktop/core/presentation/widgets/desktop_shell.dart';
import 'package:dis_saucisse_desktop/core/presentation/widgets/desktop_sidebar.dart';
import 'package:dis_saucisse_desktop/features/pairing/presentation/bloc/reception_cubit.dart';
import 'package:dis_saucisse_desktop/features/pairing/presentation/widgets/reception_failed_view.dart';
import 'package:dis_saucisse_desktop/features/pairing/presentation/widgets/reception_ready_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReceptionScreen extends StatelessWidget {
  const ReceptionScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocBuilder<ReceptionCubit, ReceptionState>(
    builder: (BuildContext context, ReceptionState state) => DesktopShell(
      sidebar: DesktopSidebar(
        phoneStatus: switch (state) {
          ReceptionReady(phones: final phones) when phones.isNotEmpty => DsConnectionCard(
            icon: Icons.smartphone_rounded,
            title: phones.last.name,
            status: 'Associé',
          ),
          ReceptionReady() || ReceptionStarting() || ReceptionFailed() => const DsConnectionCard(
            icon: Icons.smartphone_rounded,
            title: 'Téléphone',
            status: 'Pas encore associé',
            connected: false,
          ),
        },
        networkStatus: switch (state) {
          ReceptionReady(:final invitation) => DsConnectionCard(
            icon: Icons.wifi_rounded,
            title: 'Réseau Wi-Fi',
            status: invitation.host,
          ),
          ReceptionStarting() || ReceptionFailed() => const DsConnectionCard(
            icon: Icons.wifi_off_rounded,
            title: 'Réseau Wi-Fi',
            status: 'Hors ligne',
            connected: false,
          ),
        },
      ),
      child: switch (state) {
        ReceptionStarting() => const Center(child: CircularProgressIndicator(color: DsColors.mustard)),
        ReceptionFailed(:final problem) => ReceptionFailedView(problem: problem),
        final ReceptionReady ready => ReceptionReadyView(state: ready),
      },
    ),
  );
}
