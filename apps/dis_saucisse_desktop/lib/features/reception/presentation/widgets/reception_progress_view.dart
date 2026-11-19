import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_desktop/features/pairing/presentation/bloc/reception_cubit.dart';
import 'package:dis_saucisse_desktop/features/reception/presentation/widgets/reception_count_card.dart';
import 'package:dis_saucisse_desktop/features/reception/presentation/widgets/reception_current_folder_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReceptionProgressView extends StatelessWidget {
  const ReceptionProgressView({super.key, required this.progress});

  final ReceptionInProgress progress;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(DsSpacing.xxl, DsSpacing.xxl, DsSpacing.xxl, DsSpacing.xl),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          spacing: DsSpacing.m,
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    progress.paused
                        ? 'Le téléphone attend que tu reprennes'
                        : '${progress.phoneName} envoie ses photos',
                    style: DsTextStyles.caption.copyWith(fontSize: 13),
                  ),
                  Text(progress.paused ? 'Réception en pause' : 'Réception en cours', style: DsTextStyles.display),
                ],
              ),
            ),
            DsButton(
              label: progress.paused ? 'Reprendre' : 'Mettre en pause',
              variant: progress.paused ? DsButtonVariant.dark : DsButtonVariant.light,
              expanded: false,
              onPressed: progress.paused
                  ? context.read<ReceptionCubit>().resumeReception
                  : context.read<ReceptionCubit>().pauseReception,
            ),
          ],
        ),
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
