import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

class BurstSortMessageView extends StatelessWidget {
  const BurstSortMessageView({super.key, required this.title, required this.message});

  final String title;
  final String message;

  @override
  Widget build(BuildContext context) => DsMeshBackground(
    child: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(DsSpacing.l),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: DsSpacing.m,
          children: <Widget>[
            const Center(child: DsMascot(width: 160)),
            Text(title, style: DsTextStyles.titleXl, textAlign: TextAlign.center),
            Text(
              message,
              style: DsTextStyles.body.copyWith(color: DsColors.textSoft),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: DsSpacing.s),
            DsButton(
              label: "Retour à l'accueil",
              variant: DsButtonVariant.dark,
              onPressed: () => Navigator.of(context).maybePop(),
            ),
          ],
        ),
      ),
    ),
  );
}
