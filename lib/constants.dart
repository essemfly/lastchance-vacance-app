import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Constants {
  static const fontFamily = "SpoqaHanSansNeo";
  static const Color primaryColor = Color(0xFFE8AA8B);
  static const Color secondaryColor = Color(0xFF5E616A);
  static const Color tertiaryColor = Color(0xFFFFFFFF);
  static const Color alternate = Color(0xFFE1EDF9);
  static const Color primaryBackground = Color(0xFFF9F3E6);
  static const Color secondaryBackground = Color(0xFFFFFFFF);
  static const Color primaryText = Color(0xFF14181B);
  static const Color secondaryText = Color(0xFF95A1AC);

  static const Color cultured = Color(0xFFF1F4F8);
  static const Color redApple = Color(0xFFFC4253);
  static const Color celadon = Color(0xFF96E6B3);
  static const Color turquoise = Color(0xFF39D2C0);
  static const Color gunmetal = Color(0xFF262D34);
  static const Color grayIcon = Color(0xFF95A1AC);
  static const Color darkText = Color(0xFF1E2429);
  static const Color dark600 = Color(0xFF14181B);
  static const Color gray600 = Color(0xFF57636C);
  static const Color lineGray = Color(0xFFE1EDF9);
  static const Color primaryBtnText = Color(0xFFFFFFFF);
  static const Color lineColor = Color(0xFFE0E3E7);
  static const Color gray200 = Color(0xFFDBE2E7);
  static const Color black600 = Color(0xFF090F13);
  static const Color tertiary400 = Color(0xFF39D2C0);
  static const Color textColor = Color(0xFF1E2429);
  static const Color backgroundComponents = Color(0xFF1D2428);

  static const String defaultImageUrl = 'https://picsum.photos/seed/1/300';
}

class CustomTypography {
  static String get title1Family => 'Urbanist';
  static TextStyle get title1 => GoogleFonts.getFont(
        'Urbanist',
        color: Constants.primaryText,
        fontWeight: FontWeight.w600,
        fontSize: 24,
      );
  static String get title2Family => 'Urbanist';
  static TextStyle get title2 => GoogleFonts.getFont(
        'Urbanist',
        color: Constants.primaryText,
        fontWeight: FontWeight.w500,
        fontSize: 22,
      );
  static String get title3Family => 'Urbanist';
  static TextStyle get title3 => GoogleFonts.getFont(
        'Urbanist',
        color: Constants.primaryText,
        fontWeight: FontWeight.bold,
        fontSize: 20,
      );
  static String get subtitle1Family => 'Urbanist';
  static TextStyle get subtitle1 => GoogleFonts.getFont(
        'Urbanist',
        color: Constants.secondaryText,
        fontWeight: FontWeight.w500,
        fontSize: 18,
      );
  static String get subtitle2Family => 'Urbanist';
  static TextStyle get subtitle2 => GoogleFonts.getFont(
        'Urbanist',
        color: Constants.primaryText,
        fontWeight: FontWeight.w600,
        fontSize: 16,
      );
  static String get bodyText1Family => 'Urbanist';
  static TextStyle get bodyText1 => GoogleFonts.getFont(
        'Urbanist',
        color: Constants.secondaryText,
        fontWeight: FontWeight.w500,
        fontSize: 14,
      );
  static String get bodyText2Family => 'Urbanist';
  static TextStyle get bodyText2 => GoogleFonts.getFont(
        'Urbanist',
        color: Constants.primaryText,
        fontWeight: FontWeight.w500,
        fontSize: 14,
      );
}

extension TextStyleHelper on TextStyle {
  TextStyle override({
    String? fontFamily,
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    double? letterSpacing,
    FontStyle? fontStyle,
    bool useGoogleFonts = true,
    TextDecoration? decoration,
    double? lineHeight,
  }) =>
      useGoogleFonts
          ? GoogleFonts.getFont(
              fontFamily!,
              color: color ?? this.color,
              fontSize: fontSize ?? this.fontSize,
              letterSpacing: letterSpacing ?? this.letterSpacing,
              fontWeight: fontWeight ?? this.fontWeight,
              fontStyle: fontStyle ?? this.fontStyle,
              decoration: decoration,
              height: lineHeight,
            )
          : copyWith(
              fontFamily: fontFamily,
              color: color,
              fontSize: fontSize,
              letterSpacing: letterSpacing,
              fontWeight: fontWeight,
              fontStyle: fontStyle,
              decoration: decoration,
              height: lineHeight,
            );
}
