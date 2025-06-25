import '../../extensions/string_extension.dart';
import '../../imports/imports.dart';

import '../../../common/constant/app_strings.dart';

class YearHelper {
  static String getYearSubjectsName(int year, BuildContext context) {
    final yearString = year.yearName;
    final subjectsString = AppStrings.subjects;
    final yearSubjectsName = context.isEnglish
        ? "$yearString $subjectsString"
        : "$yearString $subjectsString";
    return yearSubjectsName;
  }
}
