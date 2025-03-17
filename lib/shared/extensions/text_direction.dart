// // 🐦 Flutter imports:
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:bethebest/common/injection/injection.dart';

// import '../../constant/keys.dart';

// extension TextDirectionExtension on String? {
//   TextDirection get textDirection {
//     if (this == null || this!.isEmpty) {
//       return getIt<SharedPreferences>().getString(kLanguage) == "en"
//           ? TextDirection.ltr
//           : TextDirection.rtl;
//     }
//     final char = this![0];
//     if (RegExp(r'[\u0600-\u06FF]').hasMatch(char)) {
//       return TextDirection.rtl; // RTL
//     } else {
//       return TextDirection.ltr; // LTR
//     }
//   }
// }
