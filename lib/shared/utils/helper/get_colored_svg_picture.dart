import '../../imports/imports.dart';

SvgPicture getColoredSvgPicture({
  required String assetName,
  Color? color,
  double? width,
  double? height,
  BoxFit fit = BoxFit.contain,
}) {
  return SvgPicture.asset(
    assetName,
    width: width?.r,
    height: height?.r,
    fit: fit,
    colorFilter: color != null
        ? ColorFilter.mode(
            color,
            BlendMode.srcIn,
          )
        : null,
  );
}
