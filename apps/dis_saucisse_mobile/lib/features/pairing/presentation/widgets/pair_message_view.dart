import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

class PairMessageView extends StatelessWidget {
  const PairMessageView({
    super.key,
    required this.title,
    required this.message,
    required this.actionLabel,
    required this.onAction,
  });

  final String title;
  final String message;
  final String actionLabel;
  final VoidCallback onAction;

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
            DsButton(label: actionLabel, variant: DsButtonVariant.dark, onPressed: onAction),
          ],
        ),
      ),
    ),
  );
}
