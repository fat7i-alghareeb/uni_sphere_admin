// 🌎 Project imports:
import 'package:beamer/beamer.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../core/styles/colors.dart';
import '../imports/imports.dart';

extension Context on BuildContext {
  double _getWidth() {
    return MediaQuery.of(this).size.width;
  }

  double _getHeight() {
    return MediaQuery.of(this).size.height;
  }

  TextTheme _getStyle() {
    return Theme.of(this).textTheme;
  }

  String _route() {
    final uri = currentBeamLocation.state.routeInformation.uri;
    return uri.toString();
  }

  bool _isEnglish() {
    return locale == const Locale("en");
  }

  String get route => _route();

  double get screenWidth => _getWidth();

  double get screenHeight => _getHeight();

  TextTheme get textTheme => _getStyle();

  bool get isEnglish => _isEnglish();
}

extension ColorSchemeColors on BuildContext {
  Color _primaryColor() => Theme.of(this).colorScheme.primary;
  Color _secondaryColor() => Theme.of(this).colorScheme.secondary;
  Color _greyColor() => Theme.of(this).colorScheme.tertiary;
  Color _backgroundColor() => Theme.of(this).colorScheme.surface;
  //  isDarkMode ? "#2F3349".toColor() : Colors.white;
  Color _onBackgroundColor() => Theme.of(this).colorScheme.onSurface;

  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;
  bool get isLightMode => Theme.of(this).brightness == Brightness.light;
  Color get primaryColor => _primaryColor();
  Color get secondaryColor => _secondaryColor();
  Color get greyColor => _greyColor();
  Color get backgroundColor => _backgroundColor();
  Color get onBackgroundColor => _onBackgroundColor();
  Color get textColor => _textColor();
  Color get iconColor => _iconColor();

  // You can add your text style methods here
  TextStyle getTitleTextStyle(TextStyle textStyle) {
    return textStyle.copyWith(
      color: primaryColor,
    );
  }

  Color _textColor() {
    return isDarkMode ? primaryColor : AppColors.black;
  }

  Color _iconColor() {
    return !isDarkMode ? primaryColor : AppColors.white;
  }
}
