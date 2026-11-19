import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

class TransferDoneView extends StatelessWidget {
  const TransferDoneView({super.key, required this.computerName, required this.sentCount, required this.eventCount});

  final String computerName;
  final int sentCount;
  final int eventCount;

  @override
  Widget build(BuildContext context) => ColoredBox(
    color: DsColors.mustardLight,
    child: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(DsSpacing.l),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Spacer(),
            const Center(child: DsMascot(width: 220)),
            const SizedBox(height: DsSpacing.xl),
            Text('Saucisse !', style: DsTextStyles.display, textAlign: TextAlign.center),
            const SizedBox(height: DsSpacing.s),
            Text(
              '${sentCount == 1 ? '1 photo est bien rangée' : '$sentCount photos sont bien rangées'} sur $computerName, '
              'dans ${eventCount == 1 ? '1 événement' : '$eventCount événements'}.',
              style: DsTextStyles.body,
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            DsButton(
              label: 'Retour à l’accueil',
              variant: DsButtonVariant.dark,
              onPressed: () => Navigator.of(context).maybePop(),
            ),
          ],
        ),
      ),
    ),
  );
}
