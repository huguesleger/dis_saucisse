import 'package:core_ui/core_ui.dart';
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
          TextSpan(text: received == 1 ? 'La ' : 'Les '),
          TextSpan(text: received == 1 ? '1 photo' : '$received photos', style: strong),
          TextSpan(text: ' du téléphone ${received == 1 ? 'est bien rangée' : 'sont bien rangées'}'),
          if (eventCount > 0) ...<InlineSpan>[
            const TextSpan(text: ' dans '),
            TextSpan(text: eventCount == 1 ? '1 événement' : '$eventCount événements', style: strong),
          ],
          TextSpan(
            text: rejected == 0
                ? ', toutes vérifiées.'
                : '. $rejected ${rejected == 1 ? 'photo n’a' : 'photos n’ont'} pas pu être rangée${rejected == 1 ? '' : 's'} : '
                      'le téléphone ${rejected == 1 ? 'la' : 'les'} renverra au prochain envoi.',
          ),
        ],
      ),
    );
  }
}
