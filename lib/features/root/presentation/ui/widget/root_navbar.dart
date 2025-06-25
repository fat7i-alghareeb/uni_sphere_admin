// 📦 Package imports:
import 'dart:ui';

// 🌎 Project imports:
import 'package:provider/provider.dart';

import '../../../../../shared/imports/imports.dart';
import '../../../../../shared/utils/helper/get_colored_svg_picture.dart';
import '../../state/provider/nav_bar_provider.dart';

/// A custom navigation bar widget that provides a glass-morphism effect
/// with animated transitions between selected items.
class RootNavbar extends StatelessWidget {
  RootNavbar({
    super.key,
  });

  /// List of navigation items with their respective icons
  late final List<NavItem> _navItems = [
    NavItem(iconPath: Assets.icons.home, index: 0),
    NavItem(iconPath: Assets.icons.subjects, index: 1),
    NavItem(iconPath: Assets.icons.timeTable, index: 2),
    NavItem(iconPath: Assets.icons.announcement, index: 3),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<NavBarProvider>(
      builder: (context, provider, _) =>
          _buildNavBarContainer(context, provider),
    );
  }

  Widget _buildNavBarContainer(BuildContext context, NavBarProvider provider) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(30.r),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(
              padding: REdgeInsets.symmetric(horizontal: 5, vertical: 4),
              decoration: BoxDecoration(
                color: context.onBackgroundColor.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(30.r),
              ),
              child: Row(
                children: _navItems
                    .map((item) => _buildNavItem(
                          context: context,
                          item: item,
                          isSelected: provider.selectedIndex == item.index,
                          onTap: provider.changeSelected,
                        ))
                    .toList(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNavItem({
    required BuildContext context,
    required NavItem item,
    required bool isSelected,
    required void Function(int index) onTap,
  }) {
    return GestureDetector(
      onTap: () => onTap(item.index),
      child: Padding(
        padding: REdgeInsets.symmetric(horizontal: 1.2),
        child: ClipOval(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: 50.h,
              height: 50.w,
              padding: REdgeInsets.all(13),
              decoration: BoxDecoration(
                color: context.onBackgroundColor
                    .withValues(alpha: isSelected ? 1 : 0.15),
                shape: BoxShape.circle,
              ),
              child: getColoredSvgPicture(
                assetName: item.iconPath,
                color: isSelected
                    ? context.backgroundColor
                    : context.onBackgroundColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Represents a navigation item with its icon and index
class NavItem {
  final String iconPath;
  final int index;

  NavItem({
    required this.iconPath,
    required this.index,
  });
}
