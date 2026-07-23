import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyle {
  AppTextStyle._();

  // ── Helper: Get TextStyle with Literata font ──
  static TextStyle _literata({
    required double fontSize,
    required FontWeight fontWeight,
    double? height,
    double? letterSpacing,
  }) {
    return GoogleFonts.literata(
      fontSize: fontSize,
      fontWeight: fontWeight,
      height: height != null ? height / fontSize : null,
      letterSpacing: letterSpacing,
    );
  }

  // ── Helper: Get TextStyle with Hanken Grotesk font ──
  static TextStyle _hankenGrotesk({
    required double fontSize,
    required FontWeight fontWeight,
    double? height,
    double? letterSpacing,
  }) {
    return GoogleFonts.hankenGrotesk(
      fontSize: fontSize,
      fontWeight: fontWeight,
      height: height != null ? height / fontSize : null,
      letterSpacing: letterSpacing,
    );
  }

  // ═══════════════════════════════════════
  //  HEADLINES – Literata
  // ═══════════════════════════════════════

  /// 40px / 48px / Bold / -2% letter spacing
  static TextStyle get headlineXl => _literata(
        fontSize: 40,
        fontWeight: FontWeight.w700,
        height: 48,
        letterSpacing: -0.02,
      );

  /// 32px / 40px / SemiBold
  static TextStyle get headlineLg => _literata(
        fontSize: 32,
        fontWeight: FontWeight.w600,
        height: 40,
      );

  /// 28px / 34px / SemiBold (mobile variant)
  static TextStyle get headlineLgMobile => _literata(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        height: 34,
      );

  /// 24px / 32px / SemiBold
  static TextStyle get headlineMd => _literata(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        height: 32,
      );

  // ═══════════════════════════════════════
  //  BODY – Hanken Grotesk
  // ═══════════════════════════════════════

  /// 18px / 28px / Regular
  static TextStyle get bodyLg => _hankenGrotesk(
        fontSize: 18,
        fontWeight: FontWeight.w400,
        height: 28,
      );

  /// 16px / 24px / Regular
  static TextStyle get bodyMd => _hankenGrotesk(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 24,
      );

  // ═══════════════════════════════════════
  //  LABEL – Hanken Grotesk
  // ═══════════════════════════════════════

  /// 14px / 20px / SemiBold / 1% letter spacing
  static TextStyle get labelMd => _hankenGrotesk(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        height: 20,
        letterSpacing: 0.01,
      );

  /// 12px / 16px / Medium / 5% letter spacing (use all-caps)
  static TextStyle get labelSm => _hankenGrotesk(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        height: 16,
        letterSpacing: 0.05,
      );

  // ═══════════════════════════════════════
  //  TEXT THEME mapping
  // ═══════════════════════════════════════
  //
  // Mapping custom styles to Material Design text theme roles:
  //   displayLarge  ← headlineXl   (40px)
  //   headlineLarge ← headlineLg   (32px)
  //   headlineMedium← headlineMd   (24px)
  //   bodyLarge     ← bodyLg       (18px)
  //   bodyMedium    ← bodyMd       (16px)
  //   labelLarge    ← labelMd      (14px)
  //   labelSmall    ← labelSm      (12px)

  static TextTheme get textTheme => TextTheme(
        displayLarge: headlineXl,
        headlineLarge: headlineLg,
        headlineMedium: headlineMd,
        bodyLarge: bodyLg,
        bodyMedium: bodyMd,
        labelLarge: labelMd,
        labelSmall: labelSm,
      );
}

/// Extension on [TextTheme] to access custom AppTextStyle values easily.
extension AppTextThemeX on TextTheme {
  TextStyle get appHeadlineXl => AppTextStyle.headlineXl;
  TextStyle get appHeadlineLg => AppTextStyle.headlineLg;
  TextStyle get appHeadlineLgMobile => AppTextStyle.headlineLgMobile;
  TextStyle get appHeadlineMd => AppTextStyle.headlineMd;
  TextStyle get appBodyLg => AppTextStyle.bodyLg;
  TextStyle get appBodyMd => AppTextStyle.bodyMd;
  TextStyle get appLabelMd => AppTextStyle.labelMd;
  TextStyle get appLabelSm => AppTextStyle.labelSm;
}