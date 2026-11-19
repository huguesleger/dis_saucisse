import 'package:core_ui/src/foundation/ds_spacing.dart';
import 'package:core_ui/src/widgets/brand/ds_logo_pill.dart';
import 'package:core_ui/src/widgets/buttons/ds_round_icon_button.dart';
import 'package:core_ui/src/widgets/buttons/ds_round_icon_button_variant.dart';
import 'package:flutter/material.dart';

class DsGalleryTopBar extends StatelessWidget {
  const DsGalleryTopBar({super.key});

  @override
  Widget build(BuildContext context) => Row(
    children: <Widget>[
      const DsLogoPill(),
      const Spacer(),
      DsRoundIconButton(icon: Icons.calendar_today_outlined, tooltip: 'Calendrier', onPressed: () {}),
      const SizedBox(width: DsSpacing.xs),
      DsRoundIconButton(
        icon: Icons.desktop_windows_outlined,
        tooltip: 'Envoyer au PC',
        variant: DsRoundIconButtonVariant.dark,
        onPressed: () {},
      ),
    ],
  );
}
