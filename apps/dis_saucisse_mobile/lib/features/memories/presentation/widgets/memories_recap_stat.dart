import 'package:core_ui/core_ui.dart';
import 'package:flutter/widgets.dart';

class MemoriesRecapStat extends StatelessWidget {
  const MemoriesRecapStat({super.key, required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) => DecoratedBox(
    decoration: const BoxDecoration(color: Color(0x80FFFFFF), borderRadius: DsRadius.mediumAll),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: DsSpacing.s, vertical: DsSpacing.s),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(value, style: DsTextStyles.titleL),
          ),
          Text(label, style: DsTextStyles.caption.copyWith(color: DsColors.text)),
        ],
      ),
    ),
  );
}
