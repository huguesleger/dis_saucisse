import 'package:core_ui/core_ui.dart';
import 'package:flutter/widgets.dart';

class MemoriesMessageView extends StatelessWidget {
  const MemoriesMessageView({super.key, required this.title, required this.message, this.actionLabel, this.onAction});

  final String title;
  final String message;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final String? action = actionLabel;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(DsSpacing.l, DsSpacing.l, DsSpacing.l, 120),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: DsSpacing.m,
          children: <Widget>[
            const Center(child: DsMascot(width: 140)),
            Text(title, style: DsTextStyles.titleXl, textAlign: TextAlign.center),
            Text(
              message,
              style: DsTextStyles.body.copyWith(color: DsColors.textSoft),
              textAlign: TextAlign.center,
            ),
            if (action != null) ...<Widget>[
              const SizedBox(height: DsSpacing.s),
              DsButton(label: action, variant: DsButtonVariant.dark, onPressed: onAction),
            ],
          ],
        ),
      ),
    );
  }
}
