import 'package:core_ui/src/gen/assets.gen.dart';
import 'package:flutter/widgets.dart';

/// Endless loader: three little sausages hopping one after the other.
///
/// Use it wherever the app waits for something without a known progress.
class DsLoader extends StatelessWidget {
  const DsLoader({super.key, this.width = 96});

  /// Width of the animation. Its height is half of it.
  final double width;

  /// One full hop of the three sausages: the shortest time a loader should stay on screen.
  static const Duration minDuration = Duration(milliseconds: 1100);

  @override
  Widget build(BuildContext context) => Semantics(
    label: 'Chargement',
    child: SizedBox(
      width: width,
      height: width / 2,
      child: Assets.animations.dsLoader.lottie(fit: BoxFit.contain),
    ),
  );
}
