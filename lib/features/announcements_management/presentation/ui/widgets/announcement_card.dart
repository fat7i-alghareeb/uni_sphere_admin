import 'package:beamer/beamer.dart';
import '../../../../../common/constant/app_strings.dart';
import '../../../../../core/styles/colors.dart';
import '../../../../../shared/imports/imports.dart';
import '../../../../../shared/widgets/custom_network_image.dart';
import '../../../../../shared/extensions/date_time_extension.dart';
import '../../../domain/entities/announcement_entity.dart';
import '../screens/announcement_details_screen.dart';

class AnnouncementCard extends StatelessWidget {
  final AnnouncementEntity announcementEntity;

  const AnnouncementCard({
    super.key,
    required this.announcementEntity,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        debugPrint(
            '🔍 Navigating to announcement details: ${announcementEntity.id}');
        context.beamToNamed(
          AnnouncementDetailsScreen.pagePath,
          data: announcementEntity,
        );
      },
      child: Container(
        margin: REdgeInsets.only(bottom: 22.h),
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: context.cardColor,
          borderRadius: BorderRadius.circular(22.r),
          boxShadow: AppColors.primaryShadow(context),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image section
            if (announcementEntity.image?.isNotEmpty ?? false) ...[
              SizedBox(
                width: double.infinity,
                height: 200.h,
                child: CustomNetworkImage(
                  imageUrl: announcementEntity.image!.first,
                  fit: BoxFit.cover,
                ),
              ),
            ],

            // Content section
            Padding(
              padding: REdgeInsets.all(22.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    announcementEntity.title,
                    style: context.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: context.textColor,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  12.verticalSpace,

                  // Description
                  Text(
                    announcementEntity.description,
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: context.greyColor,
                      height: 1.4,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),

                  16.verticalSpace,

                  // Date and read more
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Date
                      Text(
                        announcementEntity.createdAt.toHumanReadableDate(),
                        style: context.textTheme.bodySmall?.copyWith(
                          color: context.greyColor,
                        ),
                      ),

                      // Read more button
                      Container(
                        padding: REdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 6.h,
                        ),
                        decoration: BoxDecoration(
                          color: context.primaryColor.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        child: Text(
                          AppStrings.readMore,
                          style: context.textTheme.bodySmall?.copyWith(
                            color: context.primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
