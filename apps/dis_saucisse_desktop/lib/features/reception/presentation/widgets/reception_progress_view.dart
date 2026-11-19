import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_desktop/features/pairing/presentation/bloc/reception_cubit.dart';
import 'package:dis_saucisse_desktop/features/reception/presentation/widgets/reception_count_card.dart';
import 'package:dis_saucisse_desktop/features/reception/presentation/widgets/reception_current_folder_card.dart';
import 'package:flutter/material.dart';

class ReceptionProgressView extends StatelessWidget {
  const ReceptionProgressView({super.key, required this.progress});

  final ReceptionInProgress progress;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(DsSpacing.xxl, DsSpacing.xxl, DsSpacing.xxl, DsSpacing.xl),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text('${progress.phoneName} envoie ses photos', style: DsTextStyles.caption.copyWith(fontSize: 13)),
        Text('Réception en cours', style: DsTextStyles.display),
        const SizedBox(height: DsSpacing.l),
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: DsSpacing.l,
            children: <Widget>[
              Expanded(child: ReceptionCountCard(progress: progress)),
              Expanded(child: ReceptionCurrentFolderCard(progress: progress)),
            ],
          ),
        ),
      ],
    ),
  );
}
