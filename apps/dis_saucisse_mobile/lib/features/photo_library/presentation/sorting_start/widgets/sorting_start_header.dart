import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_mobile/core/i18n/translations.g.dart';
import 'package:flutter/widgets.dart';

class SortingStartHeader extends StatelessWidget {
  const SortingStartHeader({super.key});

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      const Center(child: DsMascot(width: 160)),
      const SizedBox(height: DsSpacing.xl),
      Text(t.sorting.header.title, style: DsTextStyles.display),
      const SizedBox(height: DsSpacing.s),
      Text(
        t.sorting.header.subtitle,
        style: DsTextStyles.body.copyWith(color: DsColors.textSoft),
      ),
    ],
  );
}
