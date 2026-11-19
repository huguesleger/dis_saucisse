import 'package:flutter/widgets.dart';

/// Shadows of the design system.
abstract final class DsShadows {
  /// Soft shadow of the white cards.
  static const List<BoxShadow> card = <BoxShadow>[
    BoxShadow(color: Color(0x143A1520), blurRadius: 24, offset: Offset(0, 8)),
  ];

  /// Shadow of the floating navigation bar and floating buttons.
  static const List<BoxShadow> floating = <BoxShadow>[
    BoxShadow(color: Color(0x403A1520), blurRadius: 28, offset: Offset(0, 12)),
  ];
}
