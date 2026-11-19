import 'package:core_ui/core_ui.dart';
import 'package:flutter/widgets.dart';

class HomeMessageView extends StatelessWidget {
  const HomeMessageView({
    super.key,
    required this.title,
    required this.message,
    required this.primaryLabel,
    required this.onPrimary,
    this.secondaryLabel,
    this.onSecondary,
  });

  final String title;
  final String message;
  final String primaryLabel;
  final VoidCallback onPrimary;
  final String? secondaryLabel;
  final VoidCallback? onSecondary;

  @override
  Widget build(BuildContext context) {
    final String? secondary = secondaryLabel;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(DsSpacing.l),
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
            const SizedBox(height: DsSpacing.s),
            DsButton(label: primaryLabel, variant: DsButtonVariant.dark, onPressed: onPrimary),
            if (secondary != null) DsButton(label: secondary, variant: DsButtonVariant.light, onPressed: onSecondary),
          ],
        ),
      ),
    );
  }
}
