// 🌎 Project imports:
import 'package:beamer/beamer.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../core/styles/colors.dart';
import '../imports/imports.dart';

/// Extension methods for [BuildContext] to access common properties and utilities
extension Context on BuildContext {
  /// Returns the current screen width
  double _getWidth() => MediaQuery.of(this).size.width;

  /// Returns the current screen height
  double _getHeight() => MediaQuery.of(this).size.height;

  /// Returns the current text theme
  // TextTheme _getStyle() => Theme.of(this).textTheme;

  /// Returns the current route path
  String _route() {
    final uri = currentBeamLocation.state.routeInformation.uri;
    return uri.toString();
  }

  /// Returns whether the current locale is English
  bool _isEnglish() => locale == const Locale("en");

  /// Current route path
  String get route => _route();

  /// Current screen width
  double get screenWidth => _getWidth();

  /// Current screen height
  double get screenHeight => _getHeight();

  /// Current text theme
  // TextTheme get textTheme => _getStyle();

  /// Whether the current locale is English
  bool get isEnglish => _isEnglish();
}

/// Extension methods for [BuildContext] to access theme colors and styles
extension ColorSchemeColors on BuildContext {
  /// Returns the primary color from the current theme
  Color _primaryColor() => Theme.of(this).colorScheme.primary;

  /// Returns the secondary color from the current theme
  Color _secondaryColor() => Theme.of(this).colorScheme.secondary;

  /// Returns the tertiary color from the current theme
  Color _cardColor() => Theme.of(this).colorScheme.secondaryContainer;

  /// Returns the grey color from the current theme
  Color _greyColor() => Theme.of(this).colorScheme.tertiary;

  /// Returns the surface color from the current theme
  Color _backgroundColor() => Theme.of(this).colorScheme.surface;

  /// Returns the onSurface color from the current theme
  Color _onBackgroundColor() => Theme.of(this).colorScheme.onSurface;

  /// Returns the shimmer color from the current theme
  Color _shimmerColor() => Theme.of(this).colorScheme.onTertiary;

  /// Returns the light primary color from the current theme
  Color _lightPrimaryColor() => Theme.of(this).cardColor;

  /// Whether the current theme is dark mode
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;

  /// Whether the current theme is light mode
  bool get isLightMode => Theme.of(this).brightness == Brightness.light;

  /// Primary color from the current theme
  Color get primaryColor => _primaryColor();

  /// Secondary color from the current theme
  Color get secondaryColor => _secondaryColor();

  /// Grey color from the current theme
  Color get greyColor => _greyColor();

  /// Tertiary color from the current theme
  Color get cardColor => _cardColor();

  /// Shimmer color from the current theme
  Color get shimmerColor => _shimmerColor();

  /// Surface color from the current theme
  Color get backgroundColor => _backgroundColor();

  /// Light primary color from the current theme
  Color get lightPrimaryColor => _lightPrimaryColor();

  /// OnSurface color from the current theme
  Color get onBackgroundColor => _onBackgroundColor();

  /// Text color based on the current theme
  Color get textColor => _textColor();

  /// Icon color based on the current theme
  Color get iconColor => _iconColor();

  /// Returns a text style with the primary color
  TextStyle getTitleTextStyle(TextStyle textStyle) {
    return textStyle.copyWith(
      color: primaryColor,
    );
  }

  /// Returns the appropriate text color based on the theme
  Color _textColor() {
    return isDarkMode ? primaryColor : AppColors.black;
  }

  /// Returns the appropriate icon color based on the theme
  Color _iconColor() {
    return !isDarkMode ? primaryColor : AppColors.white;
  }

  /// Creates a text style with the given parameters
  TextStyle createTextStyle({
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
    double? height,
    double? letterSpacing,
  }) {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color ?? textColor,
      height: height,
      letterSpacing: letterSpacing,
      fontFamily: Theme.of(this).textTheme.bodyLarge?.fontFamily,
    );
  }
}
