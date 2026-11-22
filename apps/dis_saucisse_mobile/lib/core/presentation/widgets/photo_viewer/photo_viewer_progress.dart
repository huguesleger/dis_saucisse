import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_mobile/core/i18n/translations.g.dart';
import 'package:flutter/widgets.dart';

class PhotoViewerProgress extends StatelessWidget {
  const PhotoViewerProgress({super.key, required this.position, required this.count});

  final int position;
  final int count;

  @override
  Widget build(BuildContext context) => Semantics(
    label: t.photoViewer.position(position: position + 1, count: count),
    child: Row(
      spacing: DsSpacing.xxs,
      children: <Widget>[
        for (int index = 0; index < count; index++)
          Expanded(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: 3,
              decoration: BoxDecoration(
                color: DsColors.background.withValues(alpha: index == position ? 1 : 0.4),
                borderRadius: DsRadius.pillAll,
              ),
            ),
          ),
      ],
    ),
  );
}
