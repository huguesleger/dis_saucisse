import 'package:flutter/foundation.dart';

@immutable
final class PhotoMonth implements Comparable<PhotoMonth> {
  const PhotoMonth({required this.year, required this.month});

  final int year;
  final int month;

  @override
  int compareTo(PhotoMonth other) => year == other.year ? month.compareTo(other.month) : year.compareTo(other.year);

  @override
  bool operator ==(Object other) => other is PhotoMonth && other.year == year && other.month == month;

  @override
  int get hashCode => Object.hash(year, month);
}
