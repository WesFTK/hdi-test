import 'package:flutter/material.dart';

final class AppColors {
  static const Color indigo900 = Color(0xFF312E81);
  static const Color indigo800 = Color(0xFF3730A3);
  static const Color indigo700 = Color(0xFF4338CA);
  static const Color indigo600 = Color(0xFF4F46E5);
  static const Color indigo500 = Color(0xFF6366F1);
  static const Color indigo400 = Color(0xFF818CF8);
  static const Color indigo300 = Color(0xFFA5B4FC);
  static const Color indigo200 = Color(0xFFC7D2FE);
  static const Color indigo100 = Color(0xFFE0E7FF);
  static const Color indigo50 = Color(0xFFEEF2FF);

  static const Color violet900 = Color(0xFF4C1D95);
  static const Color violet700 = Color(0xFF6D28D9);
  static const Color violet600 = Color(0xFF7C3AED);
  static const Color violet300 = Color(0xFFC4B5FD);
  static const Color violet100 = Color(0xFFEDE9FE);

  static const Color emerald700 = Color(0xFF047857);
  static const Color emerald500 = Color(0xFF10B981);
  static const Color emerald300 = Color(0xFF6EE7B7);
  static const Color emerald100 = Color(0xFFD1FAE5);
  static const Color emerald900 = Color(0xFF064E3B);

  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color grey50 = Color(0xFFF9FAFB);
  static const Color grey100 = Color(0xFFF3F4F6);
  static const Color grey200 = Color(0xFFE5E7EB);
  static const Color grey300 = Color(0xFFD1D5DB);
  static const Color grey400 = Color(0xFF9CA3AF);
  static const Color grey500 = Color(0xFF6B7280);
  static const Color grey700 = Color(0xFF374151);
  static const Color grey800 = Color(0xFF1F2937);
  static const Color grey900 = Color(0xFF111827);

  static const Color lightPageBg = Color(0xFFF8F7FF);
  static const Color darkPageBg = Color(0xFF0F0F1A);
  static const Color darkSurface = Color(0xFF1A1A2E);
  static const Color darkCard = Color(0xFF252540);
  static const Color darkElevated = Color(0xFF2A2A45);
  static const Color darkHighest = Color(0xFF353560);

  static const Color warning = Color(0xFFF59E0B);

  static const Color red400 = Color(0xFFF87171);
  static const Color red500 = Color(0xFFEF4444);
  static const Color red700 = Color(0xFFB91C1C);
  static const Color red900 = Color(0xFF7F1D1D);
  static const Color redContainer = Color(0xFFFEE2E2);
  static const Color redContainerDark = Color(0xFF450A0A);

  static const Color shimmerBaseLight = Color(0xFFE0E0E0);
  static const Color shimmerHighlightLight = Color(0xFFF5F5F5);
  static const Color shimmerBaseDark = Color(0xFF2A2A45);
  static const Color shimmerHighlightDark = Color(0xFF353560);

  static const AppColorScheme light = AppColorScheme(
    primary: indigo600,
    onPrimary: white,
    primaryContainer: indigo50,
    onPrimaryContainer: indigo900,
    secondary: violet600,
    onSecondary: white,
    secondaryContainer: violet100,
    onSecondaryContainer: violet900,
    tertiary: emerald500,
    onTertiary: white,
    tertiaryContainer: emerald100,
    onTertiaryContainer: emerald900,
    surface: white,
    onSurface: grey900,
    surfaceContainer: grey100,
    onSurfaceVariant: grey500,
    outline: grey200,
    outlineVariant: grey300,
    divider: grey200,
    error: red500,
    onError: white,
    errorContainer: redContainer,
    onErrorContainer: red700,
    scaffoldBg: lightPageBg,
    shimmerBase: shimmerBaseLight,
    shimmerHighlight: shimmerHighlightLight,
  );

  static const AppColorScheme dark = AppColorScheme(
    primary: indigo300,
    onPrimary: indigo900,
    primaryContainer: darkCard,
    onPrimaryContainer: indigo200,
    secondary: violet300,
    onSecondary: violet900,
    secondaryContainer: darkSurface,
    onSecondaryContainer: violet100,
    tertiary: emerald300,
    onTertiary: emerald900,
    tertiaryContainer: emerald700,
    onTertiaryContainer: emerald100,
    surface: darkSurface,
    onSurface: grey50,
    surfaceContainer: darkElevated,
    onSurfaceVariant: grey400,
    outline: grey700,
    outlineVariant: darkElevated,
    divider: darkElevated,
    error: red400,
    onError: red900,
    errorContainer: redContainerDark,
    onErrorContainer: red400,
    scaffoldBg: darkPageBg,
    shimmerBase: shimmerBaseDark,
    shimmerHighlight: shimmerHighlightDark,
  );
}

final class AppColorScheme {
  const AppColorScheme({
    required this.primary,
    required this.onPrimary,
    required this.primaryContainer,
    required this.onPrimaryContainer,
    required this.secondary,
    required this.onSecondary,
    required this.secondaryContainer,
    required this.onSecondaryContainer,
    required this.tertiary,
    required this.onTertiary,
    required this.tertiaryContainer,
    required this.onTertiaryContainer,
    required this.surface,
    required this.onSurface,
    required this.surfaceContainer,
    required this.onSurfaceVariant,
    required this.outline,
    required this.outlineVariant,
    required this.divider,
    required this.error,
    required this.onError,
    required this.errorContainer,
    required this.onErrorContainer,
    required this.scaffoldBg,
    required this.shimmerBase,
    required this.shimmerHighlight,
  });

  final Color primary;
  final Color onPrimary;
  final Color primaryContainer;
  final Color onPrimaryContainer;
  final Color secondary;
  final Color onSecondary;
  final Color secondaryContainer;
  final Color onSecondaryContainer;
  final Color tertiary;
  final Color onTertiary;
  final Color tertiaryContainer;
  final Color onTertiaryContainer;
  final Color surface;
  final Color onSurface;
  final Color surfaceContainer;
  final Color onSurfaceVariant;
  final Color outline;
  final Color outlineVariant;
  final Color divider;
  final Color error;
  final Color onError;
  final Color errorContainer;
  final Color onErrorContainer;
  final Color scaffoldBg;
  final Color shimmerBase;
  final Color shimmerHighlight;

  ColorScheme toMaterialColorScheme(Brightness brightness) => ColorScheme(
    brightness: brightness,
    primary: primary,
    onPrimary: onPrimary,
    primaryContainer: primaryContainer,
    onPrimaryContainer: onPrimaryContainer,
    secondary: secondary,
    onSecondary: onSecondary,
    secondaryContainer: secondaryContainer,
    onSecondaryContainer: onSecondaryContainer,
    tertiary: tertiary,
    onTertiary: onTertiary,
    tertiaryContainer: tertiaryContainer,
    onTertiaryContainer: onTertiaryContainer,
    surface: surface,
    onSurface: onSurface,
    surfaceContainerHighest: surfaceContainer,
    onSurfaceVariant: onSurfaceVariant,
    outline: outline,
    outlineVariant: outlineVariant,
    error: error,
    onError: onError,
    errorContainer: errorContainer,
    onErrorContainer: onErrorContainer,
  );
}
