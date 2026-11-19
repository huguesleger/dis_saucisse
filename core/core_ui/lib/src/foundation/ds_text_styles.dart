import 'package:core_ui/src/foundation/ds_colors.dart';
import 'package:flutter/painting.dart';

/// Text styles of the design system: Fredoka for titles, Nunito Sans for text.
abstract final class DsTextStyles {
  static const String _package = 'core_ui';

  /// Hero numbers ("186 / 248").
  static final TextStyle number = _fredoka(44, FontWeight.w600, height: 1.05);

  /// Big screen title ("248 photos à trier").
  static final TextStyle display = _fredoka(34, FontWeight.w600, height: 1.1);

  /// `Titre XL`: Fredoka SemiBold 30.
  static final TextStyle titleXl = _fredoka(30, FontWeight.w600, height: 1.15);

  /// `Titre L`: Fredoka SemiBold 22.
  static final TextStyle titleL = _fredoka(22, FontWeight.w600, height: 1.2);

  /// `Titre M`: Fredoka Medium 18.
  static final TextStyle titleM = _fredoka(18, FontWeight.w500, height: 1.25);

  /// `Texte gras`: Nunito Sans Bold 15.
  static final TextStyle bodyBold = _nunito(15, FontWeight.w700);

  /// `Texte normal`: Nunito Sans Regular 15.
  static final TextStyle body = _nunito(15, FontWeight.w400);

  /// `Légende`: Nunito Sans SemiBold 12.
  static final TextStyle caption = _nunito(12, FontWeight.w600, color: DsColors.textSoft);

  /// Label of buttons and chips.
  static final TextStyle label = _fredoka(16, FontWeight.w500, height: 1.2);

  static TextStyle _fredoka(double size, FontWeight weight, {double height = 1.2}) =>
      _style('Fredoka', size, weight, height: height, color: DsColors.text);

  static TextStyle _nunito(double size, FontWeight weight, {Color color = DsColors.text}) =>
      _style('NunitoSans', size, weight, height: 1.35, color: color);

  static TextStyle _style(
    String family,
    double size,
    FontWeight weight, {
    required double height,
    required Color color,
  }) => TextStyle(
    fontFamily: family,
    package: _package,
    fontSize: size,
    fontWeight: weight,
    fontVariations: <FontVariation>[FontVariation.weight(weight.value.toDouble())],
    height: height,
    color: color,
  );
}
