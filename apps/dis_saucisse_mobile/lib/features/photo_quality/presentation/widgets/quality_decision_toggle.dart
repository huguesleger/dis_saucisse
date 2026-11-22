import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_mobile/core/i18n/translations.g.dart';
import 'package:flutter/material.dart';

class QualityDecisionToggle extends StatelessWidget {
  const QualityDecisionToggle({super.key, required this.toDiscard, required this.onChanged});

  final bool toDiscard;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) => DecoratedBox(
    decoration: const BoxDecoration(color: DsColors.pageBackground, borderRadius: DsRadius.pillAll),
    child: Padding(
      padding: const EdgeInsets.all(DsSpacing.xxs),
      child: Row(
        children: <Widget>[
          for (final (bool discard, String label, Color color) in <(bool, String, Color)>[
            (false, t.quality.viewer.keep, DsColors.success),
            (true, t.quality.viewer.discard, DsColors.sausage),
          ])
            Expanded(
              child: Semantics(
                button: true,
                selected: toDiscard == discard,
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => onChanged(discard),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    padding: const EdgeInsets.symmetric(vertical: DsSpacing.s),
                    decoration: BoxDecoration(
                      color: toDiscard == discard ? color : const Color(0x00000000),
                      borderRadius: DsRadius.pillAll,
                    ),
                    child: Text(
                      label,
                      textAlign: TextAlign.center,
                      style: DsTextStyles.label.copyWith(
                        color: toDiscard == discard ? DsColors.background : DsColors.text,
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    ),
  );
}
