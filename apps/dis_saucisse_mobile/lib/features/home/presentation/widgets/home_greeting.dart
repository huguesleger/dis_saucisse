import 'package:core_ui/core_ui.dart';
import 'package:flutter/widgets.dart';

class HomeGreeting extends StatelessWidget {
  const HomeGreeting({super.key, required this.photosToSortCount});

  final int photosToSortCount;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text('Coucou ! Prête pour le tri ?', style: DsTextStyles.caption.copyWith(fontSize: 13)),
      const SizedBox(height: DsSpacing.xxs),
      Text('$photosToSortCount photos\nà trier', style: DsTextStyles.display),
    ],
  );
}
