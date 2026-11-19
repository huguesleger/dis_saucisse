import 'package:dis_saucisse_mobile/features/photo_events/domain/entities/event_id.dart';

Map<EventId, String> storedNamesToEventNames(Map<String, String> stored) =>
    stored.map((String id, String name) => MapEntry<EventId, String>(EventId(id), name));
