import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

class ReceptionSafetyNote extends StatelessWidget {
  const ReceptionSafetyNote({super.key});

  @override
  Widget build(BuildContext context) => DecoratedBox(
    decoration: const BoxDecoration(color: DsColors.pageBackground, borderRadius: DsRadius.mediumAll),
    child: Padding(
      padding: const EdgeInsets.all(DsSpacing.s),
      child: Row(
        spacing: DsSpacing.s,
        children: <Widget>[
          const DsIconSquare(
            icon: Icons.lock_outline_rounded,
            background: DsColors.successSoft,
            foreground: DsColors.success,
          ),
          Expanded(
            child: Text.rich(
              TextSpan(
                text: 'Chaque photo est vérifiée avant d’être marquée comme rangée. ',
                style: DsTextStyles.bodyBold.copyWith(fontSize: 13),
                children: <InlineSpan>[
                  TextSpan(
                    text: 'Rien n’est supprimé du téléphone sans son accord.',
                    style: DsTextStyles.body.copyWith(fontSize: 13, color: DsColors.textSoft),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
