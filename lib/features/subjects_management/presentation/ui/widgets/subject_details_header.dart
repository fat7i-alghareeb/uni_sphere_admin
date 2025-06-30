import 'package:uni_sphere_admin/common/constant/app_strings.dart';
import 'package:uni_sphere_admin/features/subjects_management/data/models/subjects_management_model.dart';
import 'package:uni_sphere_admin/shared/imports/imports.dart';

class SubjectDetailsHeader extends StatelessWidget {
  const SubjectDetailsHeader({
    super.key,
    required this.subject,
  });

  final Subject subject;

  static const double _borderRadius = 22;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: REdgeInsets.symmetric(
        horizontal: AppConstants.horizontalScreensPadding,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.subjectName,
            style:
                context.textTheme.titleMedium!.withColor(context.primaryColor),
          ),
          8.verticalSpace,
          Text(
            subject.name,
            style: context.textTheme.bodyLarge!
                .withColor(context.onBackgroundColor),
          ),
          8.verticalSpace,
          Text(
            subject.description,
            style: context.textTheme.bodyMedium!.withColor(context.greyColor),
          ),
          16.verticalSpace,
          _buildSubjectInfoCard(context),
        ],
      ),
    );
  }

  Widget _buildSubjectInfoCard(BuildContext context) {
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
        children: [
          Text(
            AppStrings.subjectInformation,
            style:
                context.textTheme.titleMedium!.withColor(context.primaryColor),
          ),
          16.verticalSpace,
          _buildInfoRow(
              context, AppStrings.year, '${AppStrings.year} ${subject.year}'),
          8.verticalSpace,
          _buildInfoRow(context, AppStrings.semester,
              '${AppStrings.semester} ${subject.semester}'),
          8.verticalSpace,
          _buildInfoRow(context, AppStrings.isLabRequired,
              subject.isLabRequired ? AppStrings.yes : AppStrings.no),
          8.verticalSpace,
          _buildInfoRow(context, AppStrings.isMultipleChoice,
              subject.isMultipleChoice ? AppStrings.yes : AppStrings.no),
          8.verticalSpace,
          _buildInfoRow(context, AppStrings.isOpenBook,
              subject.isOpenBook ? AppStrings.yes : AppStrings.no),
        ],
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: context.textTheme.bodyMedium!.withColor(context.greyColor),
        ),
        Text(
          value,
          style: context.textTheme.bodyMedium!
              .withColor(context.onBackgroundColor),
        ),
      ],
    );
  }
}
