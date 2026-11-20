import 'package:core_ui/core_ui.dart';
import 'package:flutter/widgets.dart';

class SettingsMessageView extends StatelessWidget {
  const SettingsMessageView({super.key, required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) => SafeArea(
    child: Padding(
      padding: const EdgeInsets.fromLTRB(DsSpacing.l, DsSpacing.l, DsSpacing.l, 120),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: DsSpacing.m,
        children: <Widget>[
          const Center(child: DsMascot(width: 140)),
          Text('Oups !', style: DsTextStyles.titleXl, textAlign: TextAlign.center),
          Text(
            "Je n'ai pas réussi à lire tes réglages.",
            style: DsTextStyles.body.copyWith(color: DsColors.textSoft),
            textAlign: TextAlign.center,
          ),
          DsButton(label: 'Réessayer', variant: DsButtonVariant.dark, onPressed: onRetry),
        ],
      ),
    ),
  );
}
