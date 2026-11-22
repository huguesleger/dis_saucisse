import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

class QualityReviewMessageView extends StatelessWidget {
  const QualityReviewMessageView({super.key, required this.title, required this.message});

  final String title;
  final String message;

  @override
  Widget build(BuildContext context) => DsMeshBackground(
    child: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(DsSpacing.l),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: DsRoundIconButton(
                icon: Icons.arrow_back_rounded,
                tooltip: 'Retour',
                onPressed: () => Navigator.of(context).maybePop(),
              ),
            ),
            Expanded(
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
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
