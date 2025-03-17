import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/constants/key_constants.dart';
import '../../../core/injection/injection.dart';
import '../../imports/imports.dart';

class ThemeProvider with ChangeNotifier {
  bool _isDarkMode = false;
  bool get isDarkMode => _isDarkMode;

  void initMode(bool isDarkMode) {
    _isDarkMode = isDarkMode;
    notifyListeners();
  }

  void loadTheme() {
    _isDarkMode = (getIt<SharedPreferences>().getBool(kIsDarkMode) ?? false);
    notifyListeners();
  }

  void changeMode({bool? isDarkMode}) {
    _isDarkMode = (isDarkMode ?? !_isDarkMode);
    getIt<SharedPreferences>().setBool(kIsDarkMode, _isDarkMode);
    notifyListeners();
  }
}
