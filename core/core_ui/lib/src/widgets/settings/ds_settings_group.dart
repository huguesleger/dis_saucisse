import 'package:core_ui/src/foundation/ds_colors.dart';
import 'package:core_ui/src/foundation/ds_spacing.dart';
import 'package:core_ui/src/foundation/ds_text_styles.dart';
import 'package:core_ui/src/widgets/layout/ds_card.dart';
import 'package:flutter/material.dart';

/// Titled group of settings rows in a card ("RANGEMENT", "CE QUE L'APP IGNORE").
class DsSettingsGroup extends StatelessWidget {
  const DsSettingsGroup({super.key, required this.children, this.title});

  final List<Widget> children;
  final String? title;

  @override
  Widget build(BuildContext context) {
    final String? groupTitle = title;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (groupTitle != null)
          Padding(
            padding: const EdgeInsets.only(left: DsSpacing.xxs, bottom: DsSpacing.xs),
            child: Text(
              groupTitle.toUpperCase(),
              style: DsTextStyles.caption.copyWith(letterSpacing: 0.8, color: DsColors.textSoft),
            ),
          ),
        DsCard(
          padding: EdgeInsets.zero,
          child: Column(
            children: <Widget>[
              for (final (int index, Widget child) in children.indexed) ...<Widget>[
                if (index > 0) const Divider(indent: DsSpacing.m, endIndent: DsSpacing.m),
                child,
              ],
            ],
          ),
        ),
      ],
    );
  }
}
