import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';

/// Endless loader: three little sausages hopping one after the other.
///
/// Use it wherever the app waits for something without a known progress.
class DsLoader extends StatelessWidget {
  const DsLoader({super.key, this.width = 96});

  /// Width of the animation. Its height is half of it.
  final double width;

  static const String _asset = 'assets/animations/ds_loader.json';

  @override
  Widget build(BuildContext context) => Semantics(
    label: 'Chargement',
    child: SizedBox(
      width: width,
      height: width / 2,
      child: Lottie.asset(_asset, package: 'core_ui', fit: BoxFit.contain),
    ),
  );
}
