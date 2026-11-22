import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_mobile/core/i18n/translations.g.dart';
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
      Text(t.memories.header.caption, style: DsTextStyles.caption.copyWith(fontSize: 13)),
      const SizedBox(height: DsSpacing.xxs),
      Text(t.memories.header.photosSafe(photos: photoCountLabel(photoCount)), style: DsTextStyles.display),
    ],
  );
}
