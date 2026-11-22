import 'package:core_ui/core_ui.dart';
import 'package:flutter/widgets.dart';
import 'package:dis_saucisse_mobile/core/i18n/translations.g.dart';

class HomeGreeting extends StatelessWidget {
  const HomeGreeting({super.key, required this.photosToSortCount});

  final int photosToSortCount;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(t.home.greeting, style: DsTextStyles.caption.copyWith(fontSize: 13)),
      const SizedBox(height: DsSpacing.xxs),
      Text(switch (photosToSortCount) {
        0 => t.home.photosToSort.zero,
        1 => t.home.photosToSort.single,
        _ => t.home.photosToSort.several(count: photosToSortCount),
      }, style: DsTextStyles.display),
    ],
  );
}
