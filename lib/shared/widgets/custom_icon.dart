import 'dart:ui';

import '../imports/imports.dart';

class CustomIcon extends StatelessWidget {
  const CustomIcon({super.key, required this.iconPath, this.onTap});
  final IconData iconPath;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipOval(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            width: 40.r,
            height: 40.r,
            // padding: REdgeInsets.all(8),
            decoration: BoxDecoration(
              color: context.onBackgroundColor.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              iconPath,
              color: context.backgroundColor,
              size: 20.r,
            ),
          ),
        ),
      ),
    );
  }
}
