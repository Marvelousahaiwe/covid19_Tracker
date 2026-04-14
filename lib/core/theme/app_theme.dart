import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class AppColors {
  static const Color scaffoldBg   = Color(0xFF0D1117);
  static const Color surfaceDark  = Color(0xFF161B22);
  static const Color cardBg       = Color(0xFF1C2230);
  static const Color divider      = Color(0xFF30363D);

  static const Color gradientStart = Color(0xFFE53935);
  static const Color gradientEnd   = Color(0xFFFF6F00);

  static const LinearGradient brandGradient = LinearGradient(
    colors: [gradientStart, gradientEnd],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const Color confirmed = Color(0xFF42A5F5);
  static const Color active    = Color(0xFFFFA726);
  static const Color recovered = Color(0xFF66BB6A);
  static const Color deaths    = Color(0xFFEF5350);

  static const Color textPrimary   = Color(0xFFF0F6FC);
  static const Color textSecondary = Color(0xFF8B949E);
  static const Color textMuted     = Color(0xFF484F58);

  static const Color white   = Color(0xFFFFFFFF);
  static const Color success = Color(0xFF3FB950);
  static const Color warning = Color(0xFFD29922);
  static const Color error   = Color(0xFFF85149);
}

abstract class AppTextStyles {
  static TextStyle get displayLarge => GoogleFonts.inter(
        fontSize: 32,
        fontWeight: FontWeight.w800,
        color: AppColors.textPrimary,
        letterSpacing: -0.5,
      );

  static TextStyle get headlineMedium => GoogleFonts.inter(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
        letterSpacing: -0.3,
      );

  static TextStyle get titleLarge => GoogleFonts.inter(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      );

  static TextStyle get titleMedium => GoogleFonts.inter(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      );

  static TextStyle get bodyMedium => GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.textSecondary,
      );

  static TextStyle get bodySmall => GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: AppColors.textSecondary,
      );

  static TextStyle get labelMedium => GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: AppColors.textMuted,
        letterSpacing: 0.8,
      );

  static TextStyle get statValue => GoogleFonts.inter(
        fontSize: 24,
        fontWeight: FontWeight.w800,
        color: AppColors.textPrimary,
        letterSpacing: -0.5,
      );
}

abstract class AppDimens {
  static const double paddingXS  = 4.0;
  static const double paddingSM  = 8.0;
  static const double paddingMD  = 16.0;
  static const double paddingLG  = 24.0;
  static const double paddingXL  = 32.0;

  static const double radiusSM   = 8.0;
  static const double radiusMD   = 12.0;
  static const double radiusLG   = 16.0;
  static const double radiusXL   = 24.0;

  static const double cardElevation = 0;
}

abstract class AppTheme {
  static ThemeData get dark => ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors.scaffoldBg,
        colorScheme: const ColorScheme.dark(
          primary: AppColors.gradientStart,
          secondary: AppColors.gradientEnd,
          surface: AppColors.surfaceDark,
          error: AppColors.error,
        ),
        cardTheme: CardThemeData(
          color: AppColors.cardBg,
          elevation: AppDimens.cardElevation,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimens.radiusLG),
          ),
          margin: EdgeInsets.zero,
        ),
        dividerColor: AppColors.divider,
        textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme),
        useMaterial3: true,
      );
}
