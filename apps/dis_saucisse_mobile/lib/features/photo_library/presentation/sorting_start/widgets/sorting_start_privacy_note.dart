import 'package:core_ui/core_ui.dart';
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
            'Tes photos restent chez toi : elles ne partent que vers ton ordinateur, par ton Wi-Fi.',
            style: DsTextStyles.caption.copyWith(color: DsColors.text, fontSize: 13),
          ),
        ),
      ],
    ),
  );
}
