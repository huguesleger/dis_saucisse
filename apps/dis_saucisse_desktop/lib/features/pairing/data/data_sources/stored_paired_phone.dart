import 'package:flutter/foundation.dart';

@immutable
final class StoredPairedPhone {
  const StoredPairedPhone({required this.id, required this.name, required this.pairedAtMilliseconds});

  final String id;
  final String name;
  final int pairedAtMilliseconds;

  Map<String, Object> toJson() => <String, Object>{'id': id, 'name': name, 'pairedAt': pairedAtMilliseconds};

  static List<StoredPairedPhone> listFromJson(Object? json) => switch (json) {
    final List<dynamic> items => <StoredPairedPhone>[
      for (final Object? item in items)
        if (item case {'id': final String id, 'name': final String name, 'pairedAt': final int pairedAt})
          StoredPairedPhone(id: id, name: name, pairedAtMilliseconds: pairedAt),
    ],
    _ => <StoredPairedPhone>[],
  };
}
