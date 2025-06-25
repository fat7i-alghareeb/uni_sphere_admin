// 🐦 Flutter imports:
import 'package:flutter/material.dart';
import 'package:uni_sphere_admin/shared/extensions/context_extension.dart';
import '../../shared/extensions/string_extension.dart';

/// A comprehensive color system for the application.
/// Follows a systematic approach to color organization and naming.
class AppColors {
  AppColors._();

  // Base Colors
  static const Color transparent = Colors.transparent;
  static const Color white = Colors.white;
  static const Color black = Colors.black;

  // Primary Colors
  static const Color lightPrimary = Color(0xFF4A487B);
  static const Color darkPrimary = Color(0xff4A487B);
  static const Color onPrimaryLight = Color(0xFF25293C);
  static const Color onPrimaryDark = Color(0xFFF6F6FD);

  // Semantic Colors
  static const Color danger = Color(0xFFF44336);
  static const Color success = Color(0xff28C76F);
  static const Color warning = Color(0xFFF6CE2C);
  static const Color info = Color(0xFF6A9B72);

  // Background Colors
  static const Color lightBackground = Color(0xFFF0F0F8);
  static const Color darkBackground = Color(0xFF1F1E21);
  static const Color sugar = Color(0xFFF8F7F7);
  static const Color lightShimmerColor = Color.fromARGB(255, 152, 152, 152);
  static const Color darkShimmerColor = Color.fromARGB(255, 111, 111, 111);
  static const Color darkCardColor = Color.fromARGB(255, 35, 34, 37);
  static const Color lightCardColor = Color.fromARGB(255, 247, 247, 252);
  static const Color lightGreyColor = Color.fromARGB(255, 146, 146, 146);
  static const Color darkGreyColor = Color.fromARGB(255, 95, 95, 95);
  // Text Colors

  static const Color textPrimary = Color(0xFF4B465C);
  static const Color textSecondary = Color(0xFF8B8B8B);

  // Status Colors
  static const Color red = Color(0xFFF44336);
  static const Color blue = Color(0xff0055F9);
  static const Color grey = Color(0xFF4B465C);
  static const Color green = Color(0xff28C76F);

  // Gradients
  static LinearGradient primaryGradient(BuildContext context) => LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          context.primaryColor,
          Color.fromARGB(255, 138, 136, 206),
        ],
      );

  static final LinearGradient secondaryGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      warning.withValues(alpha: 0.5),
      warning,
    ],
  );

  static const LinearGradient dangerGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFFF08182),
      danger,
    ],
  );

  static const LinearGradient successGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xff48DA89),
      success,
    ],
  );

  static final LinearGradient neutralGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      "#CBC6C6".toColor(),
      "#8B8B8B".toColor(),
    ],
  );

  // Shadows
  static List<BoxShadow> primaryShadow(BuildContext context) => [
        BoxShadow(
          offset: const Offset(0, 2),
          blurRadius: 8,
          spreadRadius: 0,
          color: Colors.black.withValues(alpha: 0.17),
        ),
      ];

  static const List<BoxShadow> greyShadow = [
    BoxShadow(
      offset: Offset(0, 2),
      blurRadius: 4,
      spreadRadius: 0,
      color: Color(0x4DA5A3AE),
    ),
  ];

  static List<BoxShadow> secondaryShadow(BuildContext context) => [
        BoxShadow(
          offset: const Offset(0, 2),
          blurRadius: 8,
          spreadRadius: 0,
          color: Colors.black.withValues(alpha: 0.17),
        ),
      ];

  static List<BoxShadow> successShadow(BuildContext context) => [
        BoxShadow(
          offset: const Offset(0, 2),
          blurRadius: 8,
          spreadRadius: 0,
          color: Colors.black.withValues(alpha: 0.17),
        ),
      ];

  static List<BoxShadow> dangerShadow() => [
        BoxShadow(
          offset: const Offset(0, 2),
          blurRadius: 8,
          spreadRadius: 0,
          color: Colors.black.withValues(alpha: 0.17),
        ),
      ];
  static const List<BoxShadow> blueShadow = [
    BoxShadow(
      offset: Offset(0, 4),
      blurRadius: 16,
      spreadRadius: 0,
      color: Color(0x73273C5B),
    ),
  ];

  static const List<BoxShadow> brownShadow = [
    BoxShadow(
      offset: Offset(0, 2),
      blurRadius: 3,
      spreadRadius: 0,
      color: Color(0x4DCE6E17),
    ),
  ];

  static const List<BoxShadow> bottomSheetCardShadow = [
    BoxShadow(
      offset: Offset(0, 4),
      blurRadius: 18,
      spreadRadius: 0,
      color: Color(0x334B465C),
    ),
  ];
  static List<BoxShadow> coloredShadow(Color color) {
    return [
      BoxShadow(
        offset: const Offset(0, 4),
        blurRadius: 16,
        spreadRadius: 0,
        color: color,
      )
    ];
  }
}
