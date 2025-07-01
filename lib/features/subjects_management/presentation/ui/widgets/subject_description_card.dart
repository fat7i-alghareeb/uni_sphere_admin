import 'package:uni_sphere_admin/common/constant/app_strings.dart';
import 'package:uni_sphere_admin/features/subjects_management/data/models/subjects_management_model.dart';
import 'package:uni_sphere_admin/shared/imports/imports.dart';

class SubjectDescriptionCard extends StatelessWidget {
  const SubjectDescriptionCard({
    super.key,
    required this.subject,
  });

  final Subject subject;

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
            AppStrings.subjectDescription,
            style:
                context.textTheme.titleMedium!.withColor(context.primaryColor),
          ),
          16.verticalSpace,
          Text(
            subject.description,
            style: context.textTheme.bodyMedium!
                .withColor(context.onBackgroundColor),
          ),
        ],
      ),
    );
  }
}
