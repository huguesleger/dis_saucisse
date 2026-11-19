import 'package:dis_saucisse_mobile/features/photo_events/data/mappers/event_names_mapper.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/entities/event_id.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('maps stored names to event ids', () {
    expect(storedNamesToEventNames(<String, String>{'asset-1': 'Anniversaire de mamie'}), <EventId, String>{
      const EventId('asset-1'): 'Anniversaire de mamie',
    });
  });
}
