import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_mobile/core/router/routes.dart';
import 'package:flutter/material.dart';

class TransferDoneView extends StatelessWidget {
  const TransferDoneView({
    super.key,
    required this.computerName,
    required this.sentCount,
    required this.eventCount,
    required this.sentBytes,
  });

  final String computerName;
  final int sentCount;
  final int eventCount;
  final int sentBytes;

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
            const SizedBox(height: DsSpacing.m),
            Center(
              child: DecoratedBox(
                decoration: const BoxDecoration(color: DsColors.background, borderRadius: DsRadius.pillAll),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: DsSpacing.m, vertical: DsSpacing.xs),
                  child: Text.rich(
                    TextSpan(
                      children: <InlineSpan>[
                        TextSpan(
                          text: byteSizeLabel(sentBytes),
                          style: DsTextStyles.titleM.copyWith(color: DsColors.sausage),
                        ),
                        TextSpan(text: '  libérables sur le téléphone', style: DsTextStyles.bodyBold),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const Spacer(),
            DsButton(
              label: 'Libérer de la place',
              variant: DsButtonVariant.dark,
              onPressed: () => const FreeSpacePageRoute().pushReplacement(context),
            ),
            const SizedBox(height: DsSpacing.s),
            DsButton(
              label: 'Garder sur le téléphone',
              variant: DsButtonVariant.light,
              onPressed: () => Navigator.of(context).maybePop(),
            ),
          ],
        ),
      ),
    ),
  );
}
