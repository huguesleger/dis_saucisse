import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_desktop/features/pairing/presentation/bloc/reception_cubit.dart';
import 'package:dis_saucisse_desktop/features/pairing/presentation/widgets/paired_phones_card.dart';
import 'package:dis_saucisse_desktop/features/pairing/presentation/widgets/pairing_qr_card.dart';
import 'package:dis_saucisse_desktop/features/pairing/presentation/widgets/reception_header.dart';
import 'package:flutter/widgets.dart';

class ReceptionReadyView extends StatelessWidget {
  const ReceptionReadyView({super.key, required this.state});

  final ReceptionReady state;

  @override
  Widget build(BuildContext context) => ListView(
    padding: const EdgeInsets.all(DsSpacing.xxl),
    children: <Widget>[
      const ReceptionHeader(),
      const SizedBox(height: DsSpacing.xl),
      Wrap(
        spacing: DsSpacing.xl,
        runSpacing: DsSpacing.xl,
        children: <Widget>[
          SizedBox(
            width: 340,
            child: PairingQrCard(
              invitation: state.invitation,
              pairedPhoneName: state.phones.isEmpty ? null : state.phones.last.name,
            ),
          ),
          SizedBox(width: 340, child: PairedPhonesCard(phones: state.phones)),
        ],
      ),
    ],
  );
}
