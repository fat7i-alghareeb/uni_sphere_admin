// ignore_for_file: public_member_api_docs, sort_constructors_first

// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:

class NavBarProvider extends ChangeNotifier {
  late PageController pageController;
  int selectedIndex = 0;
  NavBarProvider() {
    pageController = PageController();
  }

  void changeSelected(int index) {
    selectedIndex = index;
    pageController.jumpToPage(index);
    notifyListeners();
  }
}
