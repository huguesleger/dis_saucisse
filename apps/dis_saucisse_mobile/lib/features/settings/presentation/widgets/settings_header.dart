import 'package:core_ui/core_ui.dart';
import 'package:flutter/widgets.dart';

class SettingsHeader extends StatelessWidget {
  const SettingsHeader({super.key});

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      const DsLogoPill(),
      const SizedBox(height: DsSpacing.xl),
      Text("L'app, à ta façon", style: DsTextStyles.caption.copyWith(fontSize: 13)),
      const SizedBox(height: DsSpacing.xxs),
      Text('Réglages', style: DsTextStyles.display),
    ],
  );
}
