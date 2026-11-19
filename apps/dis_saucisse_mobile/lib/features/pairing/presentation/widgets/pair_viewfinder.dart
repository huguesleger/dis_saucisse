import 'package:core_ui/core_ui.dart';
import 'package:flutter/widgets.dart';

class PairViewfinder extends StatelessWidget {
  const PairViewfinder({super.key});

  @override
  Widget build(BuildContext context) => Align(
    alignment: const Alignment(0, 0.45),
    child: Container(
      width: 240,
      height: 240,
      decoration: BoxDecoration(
        borderRadius: DsRadius.cardAll,
        border: Border.all(color: DsColors.mustard, width: 4),
      ),
    ),
  );
}
