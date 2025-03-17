// 🐦 Flutter imports:

import '../../shared/extensions/string_extension.dart'; 

import '../../shared/imports/imports.dart';

class AppColors {
  AppColors._();

  static const Color transparent = Colors.transparent;
  static const Color lightPrimary = Color(0xff406051);
  static const Color darkPrimary = Color(0xffCE6E17);
  static const Color danger = Color(0xFFEA5455);
  static const Color success = Color(0xff28C76F);
  static const Color secondary = Color(0xFFCE6E17);

  static const Color red = Color(0xffEA5455);
  static const Color blue = Color(0xff0055F9);
  static const Color grey = Color(0xFF4B465C);
  static const Color green = Color(0xff28C76F);
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color sugar = Color(0xFFF8F7F7);

  static LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      lightPrimary,
      "#B1E5D3".toColor(),
    ],
  );
  static LinearGradient secondaryGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      secondary.withOpacity(0.5),
      secondary,
    ],
  );

  static LinearGradient dangerGradient = const LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFFF08182),
      danger,
    ],
  );
  static LinearGradient greenGradient = const LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xff48DA89),
      Color(0xFF28C76F),
    ],
  );
  static LinearGradient greyGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      "#CBC6C6".toColor(),
      "#8B8B8B".toColor(),
    ],
  );

  // //* shadow
  // static List<BoxShadow> primaryShadow(BuildContext context) {
  //   return [
  //     BoxShadow(
  //       offset: const Offset(0, 4),
  //       blurRadius: 16,
  //       spreadRadius: 0,
  //       color: "#331105".toColor().withOpacity(context.isDarkMode ? .45 : .15),
  //     )
  //   ];
  // }

  static List<BoxShadow> greyShadow = [
    BoxShadow(
      offset: const Offset(0, 2),
      blurRadius: 4,
      spreadRadius: 0,
      color: "#A5A3AE".toColor().withOpacity(.3),
    )
  ];
  static List<BoxShadow> blueShadow = [
    BoxShadow(
      offset: const Offset(0, 4),
      blurRadius: 16,
      spreadRadius: 0,
      color: "#273C5B".toColor().withOpacity(0.45),
    )
  ];
  static List<BoxShadow> brownShadow = [
    BoxShadow(
      offset: const Offset(0, 2),
      blurRadius: 3,
      spreadRadius: 0,
      color: "#CE6E17".toColor().withOpacity(0.30),
    )
  ];
  static List<BoxShadow> bottomSheetCardShadow = [
    BoxShadow(
      offset: const Offset(0, 4),
      blurRadius: 18,
      spreadRadius: 0,
      color: "#4B465C".toColor().withOpacity(0.2),
    )
  ];
}
