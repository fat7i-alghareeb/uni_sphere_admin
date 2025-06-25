import 'package:provider/provider.dart';

import '../../common/constant/app_strings.dart' show AppStrings;
import '../imports/imports.dart';
import '../states/theme_provider/theme_provider.dart';

class ThemeSwitcher extends StatelessWidget {
  const ThemeSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, _) {
        
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            color: context.backgroundColor,
            boxShadow: [
              BoxShadow(
                color: context.primaryColor.withValues(alpha: .3),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(20.r),
              onTap: () => themeProvider.changeMode(),
              child: Padding(
                padding: REdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          themeProvider.isDarkMode
                              ? Icons.dark_mode_rounded
                              : Icons.light_mode_rounded,
                          color: context.primaryColor,
                          size: 24.r,
                        ),
                        12.horizontalSpace,
                        Text(
                          themeProvider.isDarkMode
                              ? AppStrings.darkMode
                              : AppStrings.lightMode,
                          style: context.textTheme.titleMedium?.copyWith(
                            color: context.textColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        //  12.horizontalSpace,
                      ],
                    ),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      width: 48.w,
                      height: 24.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        color: themeProvider.isDarkMode
                            ? context.primaryColor
                            : context.primaryColor.withValues(alpha: .2),
                      ),
                      child: Stack(
                        children: [
                          AnimatedPositioned(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                            left: themeProvider.isDarkMode ? 24.w : 2.w,
                            top: 2.h,
                            child: Container(
                              width: 20.w,
                              height: 20.h,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: themeProvider.isDarkMode
                                    ? Colors.white
                                    : context.primaryColor,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: .1),
                                    blurRadius: 4,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
