import '../../../../../common/constant/app_strings.dart';
import '../../../../../shared/imports/imports.dart';
import '../../../domain/entities/announcement_entity.dart';

class AnnouncementDetailsContent extends StatelessWidget {
  const AnnouncementDetailsContent({
    super.key,
    required this.announcement,
  });

  final AnnouncementEntity announcement;

  static const double _borderRadius = 22;
  static const double _spacing = 16;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: REdgeInsets.symmetric(
        horizontal: AppConstants.horizontalScreensPadding,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: _spacing.h,
        children: [
          _buildTitleSection(context),
          _buildDescriptionSection(context),
        ],
      ),
    );
  }

  Widget _buildTitleSection(BuildContext context) {
    return Container(
      padding: REdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.cardColor,
        borderRadius: BorderRadius.circular(_borderRadius.r),
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
        spacing: 8.h,
        children: [
          Text(
            AppStrings.title,
            style: context.textTheme.titleMedium?.copyWith(
              color: context.primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            announcement.title,
            style: context.textTheme.titleLarge?.copyWith(
              color: context.onBackgroundColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDescriptionSection(BuildContext context) {
    return Container(
      padding: REdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.cardColor,
        borderRadius: BorderRadius.circular(_borderRadius.r),
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
        spacing: 8.h,
        children: [
          Text(
            AppStrings.content,
            style: context.textTheme.titleMedium?.copyWith(
              color: context.primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            announcement.description,
            style: context.textTheme.bodyLarge?.copyWith(
              color: context.onBackgroundColor,
              height: 1.5,
              wordSpacing: 1.8,
              letterSpacing: 0.4,
            ),
          ),
        ],
      ),
    );
  }
}
