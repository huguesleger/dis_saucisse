import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_desktop/core/i18n/translations.g.dart';
import 'package:flutter/material.dart';

class ReceptionDoneSummary extends StatelessWidget {
  const ReceptionDoneSummary({
    super.key,
    required this.received,
    required this.rejected,
    required this.eventCount,
  });

  final int received;
  final int rejected;
  final int eventCount;

  @override
  Widget build(BuildContext context) {
    final TextStyle base = DsTextStyles.body.copyWith(fontSize: 17, height: 1.45);
    final TextStyle strong = DsTextStyles.bodyBold.copyWith(fontSize: 17, height: 1.45);
    return Text.rich(
      TextSpan(
        style: base,
        children: <InlineSpan>[
          TextSpan(
            text: received == 1 ? t.reception.doneSummary.articleSingle : t.reception.doneSummary.articleSeveral,
          ),
          TextSpan(
            text: received == 1
                ? t.reception.doneSummary.photosSingle
                : t.reception.doneSummary.photosSeveral(count: received),
            style: strong,
          ),
          TextSpan(text: received == 1 ? t.reception.doneSummary.storedSingle : t.reception.doneSummary.storedSeveral),
          if (eventCount > 0) ...<InlineSpan>[
            TextSpan(text: t.reception.doneSummary.inEvents),
            TextSpan(
              text: eventCount == 1
                  ? t.reception.doneSummary.eventsSingle
                  : t.reception.doneSummary.eventsSeveral(count: eventCount),
              style: strong,
            ),
          ],
          TextSpan(
            text: rejected == 0
                ? t.reception.doneSummary.allVerified
                : rejected == 1
                ? t.reception.doneSummary.rejectedSingle(count: rejected)
                : t.reception.doneSummary.rejectedSeveral(count: rejected),
          ),
        ],
      ),
    );
  }
}
