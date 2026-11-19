import 'package:dis_saucisse_mobile/features/burst_sort/domain/entities/photo_decision.dart';
import 'package:dis_saucisse_mobile/features/pairing/domain/entities/paired_computer.dart';
import 'package:dis_saucisse_mobile/features/transfer/domain/entities/sent_photo.dart';
import 'package:dis_saucisse_mobile/features/transfer/domain/entities/transfer_item.dart';
import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';

@immutable
final class TransferProgress {
  const TransferProgress({
    required this.computer,
    required this.remaining,
    required this.total,
    required this.sent,
    required this.discardedSent,
    required this.sentBytes,
    required this.eventDates,
    required this.currentFolder,
    required this.startedAt,
  });

  factory TransferProgress.start(PairedComputer computer, List<TransferItem> items, DateTime startedAt) =>
      TransferProgress(
        computer: computer,
        remaining: items,
        total: items.length,
        sent: 0,
        discardedSent: 0,
        sentBytes: 0,
        eventDates: const <DateTime>{},
        currentFolder: none(),
        startedAt: startedAt,
      );

  final PairedComputer computer;
  final List<TransferItem> remaining;
  final int total;
  final int sent;
  final int discardedSent;
  final int sentBytes;
  final Set<DateTime> eventDates;
  final Option<String> currentFolder;
  final DateTime startedAt;

  int get eventCount => eventDates.length;

  Option<Duration> remainingTime(DateTime now) => sent == 0
      ? none()
      : some(Duration(microseconds: now.difference(startedAt).inMicroseconds ~/ sent * remaining.length));

  TransferProgress afterSending(TransferItem item, SentPhoto sentPhoto) => TransferProgress(
    computer: computer,
    remaining: remaining.skip(1).toList(),
    total: total,
    sent: sent + 1,
    discardedSent: discardedSent + (item.decision == PhotoDecision.discarded ? 1 : 0),
    sentBytes: sentBytes + sentPhoto.byteCount,
    eventDates: <DateTime>{...eventDates, item.eventDate},
    currentFolder: some(sentPhoto.folder),
    startedAt: startedAt,
  );
}
