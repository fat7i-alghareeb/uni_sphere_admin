import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../shared/imports/imports.dart';
import 'app_text_theme.dart';
import 'colors.dart';

class AppThemes {
  AppThemes._();

  /// Light theme configuration for the app.
  static ThemeData lightThemeData({Color? primaryColor}) {
    return ThemeData(
      indicatorColor: AppColors.lightPrimary,
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: AppColors.lightPrimary,
        linearMinHeight: 20.r,
      ),
      cardColor: AppColors.lightPrimary.withOpacity(0.08),
      dialogBackgroundColor: Colors.white,
      colorScheme: ColorScheme.fromSeed(
        brightness: Brightness.light,
        surface: Colors.white,
        seedColor: primaryColor ?? AppColors.lightPrimary,
        primary: primaryColor ?? AppColors.lightPrimary,
        secondary: AppColors.darkPrimary,
        tertiary: const Color(0xff4B465C),
        onPrimary: Colors.white,
      ),
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          padding: REdgeInsets.all(0),
        ),
      ),
      menuTheme: const MenuThemeData(
        style: MenuStyle(
          backgroundColor: WidgetStatePropertyAll(Colors.white),
          shadowColor: WidgetStatePropertyAll(AppColors.lightPrimary),
        ),
      ),
      useMaterial3: true,
      scaffoldBackgroundColor: Colors.white,
      tabBarTheme: TabBarTheme(
        labelColor: primaryColor ?? AppColors.lightPrimary,
        unselectedLabelColor: (primaryColor ?? AppColors.lightPrimary).withOpacity(0.4),
      ),
      datePickerTheme: const DatePickerThemeData(
        backgroundColor: Colors.white,
        headerBackgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        confirmButtonStyle: ButtonStyle(
          textStyle: WidgetStatePropertyAll(
            TextStyle(color: Colors.black),
          ),
          backgroundColor: WidgetStatePropertyAll(Colors.white),
        ),
        cancelButtonStyle: ButtonStyle(
          textStyle: WidgetStatePropertyAll(
            TextStyle(color: Colors.black),
          ),
          backgroundColor: WidgetStatePropertyAll(Colors.white),
        ),
      ),
      textTheme: AppTextTheme.textTheme,
      brightness: Brightness.light,
      fontFamily: GoogleFonts.almarai().fontFamily,
      primaryColor: primaryColor ?? AppColors.lightPrimary,
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: AppColors.lightPrimary,
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
    return ThemeData(
      brightness: Brightness.dark,
      useMaterial3: true,
      primaryColor: primaryColor ?? AppColors.darkPrimary,
      fontFamily: GoogleFonts.almarai().fontFamily,
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: AppColors.lightPrimary,
      ),
      appBarTheme: const AppBarTheme(
        elevation: 0,
        iconTheme: IconThemeData(color: AppColors.white),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),

      textTheme: AppTextTheme.textTheme,
      scaffoldBackgroundColor: const Color(0xff25293c),
      colorScheme: ColorScheme.fromSeed(
        brightness: Brightness.dark,
        surface: const Color(0xff25293c),
        seedColor: primaryColor ?? AppColors.darkPrimary,
        primary: primaryColor ?? AppColors.darkPrimary,
        secondary: AppColors.lightPrimary,
        tertiary: Colors.white,
        onPrimary: const Color(0xff25293c),
      ),
    );
  }
}