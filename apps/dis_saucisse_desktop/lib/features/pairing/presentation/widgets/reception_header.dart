import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_desktop/core/i18n/translations.g.dart';
import 'package:flutter/widgets.dart';

class ReceptionHeader extends StatelessWidget {
  const ReceptionHeader({super.key});

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(t.pairing.header.greeting, style: DsTextStyles.caption.copyWith(fontSize: 13)),
      const SizedBox(height: DsSpacing.xxs),
      Text(t.pairing.header.title, style: DsTextStyles.display),
    ],
  );
}
