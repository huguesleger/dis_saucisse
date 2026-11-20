import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_mobile/features/memories/presentation/memories_labels.dart';
import 'package:flutter/widgets.dart';

class MemoriesHeader extends StatelessWidget {
  const MemoriesHeader({super.key, required this.photoCount});

  final int photoCount;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      const DsLogoPill(),
      const SizedBox(height: DsSpacing.xl),
      Text('Tout ce qui est rangé sur le PC', style: DsTextStyles.caption.copyWith(fontSize: 13)),
      const SizedBox(height: DsSpacing.xxs),
      Text('${photoCountLabel(photoCount)}\nà l’abri', style: DsTextStyles.display),
    ],
  );
}
