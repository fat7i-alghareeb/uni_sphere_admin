import 'package:uni_sphere_admin/common/constant/app_strings.dart';
import 'package:uni_sphere_admin/shared/imports/imports.dart';

class EmptyMaterialsCard extends StatelessWidget {
  const EmptyMaterialsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: REdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.cardColor,
        borderRadius: BorderRadius.circular(22.r),
        boxShadow: [
          BoxShadow(
            color: context.primaryColor.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.materials,
            style:
                context.textTheme.titleMedium!.withColor(context.primaryColor),
          ),
          16.verticalSpace,
          Center(
            child: Column(
              children: [
                Icon(
                  Icons.folder_open,
                  size: 48.r,
                  color: context.greyColor.withValues(alpha: 0.5),
                ),
                8.verticalSpace,
                Text(
                  AppStrings.noMaterialsAvailable,
                  style: context.textTheme.bodyMedium!.copyWith(
                    color: context.greyColor.withValues(alpha: 0.7),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
