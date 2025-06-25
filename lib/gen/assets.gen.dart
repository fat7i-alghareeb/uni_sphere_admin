/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/announcement.svg
  String get announcement => 'assets/icons/announcement.svg';

  /// File path: assets/icons/callender.svg
  String get callender => 'assets/icons/callender.svg';

  /// File path: assets/icons/clock.svg
  String get clock => 'assets/icons/clock.svg';

  /// File path: assets/icons/downloadedFile.svg
  String get downloadedFile => 'assets/icons/downloadedFile.svg';

  /// File path: assets/icons/drawer.svg
  String get drawer => 'assets/icons/drawer.svg';

  /// File path: assets/icons/home.svg
  String get home => 'assets/icons/home.svg';

  /// File path: assets/icons/lecture_hall_icon.svg
  String get lectureHallIcon => 'assets/icons/lecture_hall_icon.svg';

  /// File path: assets/icons/notification.svg
  String get notification => 'assets/icons/notification.svg';

  /// File path: assets/icons/subjects.svg
  String get subjects => 'assets/icons/subjects.svg';

  /// File path: assets/icons/timeTable.svg
  String get timeTable => 'assets/icons/timeTable.svg';

  /// List of all assets
  List<String> get values => [
    announcement,
    callender,
    clock,
    downloadedFile,
    drawer,
    home,
    lectureHallIcon,
    notification,
    subjects,
    timeTable,
  ];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/avatar-boy.svg
  String get avatarBoy => 'assets/images/avatar-boy.svg';

  /// File path: assets/images/avatar-girl.svg
  String get avatarGirl => 'assets/images/avatar-girl.svg';

  /// File path: assets/images/pattern1.png
  AssetGenImage get pattern1 =>
      const AssetGenImage('assets/images/pattern1.png');

  /// File path: assets/images/pattern1_white.png
  AssetGenImage get pattern1White =>
      const AssetGenImage('assets/images/pattern1_white.png');

  /// File path: assets/images/pattern2.png
  AssetGenImage get pattern2 =>
      const AssetGenImage('assets/images/pattern2.png');

  /// File path: assets/images/pattern2_white.png
  AssetGenImage get pattern2White =>
      const AssetGenImage('assets/images/pattern2_white.png');

  /// File path: assets/images/pattern_new.png
  AssetGenImage get patternNew =>
      const AssetGenImage('assets/images/pattern_new.png');

  /// File path: assets/images/svgPattern1.svg
  String get svgPattern1 => 'assets/images/svgPattern1.svg';

  /// File path: assets/images/svgPattern2.svg
  String get svgPattern2 => 'assets/images/svgPattern2.svg';

  /// File path: assets/images/test.png
  AssetGenImage get test => const AssetGenImage('assets/images/test.png');

  /// File path: assets/images/test2.png
  AssetGenImage get test2 => const AssetGenImage('assets/images/test2.png');

  /// List of all assets
  List<dynamic> get values => [
    avatarBoy,
    avatarGirl,
    pattern1,
    pattern1White,
    pattern2,
    pattern2White,
    patternNew,
    svgPattern1,
    svgPattern2,
    test,
    test2,
  ];
}

class $AssetsL10nGen {
  const $AssetsL10nGen();

  /// File path: assets/l10n/ar.json
  String get ar => 'assets/l10n/ar.json';

  /// File path: assets/l10n/en.json
  String get en => 'assets/l10n/en.json';

  /// List of all assets
  List<String> get values => [ar, en];
}

class Assets {
  const Assets._();

  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $AssetsL10nGen l10n = $AssetsL10nGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName, {this.size, this.flavors = const {}});

  final String _assetName;

  final Size? size;
  final Set<String> flavors;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.medium,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({AssetBundle? bundle, String? package}) {
    return AssetImage(_assetName, bundle: bundle, package: package);
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
