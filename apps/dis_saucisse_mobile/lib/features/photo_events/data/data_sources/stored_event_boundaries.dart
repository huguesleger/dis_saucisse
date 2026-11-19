import 'package:flutter/foundation.dart';

@immutable
final class StoredEventBoundaries {
  const StoredEventBoundaries({required this.joinedAt, required this.splitAt});

  factory StoredEventBoundaries.fromJson(Map<String, dynamic> json) => StoredEventBoundaries(
    joinedAt: List<String>.from(json['joinedAt'] as List<dynamic>? ?? <dynamic>[]),
    splitAt: List<String>.from(json['splitAt'] as List<dynamic>? ?? <dynamic>[]),
  );

  final List<String> joinedAt;
  final List<String> splitAt;

  Map<String, dynamic> toJson() => <String, dynamic>{'joinedAt': joinedAt, 'splitAt': splitAt};
}
