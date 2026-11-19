import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_desktop/features/pairing/presentation/bloc/reception_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReceptionDoneView extends StatelessWidget {
  const ReceptionDoneView({super.key, required this.done});

  final ReceptionDone done;

  @override
  Widget build(BuildContext context) {
    final List<String> events = done.folders
        .map((String folder) => folder.split('/'))
        .where((List<String> segments) => segments.length >= 3)
        .map((List<String> segments) => segments[2])
        .toSet()
        .toList();
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 760),
        child: DsCard(
          color: DsColors.mustardLight,
          padding: const EdgeInsets.all(DsSpacing.xxl),
          child: Row(
            spacing: DsSpacing.xxl,
            children: <Widget>[
              const DsMascot(width: 200),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: DsSpacing.m,
                  children: <Widget>[
                    Text('Saucisse !', style: DsTextStyles.display),
                    Text(
                      'Les ${done.received} photos de ${done.phoneName} sont bien rangées'
                      '${events.isEmpty ? '' : ' dans ${events.length} ${events.length == 1 ? 'événement' : 'événements'}'}'
                      ', toutes vérifiées.',
                      style: DsTextStyles.body,
                    ),
                    Wrap(
                      spacing: DsSpacing.xs,
                      runSpacing: DsSpacing.xs,
                      children: <Widget>[
                        for (final String event in events) DsStatusBadge(label: event, tone: DsStatusTone.neutral),
                      ],
                    ),
                    Row(
                      spacing: DsSpacing.s,
                      children: <Widget>[
                        DsButton(
                          label: 'Ouvrir le dossier',
                          variant: DsButtonVariant.dark,
                          expanded: false,
                          onPressed: context.read<ReceptionCubit>().openStorageFolder,
                        ),
                        DsButton(
                          label: 'Fermer',
                          variant: DsButtonVariant.light,
                          expanded: false,
                          onPressed: context.read<ReceptionCubit>().closeSummary,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
