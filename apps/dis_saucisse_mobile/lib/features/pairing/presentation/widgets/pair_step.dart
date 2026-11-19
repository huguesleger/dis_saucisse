import 'package:core_ui/core_ui.dart';
import 'package:flutter/widgets.dart';

class PairStep extends StatelessWidget {
  const PairStep({super.key, required this.number, required this.text});

  final int number;
  final String text;

  @override
  Widget build(BuildContext context) => Row(
    spacing: DsSpacing.s,
    children: <Widget>[
      Container(
        width: 26,
        height: 26,
        alignment: Alignment.center,
        decoration: const BoxDecoration(color: DsColors.mustardLight, shape: BoxShape.circle),
        child: Text('$number', style: DsTextStyles.bodyBold.copyWith(fontSize: 13)),
      ),
      Expanded(child: Text(text, style: DsTextStyles.body.copyWith(fontSize: 14))),
    ],
  );
}
