import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// The sausage mascot. Its outline scales with its size, so it keeps the logo proportions.
class DsMascot extends StatelessWidget {
  const DsMascot({super.key, this.width = 120});

  final double width;

  @override
  Widget build(BuildContext context) => SvgPicture.asset(
    'assets/images/mascot.svg',
    package: 'core_ui',
    width: width,
    height: width * 150 / 240,
    semanticsLabel: 'Saucisse',
  );
}
