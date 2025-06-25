import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/imports/imports.dart';
import 'colors.dart';

/// A collection of theme configurations for the app.
/// Provides both light and dark theme variants with proper text theming.
class AppThemes {
  AppThemes._();

  /// Light theme configuration for the app.
  static ThemeData lightThemeData({Color? primaryColor}) {
    final colorScheme = _createColorScheme(
      primaryColor: primaryColor ?? AppColors.lightPrimary,
      isDark: false,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      textTheme: AppTextTheme.textTheme,
      fontFamily: GoogleFonts.almarai().fontFamily,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.lightBackground,
      cardColor: colorScheme.primary.withValues(alpha: 0.08),
      indicatorColor: colorScheme.primary,
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: colorScheme.primary,
        linearMinHeight: 20.r,
      ),
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          padding: REdgeInsets.all(0),
        ),
      ),
      menuTheme: MenuThemeData(
        style: MenuStyle(
          backgroundColor: const WidgetStatePropertyAll(Colors.white),
          shadowColor: WidgetStatePropertyAll(colorScheme.primary),
        ),
      ),
      tabBarTheme: TabBarTheme(
        labelColor: colorScheme.primary,
        unselectedLabelColor: colorScheme.primary.withValues(alpha: 0.4),
      ),
      datePickerTheme: DatePickerThemeData(
        backgroundColor: Colors.white,
        headerBackgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        confirmButtonStyle: ButtonStyle(
          textStyle: WidgetStatePropertyAll(
            AppTextTheme.textTheme.labelLarge,
          ),
          backgroundColor: const WidgetStatePropertyAll(Colors.white),
        ),
        cancelButtonStyle: ButtonStyle(
          textStyle: WidgetStatePropertyAll(
            AppTextTheme.textTheme.labelLarge,
          ),
          backgroundColor: const WidgetStatePropertyAll(Colors.white),
        ),
      ),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: colorScheme.primary,
      ),
      appBarTheme: AppBarTheme(
        elevation: 0,
        foregroundColor: AppColors.black,
        titleTextStyle: AppTextTheme.textTheme.headlineLarge,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        iconTheme: IconThemeData(color: AppColors.white, size: 22.r),
        color: Colors.transparent,
      ),
    );
  }

  /// Dark theme configuration for the app.
  static ThemeData darkThemeData({Color? primaryColor}) {
    final colorScheme = _createColorScheme(
      primaryColor: primaryColor ?? AppColors.darkPrimary,
      isDark: true,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      textTheme: AppTextTheme.textTheme,
      fontFamily: GoogleFonts.almarai().fontFamily,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.darkBackground,
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: colorScheme.primary,
      ),
      appBarTheme: const AppBarTheme(
        elevation: 0,
        iconTheme: IconThemeData(color: AppColors.white),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
    );
  }

  /// Creates a color scheme based on the primary color and theme mode
  static ColorScheme _createColorScheme({
    required Color primaryColor,
    required bool isDark,
  }) {
    return ColorScheme.fromSeed(
      brightness: isDark ? Brightness.dark : Brightness.light,
      surface: isDark ? AppColors.darkBackground : AppColors.lightBackground,
      onSurface: isDark ? AppColors.lightBackground : AppColors.darkBackground,
      seedColor: primaryColor,
      primary: primaryColor,
      secondary: isDark ? AppColors.lightPrimary : AppColors.darkPrimary,
      secondaryContainer:
          isDark ? AppColors.darkCardColor : AppColors.lightCardColor,
      tertiary: isDark ? AppColors.darkGreyColor : AppColors.lightGreyColor,
      onPrimary: isDark ? const Color(0xff25293c) : Colors.white,
      onTertiary:
          isDark ? AppColors.darkShimmerColor : AppColors.lightShimmerColor,
    );
  }
}
