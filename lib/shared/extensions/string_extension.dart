// 🎯 Dart imports:
import 'dart:ui';

import '../../common/constant/app_strings.dart';

extension HexColor on String {
  Color toColor() {
    String hex = replaceAll("#", "");
    if (hex.length == 6) {
      hex = "FF$hex";
    }
    return Color(int.parse(hex, radix: 16));
  }
}

extension WeekdayShort on int {
  String get weekdayShort {
    List<String> days = [
      AppStrings.sun,
      AppStrings.mon,
      AppStrings.tue,
      AppStrings.wed,
      AppStrings.thu,
      AppStrings.fri,
      AppStrings.sat
    ];
    return days[this % 7];
  }

  String get monthName {
    final monthNames = [
      AppStrings.january,
      AppStrings.february,
      AppStrings.march,
      AppStrings.april,
      AppStrings.may,
      AppStrings.june,
      AppStrings.july,
      AppStrings.august,
      AppStrings.september,
      AppStrings.october,
      AppStrings.november,
      AppStrings.december
    ];
    return monthNames[this - 1];
  }

  String get semesterName {
    final semesterNames = [
      AppStrings.firstSemester,
      AppStrings.secondSemester,
      AppStrings.thirdSemester,
      AppStrings.fourthSemester,
      AppStrings.fifthSemester,
      AppStrings.sixthSemester,
      AppStrings.seventhSemester,
      AppStrings.eighthSemester,
      AppStrings.ninthSemester,
    ];
    return semesterNames[this - 1];
  }

  String get yearName {
    final yearNames = [
      AppStrings.firstYear,
      AppStrings.secondYear,
      AppStrings.thirdYear,
      AppStrings.fourthYear,
      AppStrings.fifthYear,
      AppStrings.sixthYear,
      AppStrings.seventhYear,
      AppStrings.eighthYear,
      AppStrings.ninthYear,
      AppStrings.tenthYear,
      AppStrings.eleventhYear,
      AppStrings.twelfthYear,
      AppStrings.thirteenthYear
    ];
    return yearNames[this - 1];
  }

  String get ordinalString {
    final ordinalNames = [
      AppStrings.first,
      AppStrings.second,
      AppStrings.third,
      AppStrings.fourth,
      AppStrings.fifth,
      AppStrings.sixth,
      AppStrings.seventh,
      AppStrings.eighth,
      AppStrings.ninth,
      AppStrings.tenth,
      AppStrings.eleventh,
      AppStrings.twelfth,
      AppStrings.thirteenth
    ];
    return ordinalNames[this - 1];
  }
}
