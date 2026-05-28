import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

// Poppins for headings/titles, Inter for body/label/caption
abstract final class AppTypography {
  static TextStyle get displayLarge =>
      GoogleFonts.poppins(fontSize: 57.sp, fontWeight: FontWeight.w400, letterSpacing: -0.25, height: 1.12);

  static TextStyle get displayMedium =>
      GoogleFonts.poppins(fontSize: 45.sp, fontWeight: FontWeight.w400, letterSpacing: 0, height: 1.16);

  static TextStyle get displaySmall =>
      GoogleFonts.poppins(fontSize: 36.sp, fontWeight: FontWeight.w400, letterSpacing: 0, height: 1.22);

  static TextStyle get h1 =>
      GoogleFonts.poppins(fontSize: 32.sp, fontWeight: FontWeight.w700, letterSpacing: 0, height: 1.25);

  static TextStyle get h2 =>
      GoogleFonts.poppins(fontSize: 28.sp, fontWeight: FontWeight.w700, letterSpacing: 0, height: 1.29);

  static TextStyle get h3 =>
      GoogleFonts.poppins(fontSize: 24.sp, fontWeight: FontWeight.w600, letterSpacing: 0, height: 1.33);

  static TextStyle get h4 =>
      GoogleFonts.poppins(fontSize: 22.sp, fontWeight: FontWeight.w600, letterSpacing: 0, height: 1.36);

  static TextStyle get h5 =>
      GoogleFonts.poppins(fontSize: 20.sp, fontWeight: FontWeight.w600, letterSpacing: 0, height: 1.4);

  static TextStyle get h6 =>
      GoogleFonts.poppins(fontSize: 18.sp, fontWeight: FontWeight.w600, letterSpacing: 0.15, height: 1.44);

  static TextStyle get titleLarge =>
      GoogleFonts.poppins(fontSize: 22.sp, fontWeight: FontWeight.w500, letterSpacing: 0, height: 1.27);

  static TextStyle get titleMedium =>
      GoogleFonts.poppins(fontSize: 16.sp, fontWeight: FontWeight.w500, letterSpacing: 0.15, height: 1.50);

  static TextStyle get titleSmall =>
      GoogleFonts.poppins(fontSize: 14.sp, fontWeight: FontWeight.w500, letterSpacing: 0.1, height: 1.43);

  static TextStyle get labelLarge =>
      GoogleFonts.inter(fontSize: 14.sp, fontWeight: FontWeight.w500, letterSpacing: 0.1, height: 1.43);

  static TextStyle get labelMedium =>
      GoogleFonts.inter(fontSize: 12.sp, fontWeight: FontWeight.w500, letterSpacing: 0.5, height: 1.33);

  static TextStyle get labelSmall =>
      GoogleFonts.inter(fontSize: 11.sp, fontWeight: FontWeight.w500, letterSpacing: 0.5, height: 1.45);

  static TextStyle get bodyLarge =>
      GoogleFonts.inter(fontSize: 16.sp, fontWeight: FontWeight.w400, letterSpacing: 0.5, height: 1.50);

  static TextStyle get bodyMedium =>
      GoogleFonts.inter(fontSize: 14.sp, fontWeight: FontWeight.w400, letterSpacing: 0.25, height: 1.43);

  static TextStyle get bodySmall =>
      GoogleFonts.inter(fontSize: 12.sp, fontWeight: FontWeight.w400, letterSpacing: 0.4, height: 1.33);

  // --- App-specific tokens (not mapped to textTheme slots) ---

  static TextStyle get sectionTitle =>
      GoogleFonts.poppins(fontSize: 16.sp, fontWeight: FontWeight.w700);

  static TextStyle get tileTitle =>
      GoogleFonts.inter(fontSize: 13.sp, fontWeight: FontWeight.w600);

  static TextStyle get tileAmount =>
      GoogleFonts.inter(fontSize: 13.sp, fontWeight: FontWeight.w700);

  static TextStyle get cardValue =>
      GoogleFonts.inter(fontSize: 14.sp, fontWeight: FontWeight.w700);

  static TextStyle get captionLarge =>
      GoogleFonts.inter(fontSize: 15.sp, fontWeight: FontWeight.w400);

  static TextStyle get captionMedium =>
      GoogleFonts.inter(fontSize: 13.sp, fontWeight: FontWeight.w400);

  static TextStyle get chartTooltip =>
      GoogleFonts.inter(fontSize: 11.sp, fontWeight: FontWeight.w600);

  static TextStyle get micro =>
      GoogleFonts.inter(fontSize: 10.sp, fontWeight: FontWeight.w400);

  static TextStyle get memberName =>
      GoogleFonts.poppins(fontSize: 18.sp, fontWeight: FontWeight.w700);

  static TextStyle get memberAvatar =>
      GoogleFonts.poppins(fontSize: 20.sp, fontWeight: FontWeight.w700);

  static TextStyle get badge =>
      GoogleFonts.inter(fontSize: 12.sp, fontWeight: FontWeight.w600);

  static TextTheme get textTheme => TextTheme(
    displayLarge: displayLarge,
    displayMedium: displayMedium,
    displaySmall: displaySmall,
    headlineLarge: h1,
    headlineMedium: h2,
    headlineSmall: h3,
    titleLarge: titleLarge,
    titleMedium: titleMedium,
    titleSmall: titleSmall,
    labelLarge: labelLarge,
    labelMedium: labelMedium,
    labelSmall: labelSmall,
    bodyLarge: bodyLarge,
    bodyMedium: bodyMedium,
    bodySmall: bodySmall,
  );
}
