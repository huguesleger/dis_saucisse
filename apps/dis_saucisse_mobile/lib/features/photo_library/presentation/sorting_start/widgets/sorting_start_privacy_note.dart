import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_mobile/core/i18n/translations.g.dart';
import 'package:flutter/material.dart';

class SortingStartPrivacyNote extends StatelessWidget {
  const SortingStartPrivacyNote({super.key});

  @override
  Widget build(BuildContext context) => DsCard(
    child: Row(
      spacing: DsSpacing.s,
      children: <Widget>[
        const DsIconSquare(icon: Icons.lock_outline_rounded, background: DsColors.successSoft),
        Expanded(
          child: Text(
            t.sorting.privacyNote,
            style: DsTextStyles.caption.copyWith(color: DsColors.text, fontSize: 13),
          ),
        ),
      ],
    ),
  );
}
