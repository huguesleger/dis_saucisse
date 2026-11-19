import 'package:dis_saucisse_mobile/features/burst_sort/domain/entities/photo_decision.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/entities/event_library.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/entities/photo_event.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/library_photo.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/photo_id.dart';
import 'package:dis_saucisse_mobile/features/transfer/domain/entities/transfer_item.dart';

List<TransferItem> photosToSend(EventLibrary library, Set<PhotoId> alreadySent) => <TransferItem>[
  for (final PhotoEvent event in library.events)
    for (final LibraryPhoto photo in event.photos)
      if (library.decisions[photo.id] case final PhotoDecision decision when !alreadySent.contains(photo.id))
        TransferItem(photo: photo, decision: decision, eventName: event.name, eventDate: event.startedAt),
];

int eventCount(List<TransferItem> items) => items.map((TransferItem item) => item.eventDate).toSet().length;
