import 'package:core_ui/src/foundation/ds_colors.dart';
import 'package:core_ui/src/foundation/ds_gradients.dart';
import 'package:flutter/widgets.dart';

/// Page background: a blurred mustard, peach and pink mesh at the top that fades into the warm grey page.
class DsMeshBackground extends StatelessWidget {
  const DsMeshBackground({super.key, required this.child, this.meshHeight = 360});

  final Widget child;
  final double meshHeight;

  @override
  Widget build(BuildContext context) => ColoredBox(
    color: DsColors.pageBackground,
    child: Stack(
      children: <Widget>[
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          height: meshHeight,
          child: const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.topRight,
                colors: DsGradients.headerMesh,
              ),
            ),
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: <Color>[Color(0x00F7F2EA), Color(0x66F7F2EA), DsColors.pageBackground],
                  stops: <double>[0, 0.55, 1],
                ),
              ),
            ),
          ),
        ),
        Positioned.fill(child: child),
      ],
    ),
  );
}
