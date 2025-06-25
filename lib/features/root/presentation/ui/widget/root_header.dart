// 🐦 Flutter imports:

// 🌎 Project imports:
import '../../../../../shared/imports/imports.dart';
import '../../../../../shared/utils/helper/get_colored_svg_picture.dart';

class RootHeader extends StatelessWidget {
  const RootHeader({
    super.key,
    required this.userName,
    this.unreadNotifications = 10,
    required this.scaffoldKey,
  });

  final String userName;
  final int unreadNotifications;
  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: REdgeInsets.only(
        left: AppConstants.horizontalScreensPadding / 2,
        right: AppConstants.horizontalScreensPadding / 2,
        top: AppConstants.headerPadding,
        bottom: 10,
      ),
      child: Row(
        children: [
          // Left Side: Avatar and Name
          Expanded(
            child: Row(
              children: [
                // Avatar with modern design
                getColoredSvgPicture(
                  assetName: Assets.images.avatarBoy,
                  width: 40,
                  height: 40,
                ),

                12.horizontalSpace,
                // User Info
                Text(
                  userName,
                  style: context.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          // Right Side: Icons
          _buildIcon(
            context: context,
            icon: Assets.icons.drawer,
            onTap: () => scaffoldKey.currentState?.openEndDrawer(),
          ),
        ],
      ),
    );
  }

  Widget _buildIcon({
    required BuildContext context,
    required String icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: getColoredSvgPicture(
        assetName: icon,
        width: 22,
        height: 22,
        color: context.onBackgroundColor,
      ),
    );
  }
}
