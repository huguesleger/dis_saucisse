import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

class MemoriesLoadingView extends StatelessWidget {
  const MemoriesLoadingView({super.key});

  @override
  Widget build(BuildContext context) => Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      spacing: DsSpacing.m,
      children: <Widget>[
        const DsMascot(width: 140),
        Text('Je rassemble tes souvenirs…', style: DsTextStyles.titleM),
        const CircularProgressIndicator(color: DsColors.mustard),
      ],
    ),
  );
}
