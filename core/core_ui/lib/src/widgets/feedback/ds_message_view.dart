import 'package:core_ui/src/foundation/ds_colors.dart';
import 'package:core_ui/src/foundation/ds_spacing.dart';
import 'package:core_ui/src/foundation/ds_text_styles.dart';
import 'package:core_ui/src/widgets/brand/ds_mascot.dart';
import 'package:core_ui/src/widgets/buttons/ds_button.dart';
import 'package:core_ui/src/widgets/buttons/ds_button_variant.dart';
import 'package:core_ui/src/widgets/buttons/ds_round_icon_button.dart';
import 'package:core_ui/src/widgets/feedback/ds_message_action.dart';
import 'package:core_ui/src/widgets/feedback/ds_message_placement.dart';
import 'package:core_ui/src/widgets/layout/ds_mesh_background.dart';
import 'package:flutter/material.dart';

/// The mascot with a title and a message: empty states, successes and errors.
class DsMessageView extends StatelessWidget {
  const DsMessageView({
    super.key,
    required this.title,
    required this.message,
    this.primaryAction,
    this.secondaryAction,
    this.showBackButton = false,
    this.placement = DsMessagePlacement.page,
  });

  final String title;
  final String message;

  /// Dark button under the message.
  final DsMessageAction? primaryAction;

  /// Light button under the primary one.
  final DsMessageAction? secondaryAction;

  /// Shows a back arrow in the top left corner that pops the current page.
  final bool showBackButton;

  final DsMessagePlacement placement;

  static const double _panelMaxWidth = 460;

  @override
  Widget build(BuildContext context) {
    final DsMessageAction? primary = primaryAction;
    final DsMessageAction? secondary = secondaryAction;
    final Widget content = SafeArea(
      child: Padding(
        padding: switch (placement) {
          DsMessagePlacement.page => const EdgeInsets.all(DsSpacing.l),
          DsMessagePlacement.tab => const EdgeInsets.fromLTRB(DsSpacing.l, DsSpacing.l, DsSpacing.l, 120),
          DsMessagePlacement.panel => const EdgeInsets.all(DsSpacing.xxl),
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (showBackButton)
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
                  Center(
                    child: DsMascot(
                      width: switch (placement) {
                        DsMessagePlacement.page || DsMessagePlacement.panel => 160,
                        DsMessagePlacement.tab => 140,
                      },
                    ),
                  ),
                  Text(title, style: DsTextStyles.titleXl, textAlign: TextAlign.center),
                  Text(
                    message,
                    style: DsTextStyles.body.copyWith(color: DsColors.textSoft),
                    textAlign: TextAlign.center,
                  ),
                  if (primary != null || secondary != null) const SizedBox(height: DsSpacing.s),
                  if (primary != null)
                    DsButton(label: primary.label, variant: DsButtonVariant.dark, onPressed: primary.onPressed),
                  if (secondary != null)
                    DsButton(label: secondary.label, variant: DsButtonVariant.light, onPressed: secondary.onPressed),
                ],
              ),
            ),
          ],
        ),
      ),
    );
    return switch (placement) {
      DsMessagePlacement.page => DsMeshBackground(child: content),
      DsMessagePlacement.tab => content,
      DsMessagePlacement.panel => Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: _panelMaxWidth),
          child: content,
        ),
      ),
    };
  }
}
