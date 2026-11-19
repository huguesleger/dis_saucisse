import 'package:core_ui/src/foundation/ds_colors.dart';
import 'package:flutter/widgets.dart';

/// Gradients of the design system.
abstract final class DsGradients {
  /// Placeholder gradients shown while a photo is not available.
  static const List<LinearGradient> photoPlaceholders = <LinearGradient>[
    LinearGradient(
      colors: <Color>[Color(0xFFFFB38A), Color(0xFFF07F6B)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    LinearGradient(
      colors: <Color>[Color(0xFF9FD08A), Color(0xFF5E9E5A)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    LinearGradient(
      colors: <Color>[Color(0xFF8EC5F0), Color(0xFF4F86C6)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    LinearGradient(
      colors: <Color>[Color(0xFFF7A1B0), Color(0xFFD86A8A)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    LinearGradient(
      colors: <Color>[Color(0xFFC5B3F2), Color(0xFF8A6FD1)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    LinearGradient(
      colors: <Color>[Color(0xFFF3D9A4), Color(0xFFD9A85B)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  ];

  /// Darkening scrim at the bottom of a photo, behind white text.
  static const LinearGradient photoScrim = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: <Color>[Color(0x00000000), Color(0x00000000), Color(0x993A1520)],
    stops: <double>[0, 0.4, 1],
  );

  /// Mesh colors of the screen header, from left to right.
  static const List<Color> headerMesh = <Color>[DsColors.mustardLight, DsColors.peach, DsColors.blush];
}
