import 'package:core_ui/src/foundation/ds_spacing.dart';
import 'package:core_ui/src/foundation/ds_text_styles.dart';
import 'package:flutter/widgets.dart';

class DsGalleryTypography extends StatelessWidget {
  const DsGalleryTypography({super.key});

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    spacing: DsSpacing.xxs,
    children: <Widget>[
      Text('186 / 248', style: DsTextStyles.number),
      Text('248 photos à trier', style: DsTextStyles.display),
      Text('Titre XL — Fredoka 30', style: DsTextStyles.titleXl),
      Text('Titre L — Fredoka 22', style: DsTextStyles.titleL),
      Text('Titre M — Fredoka 18', style: DsTextStyles.titleM),
      Text('Texte gras — Nunito Sans 15', style: DsTextStyles.bodyBold),
      Text('Texte normal — Nunito Sans 15', style: DsTextStyles.body),
      Text('Légende — Nunito Sans 12', style: DsTextStyles.caption),
    ],
  );
}
