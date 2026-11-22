import 'package:flutter/widgets.dart';

/// A button shown under the text of a [DsMessageView].
class DsMessageAction {
  const DsMessageAction({required this.label, required this.onPressed});

  final String label;
  final VoidCallback onPressed;
}
