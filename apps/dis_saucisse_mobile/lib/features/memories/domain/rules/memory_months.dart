import 'package:dis_saucisse_mobile/features/memories/domain/entities/memory_month.dart';
import 'package:dis_saucisse_mobile/features/memories/domain/entities/sent_photo_record.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/entities/event_id.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/entities/photo_event.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/library_photo.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/photo_id.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/photo_month.dart';
import 'package:fpdart/fpdart.dart';

typedef _PhotoOnPhone = ({LibraryPhoto photo, EventId event});

typedef _MonthPhoto = ({SentPhotoRecord record, Option<_PhotoOnPhone> onPhone});

List<MemoryMonth> memoryMonthsNewestFirst(List<SentPhotoRecord> sent, List<PhotoEvent> events) {
  final Map<PhotoId, _PhotoOnPhone> photosOnPhone = <PhotoId, _PhotoOnPhone>{
    for (final PhotoEvent event in events)
      for (final LibraryPhoto photo in event.photos) photo.id: (photo: photo, event: event.id),
  };
  final Map<PhotoMonth, List<_MonthPhoto>> byMonth = <PhotoMonth, List<_MonthPhoto>>{};
  for (final SentPhotoRecord record in latestRecordPerPhoto(sent)) {
    final Option<_PhotoOnPhone> onPhone = Option<_PhotoOnPhone>.fromNullable(photosOnPhone[record.photoId]);
    final PhotoMonth month = onPhone.match(
      () => PhotoMonth(year: record.sentAt.year, month: record.sentAt.month),
      (_PhotoOnPhone found) => found.photo.month,
    );
    byMonth.putIfAbsent(month, () => <_MonthPhoto>[]).add((record: record, onPhone: onPhone));
  }
  return (byMonth.entries.map(_memoryMonth).toList()
    ..sort((MemoryMonth a, MemoryMonth b) => b.month.compareTo(a.month)));
}

List<SentPhotoRecord> latestRecordPerPhoto(List<SentPhotoRecord> sent) => <PhotoId, SentPhotoRecord>{
  for (final SentPhotoRecord record
      in sent.toList()..sort((SentPhotoRecord a, SentPhotoRecord b) => a.sentAt.compareTo(b.sentAt)))
    record.photoId: record,
}.values.toList();

List<int> memoryYearsNewestFirst(List<MemoryMonth> months) =>
    months.map((MemoryMonth memory) => memory.month.year).toSet().toList()..sort((int a, int b) => b.compareTo(a));

List<MemoryMonth> memoryMonthsOf(List<MemoryMonth> months, Option<int> year) => year.match(
  () => months,
  (int selected) => months.where((MemoryMonth memory) => memory.month.year == selected).toList(),
);

MemoryMonth _memoryMonth(MapEntry<PhotoMonth, List<_MonthPhoto>> entry) {
  final List<_PhotoOnPhone> onPhone =
      entry.value
          .expand<_PhotoOnPhone>(
            (_MonthPhoto photo) =>
                photo.onPhone.match(() => <_PhotoOnPhone>[], (_PhotoOnPhone found) => <_PhotoOnPhone>[found]),
          )
          .toList()
        ..sort((_PhotoOnPhone a, _PhotoOnPhone b) => b.photo.takenAt.compareTo(a.photo.takenAt));
  return MemoryMonth(
    month: entry.key,
    photoCount: entry.value.length,
    eventCount: onPhone.map((_PhotoOnPhone photo) => photo.event).toSet().length,
    byteCount: entry.value.fold(0, (int total, _MonthPhoto photo) => total + photo.record.byteCount),
    lastSentAt: entry.value
        .map((_MonthPhoto photo) => photo.record.sentAt)
        .reduce((DateTime a, DateTime b) => a.isAfter(b) ? a : b),
    photosOnPhone: onPhone.map((_PhotoOnPhone photo) => photo.photo.id).toList(),
  );
}
