import 'package:flutter/widgets.dart';

/// Corner radii of the design system.
abstract final class DsRadius {
  static const double s = 12;
  static const double m = 16;
  static const double l = 20;
  static const double xl = 24;
  static const double xxl = 28;
  static const double pill = 999;

  static const BorderRadius smallAll = BorderRadius.all(Radius.circular(s));
  static const BorderRadius mediumAll = BorderRadius.all(Radius.circular(m));
  static const BorderRadius largeAll = BorderRadius.all(Radius.circular(l));
  static const BorderRadius cardAll = BorderRadius.all(Radius.circular(xl));
  static const BorderRadius sheetTop = BorderRadius.vertical(top: Radius.circular(xxl));
  static const BorderRadius pillAll = BorderRadius.all(Radius.circular(pill));
}
