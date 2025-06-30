import 'package:uni_sphere_admin/common/constant/app_strings.dart';
import 'package:uni_sphere_admin/features/subjects_management/data/models/subjects_management_model.dart';
import 'package:uni_sphere_admin/shared/imports/imports.dart';

class SubjectDetailsGrades extends StatelessWidget {
  const SubjectDetailsGrades({
    super.key,
    required this.subject,
  });

  final Subject subject;

  @override
  Widget build(BuildContext context) {
    final totalGrade = subject.midtermGrade + subject.finalGrade;
    
    return Container(
      margin: REdgeInsets.symmetric(
        horizontal: AppConstants.horizontalScreensPadding,
      ),
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
            AppStrings.totalGrade,
            style: context.textTheme.titleLarge?.copyWith(
              color: context.onBackgroundColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          16.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (subject.midtermGrade > 0) ...[
                _buildGradeItem(
                  context,
                  AppStrings.midtermGrade,
                  subject.midtermGrade.toString(),
                ),
              ],
              if (subject.finalGrade > 0) ...[
                _buildGradeItem(
                  context,
                  AppStrings.finalGrade,
                  subject.finalGrade.toString(),
                ),
              ],
              _buildGradeItem(
                context,
                AppStrings.totalGrade,
                totalGrade.toString(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGradeItem(BuildContext context, String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: context.textTheme.labelMedium?.copyWith(
            color: context.greyColor,
          ),
        ),
        8.verticalSpace,
        Text(
          value,
          style: context.textTheme.titleLarge?.copyWith(
            color: context.primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
} 