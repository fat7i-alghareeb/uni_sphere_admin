import 'package:google_fonts/google_fonts.dart';

import '../../shared/imports/imports.dart';

/// A collection of text styles used throughout the app.
/// Follows Material Design 3 text style guidelines with customizations.
class AppTextTheme {
  AppTextTheme._();

  static TextTheme get textTheme {
    final base = GoogleFonts.almaraiTextTheme();

    return base.copyWith(
      displayLarge: _displayLarge,
      displayMedium: _displayMedium,
      displaySmall: _displaySmall,
      headlineLarge: _headlineLarge,
      headlineMedium: _headlineMedium,
      headlineSmall: _headlineSmall,
      titleLarge: _titleLarge,
      titleMedium: _titleMedium,
      titleSmall: _titleSmall,
      bodyLarge: _bodyLarge,
      bodyMedium: _bodyMedium,
      bodySmall: _bodySmall,
      labelLarge: _labelLarge,
      labelMedium: _labelMedium,
      labelSmall: _labelSmall,
    );
  }

  // Display styles
  static TextStyle get _displayLarge => GoogleFonts.almarai(
        fontSize: 57.sp,
        fontWeight: FontWeight.w700,
      );

  static TextStyle get _displayMedium => GoogleFonts.almarai(
        fontSize: 48.sp,
        fontWeight: FontWeight.w500,
      );

  static TextStyle get _displaySmall => GoogleFonts.almarai(
        fontSize: 36.sp,
        fontWeight: FontWeight.w500,
      );

  // Headline styles
  static TextStyle get _headlineLarge => GoogleFonts.almarai(
        fontSize: 32.sp,
        fontWeight: FontWeight.w600,
      );

  static TextStyle get _headlineMedium => GoogleFonts.almarai(
        fontSize: 28.sp,
        fontWeight: FontWeight.w600,
      );

  static TextStyle get _headlineSmall => GoogleFonts.almarai(
        fontSize: 24.sp,
        fontWeight: FontWeight.w600,
      );

  // Title styles
  static TextStyle get _titleLarge => GoogleFonts.almarai(
        fontSize: 22.sp,
        fontWeight: FontWeight.w700,
      );

  static TextStyle get _titleMedium => GoogleFonts.almarai(
        fontSize: 16.sp,
        fontWeight: FontWeight.w700,
      );

  static TextStyle get _titleSmall => GoogleFonts.almarai(
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
      );

  // Body styles
  static TextStyle get _bodyLarge => GoogleFonts.almarai(
        fontSize: 16.sp,
      );

  static TextStyle get _bodyMedium => GoogleFonts.almarai(
        fontSize: 14.sp,
      );

  static TextStyle get _bodySmall => GoogleFonts.almarai(
        fontSize: 13.sp,
      );

  // Label styles
  static TextStyle get _labelLarge => GoogleFonts.almarai(
        fontSize: 14.sp,
        fontWeight: FontWeight.w700,
      );

  static TextStyle get _labelMedium => GoogleFonts.almarai(
        fontSize: 12.sp,
      );

  static TextStyle get _labelSmall => GoogleFonts.almarai(
        fontSize: 11.sp,
      );
}

/// Extension methods for [TextStyle] to make it easier to modify styles
extension TextStyleExtension on TextStyle {
  /// Returns a copy of this [TextStyle] with the given color
  TextStyle withColor(Color color) => copyWith(color: color);

  /// Returns a copy of this [TextStyle] with the given font weight
  TextStyle withWeight(FontWeight weight) => copyWith(fontWeight: weight);

  /// Returns a copy of this [TextStyle] with the given font size
  TextStyle withSize(double size) => copyWith(fontSize: size);

  /// Returns a copy of this [TextStyle] with the given height
  TextStyle withHeight(double height) => copyWith(height: height);

  /// Returns a copy of this [TextStyle] with the given letter spacing
  TextStyle withLetterSpacing(double spacing) =>
      copyWith(letterSpacing: spacing);
}

/// Extension methods for [BuildContext] to easily access text styles
extension TextThemeExtension on BuildContext {
  /// Returns the text theme from the current theme
  TextTheme get textTheme => Theme.of(this).textTheme;

  /// Creates a text style with the given parameters
  TextStyle createTextStyle({
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
    double? height,
    double? letterSpacing,
  }) {
    return GoogleFonts.almarai(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      height: height,
      letterSpacing: letterSpacing,
    );
  }
}
