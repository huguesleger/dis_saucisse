import 'package:core_ui/src/foundation/ds_colors.dart';
import 'package:core_ui/src/foundation/ds_radius.dart';
import 'package:core_ui/src/foundation/ds_spacing.dart';
import 'package:core_ui/src/foundation/ds_text_styles.dart';
import 'package:flutter/widgets.dart';

class DsGalleryColors extends StatelessWidget {
  const DsGalleryColors({super.key});

  static const List<(String, Color)> _swatches = <(String, Color)>[
    ('fond', DsColors.background),
    ('fond-page', DsColors.pageBackground),
    ('surface', DsColors.surface),
    ('surface-2', DsColors.surfaceStrong),
    ('bordure', DsColors.border),
    ('texte', DsColors.text),
    ('texte-doux', DsColors.textSoft),
    ('moutarde', DsColors.mustard),
    ('moutarde-claire', DsColors.mustardLight),
    ('saucisse', DsColors.sausage),
  ];

  @override
  Widget build(BuildContext context) => Wrap(
    spacing: DsSpacing.s,
    runSpacing: DsSpacing.s,
    children: <Widget>[
      for (final (String name, Color color) in _swatches)
        SizedBox(
          width: 64,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 48,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: DsRadius.smallAll,
                  border: Border.all(color: DsColors.border),
                ),
              ),
              const SizedBox(height: DsSpacing.xxs),
              Text(name, style: DsTextStyles.caption, maxLines: 1, overflow: TextOverflow.ellipsis),
            ],
          ),
        ),
    ],
  );
}
