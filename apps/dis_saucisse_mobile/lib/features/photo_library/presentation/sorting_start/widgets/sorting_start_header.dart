import 'package:core_ui/core_ui.dart';
import 'package:flutter/widgets.dart';

class SortingStartHeader extends StatelessWidget {
  const SortingStartHeader({super.key});

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      const Center(child: DsMascot(width: 160)),
      const SizedBox(height: DsSpacing.xl),
      Text('Depuis quand\non trie ?', style: DsTextStyles.display),
      const SizedBox(height: DsSpacing.s),
      Text(
        'Commence par tes photos récentes : tu pourras toujours remonter plus loin plus tard.',
        style: DsTextStyles.body.copyWith(color: DsColors.textSoft),
      ),
    ],
  );
}
