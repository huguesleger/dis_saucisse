import 'package:core_ui/src/foundation/ds_colors.dart';
import 'package:core_ui/src/foundation/ds_radius.dart';
import 'package:core_ui/src/foundation/ds_spacing.dart';
import 'package:core_ui/src/foundation/ds_text_styles.dart';
import 'package:flutter/widgets.dart';

/// Status card of the desktop sidebar ("Téléphone Android · Associé · connecté", "Réseau Wi-Fi").
class DsConnectionCard extends StatelessWidget {
  const DsConnectionCard({
    super.key,
    required this.icon,
    required this.title,
    required this.status,
    this.connected = true,
  });

  final IconData icon;
  final String title;
  final String status;
  final bool connected;

  @override
  Widget build(BuildContext context) => DecoratedBox(
    decoration: const BoxDecoration(color: DsColors.surface, borderRadius: DsRadius.mediumAll),
    child: Padding(
      padding: const EdgeInsets.all(DsSpacing.s),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(icon, size: 16, color: DsColors.text),
              const SizedBox(width: DsSpacing.xs - 2),
              Expanded(child: Text(title, style: DsTextStyles.bodyBold.copyWith(fontSize: 13))),
            ],
          ),
          const SizedBox(height: DsSpacing.xxs),
          Row(
            children: <Widget>[
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: connected ? DsColors.success : DsColors.textSoft,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: DsSpacing.xs - 2),
              Expanded(child: Text(status, style: DsTextStyles.caption)),
            ],
          ),
        ],
      ),
    ),
  );
}
