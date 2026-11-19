import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

class ReceptionStatBox extends StatelessWidget {
  const ReceptionStatBox({super.key, required this.value, required this.label, required this.dot});

  final String value;
  final String label;
  final Color dot;

  @override
  Widget build(BuildContext context) => DecoratedBox(
    decoration: const BoxDecoration(color: DsColors.pageBackground, borderRadius: DsRadius.mediumAll),
    child: Padding(
      padding: const EdgeInsets.all(DsSpacing.s),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          DecoratedBox(
            decoration: BoxDecoration(color: dot, shape: BoxShape.circle),
            child: const SizedBox.square(dimension: 8),
          ),
          const SizedBox(height: DsSpacing.xs),
          Text(value, style: DsTextStyles.titleL, maxLines: 1, overflow: TextOverflow.ellipsis),
          Text(label, style: DsTextStyles.caption),
        ],
      ),
    ),
  );
}
