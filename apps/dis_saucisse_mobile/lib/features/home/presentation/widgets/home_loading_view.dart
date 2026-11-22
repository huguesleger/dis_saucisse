import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

class HomeLoadingView extends StatelessWidget {
  const HomeLoadingView({super.key});

  @override
  Widget build(BuildContext context) => Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      spacing: DsSpacing.m,
      children: <Widget>[
        const DsMascot(width: 140),
        Text('Je regarde tes photos…', style: DsTextStyles.titleM),
        const DsLoader(),
      ],
    ),
  );
}
