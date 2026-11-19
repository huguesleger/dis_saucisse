import 'package:flutter/widgets.dart';

/// Colors of the Dis Saucisse ! palette, named after the Figma variables.
abstract final class DsColors {
  /// `fond`: cards and sheets.
  static const Color background = Color(0xFFFFFFFF);

  /// `fond-page`: warm grey behind the cards.
  static const Color pageBackground = Color(0xFFF7F2EA);

  /// `surface`: soft cream for secondary buttons and highlighted areas.
  static const Color surface = Color(0xFFFFF6DB);

  /// `surface-2`: stronger cream for icon squares and progress tracks.
  static const Color surfaceStrong = Color(0xFFFDEBB8);

  /// `bordure`.
  static const Color border = Color(0xFFF1E3C2);

  /// `texte`: main text, dark buttons and the floating navigation bar.
  static const Color text = Color(0xFF3A1520);

  /// `texte-doux`: secondary text.
  static const Color textSoft = Color(0xFF8A5A63);

  /// `moutarde`: primary action color.
  static const Color mustard = Color(0xFFF7B500);

  /// `moutarde-claire`.
  static const Color mustardLight = Color(0xFFFFD23F);

  /// `sur-moutarde`: content drawn on [mustard].
  static const Color onMustard = Color(0xFF3A1520);

  /// `saucisse`: the mascot red, used for accents.
  static const Color sausage = Color(0xFFC9383F);

  /// `sur-saucisse`: content drawn on [sausage].
  static const Color onSausage = Color(0xFFFFFFFF);

  /// Outline of the mascot.
  static const Color outline = Color(0xFF5B1F2A);

  /// Peach of the header mesh gradient.
  static const Color peach = Color(0xFFFFB38A);

  /// Pink of the header mesh gradient and of the mascot cheeks.
  static const Color blush = Color(0xFFF7A1B0);

  /// Inactive icons of the floating navigation bar.
  static const Color navInactive = Color(0xFFF2C4CC);

  /// Positive status text ("Rangé", "Tout vérifié").
  static const Color success = Color(0xFF2E8B57);

  /// Positive status background.
  static const Color successSoft = Color(0xFFE1F3E7);

  /// Soft lavender background of an icon square (settings rows).
  static const Color lavenderSoft = Color(0xFFEAE3F7);

  /// Soft sky blue background of an icon square (settings rows).
  static const Color skySoft = Color(0xFFE2ECF8);

  /// Soft pink background of an icon square (settings rows).
  static const Color blushSoft = Color(0xFFFBE3E7);
}
