import 'package:core_ui/core_ui.dart';
import 'package:flutter/widgets.dart';

class ReceptionHeader extends StatelessWidget {
  const ReceptionHeader({super.key});

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text('Bonjour ! Le PC est prêt à recevoir les photos', style: DsTextStyles.caption.copyWith(fontSize: 13)),
      const SizedBox(height: DsSpacing.xxs),
      Text('Associer un téléphone', style: DsTextStyles.display),
    ],
  );
}
