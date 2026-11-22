import 'package:core_ui/src/gen/assets.gen.dart';
import 'package:flutter/widgets.dart';

/// The sausage mascot. Its outline scales with its size, so it keeps the logo proportions.
class DsMascot extends StatelessWidget {
  const DsMascot({super.key, this.width = 120});

  final double width;

  @override
  Widget build(BuildContext context) => Assets.images.mascot.svg(
    width: width,
    height: width * 150 / 240,
    semanticsLabel: 'Saucisse',
  );
}
