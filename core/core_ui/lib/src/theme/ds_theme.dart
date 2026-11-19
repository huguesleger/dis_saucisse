import 'package:core_ui/src/foundation/ds_colors.dart';
import 'package:core_ui/src/foundation/ds_radius.dart';
import 'package:core_ui/src/foundation/ds_text_styles.dart';
import 'package:flutter/material.dart';

/// The light theme of Dis Saucisse !, the only theme of the V1.
abstract final class DsTheme {
  static ThemeData light() {
    const ColorScheme colorScheme = ColorScheme(
      brightness: Brightness.light,
      primary: DsColors.mustard,
      onPrimary: DsColors.onMustard,
      primaryContainer: DsColors.mustardLight,
      onPrimaryContainer: DsColors.onMustard,
      secondary: DsColors.text,
      onSecondary: DsColors.mustardLight,
      tertiary: DsColors.sausage,
      onTertiary: DsColors.onSausage,
      error: DsColors.sausage,
      onError: DsColors.onSausage,
      surface: DsColors.background,
      onSurface: DsColors.text,
      onSurfaceVariant: DsColors.textSoft,
      surfaceContainerLowest: DsColors.background,
      surfaceContainerLow: DsColors.pageBackground,
      surfaceContainer: DsColors.surface,
      surfaceContainerHigh: DsColors.surfaceStrong,
      outline: DsColors.border,
      outlineVariant: DsColors.border,
    );

    final TextTheme textTheme = TextTheme(
      displayLarge: DsTextStyles.number,
      displayMedium: DsTextStyles.display,
      headlineLarge: DsTextStyles.titleXl,
      headlineMedium: DsTextStyles.titleL,
      titleLarge: DsTextStyles.titleL,
      titleMedium: DsTextStyles.titleM,
      titleSmall: DsTextStyles.bodyBold,
      bodyLarge: DsTextStyles.bodyBold,
      bodyMedium: DsTextStyles.body,
      bodySmall: DsTextStyles.caption,
      labelLarge: DsTextStyles.label,
      labelMedium: DsTextStyles.bodyBold,
      labelSmall: DsTextStyles.caption,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: DsColors.pageBackground,
      canvasColor: DsColors.pageBackground,
      textTheme: textTheme,
      iconTheme: const IconThemeData(color: DsColors.text, size: 22),
      dividerTheme: const DividerThemeData(color: DsColors.border, thickness: 1, space: 1),
      splashFactory: InkSparkle.splashFactory,
      switchTheme: SwitchThemeData(
        thumbColor: const WidgetStatePropertyAll<Color>(DsColors.background),
        trackColor: WidgetStateProperty.resolveWith(
          (Set<WidgetState> states) => states.contains(WidgetState.selected) ? DsColors.mustard : DsColors.border,
        ),
        trackOutlineColor: const WidgetStatePropertyAll<Color>(Colors.transparent),
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: DsColors.background,
        shape: RoundedRectangleBorder(borderRadius: DsRadius.sheetTop),
        showDragHandle: true,
        dragHandleColor: DsColors.border,
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: DsColors.text,
        contentTextStyle: DsTextStyles.bodyBold.copyWith(color: DsColors.background),
        behavior: SnackBarBehavior.floating,
        shape: const RoundedRectangleBorder(borderRadius: DsRadius.mediumAll),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: DsColors.background,
        hintStyle: DsTextStyles.body.copyWith(color: DsColors.textSoft),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: const OutlineInputBorder(
          borderRadius: DsRadius.mediumAll,
          borderSide: BorderSide(color: DsColors.border),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: DsRadius.mediumAll,
          borderSide: BorderSide(color: DsColors.border),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: DsRadius.mediumAll,
          borderSide: BorderSide(color: DsColors.mustard, width: 2),
        ),
      ),
    );
  }
}
