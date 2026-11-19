import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_desktop/features/pairing/domain/entities/paired_phone.dart';
import 'package:dis_saucisse_desktop/features/pairing/presentation/bloc/reception_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DesktopConnectionCards extends StatelessWidget {
  const DesktopConnectionCards({super.key});

  @override
  Widget build(BuildContext context) => BlocBuilder<ReceptionCubit, ReceptionState>(
    builder: (BuildContext context, ReceptionState state) => Column(
      spacing: DsSpacing.xs,
      children: <Widget>[
        switch (state) {
          ReceptionReady(phones: final List<PairedPhone> phones) when phones.isNotEmpty => DsConnectionCard(
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
        switch (state) {
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
      ],
    ),
  );
}
