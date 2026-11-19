import 'package:core_ui/src/foundation/ds_colors.dart';
import 'package:core_ui/src/foundation/ds_radius.dart';
import 'package:flutter/widgets.dart';

/// Rounded progress bar of a transfer.
class DsProgressBar extends StatelessWidget {
  const DsProgressBar({super.key, required this.value, this.height = 12});

  final double value;
  final double height;

  @override
  Widget build(BuildContext context) => Semantics(
    value: '${(value.clamp(0, 1) * 100).round()} %',
    child: ClipRRect(
      borderRadius: DsRadius.pillAll,
      child: SizedBox(
        height: height,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            ColoredBox(color: DsColors.background.withValues(alpha: 0.7)),
            FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: value.clamp(0, 1),
              child: const DecoratedBox(
                decoration: BoxDecoration(color: DsColors.text, borderRadius: DsRadius.pillAll),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
