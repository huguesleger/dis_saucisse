import 'package:dis_saucisse_mobile/features/burst_sort/domain/entities/photo_decision.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/library_photo.dart';
import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';

@immutable
final class TransferItem {
  const TransferItem({required this.photo, required this.decision, required this.eventName, required this.eventDate});

  final LibraryPhoto photo;
  final PhotoDecision decision;
  final Option<String> eventName;
  final DateTime eventDate;
}
