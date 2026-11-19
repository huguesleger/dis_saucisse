import 'package:core_ui/src/foundation/ds_colors.dart';
import 'package:core_ui/src/foundation/ds_radius.dart';
import 'package:flutter/widgets.dart';

/// Icon in a rounded colored square, leading the stat tiles and settings rows.
class DsIconSquare extends StatelessWidget {
  const DsIconSquare({
    super.key,
    required this.icon,
    this.background = DsColors.surfaceStrong,
    this.foreground = DsColors.text,
    this.size = 36,
  });

  final IconData icon;
  final Color background;
  final Color foreground;
  final double size;

  @override
  Widget build(BuildContext context) => Container(
    width: size,
    height: size,
    decoration: BoxDecoration(color: background, borderRadius: DsRadius.smallAll),
    alignment: Alignment.center,
    child: Icon(icon, size: size * 0.5, color: foreground),
  );
}
