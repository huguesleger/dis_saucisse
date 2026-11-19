import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

class StorageOptionRow extends StatelessWidget {
  const StorageOptionRow({
    super.key,
    required this.icon,
    required this.iconBackground,
    required this.title,
    required this.subtitle,
    required this.trailing,
  });

  final IconData icon;
  final Color iconBackground;
  final String title;
  final String subtitle;
  final Widget trailing;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: DsSpacing.xxs),
    child: Row(
      spacing: DsSpacing.s,
      children: <Widget>[
        DsIconSquare(icon: icon, background: iconBackground),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(title, style: DsTextStyles.bodyBold),
              Text(subtitle, style: DsTextStyles.caption, maxLines: 2, overflow: TextOverflow.ellipsis),
            ],
          ),
        ),
        trailing,
      ],
    ),
  );
}
