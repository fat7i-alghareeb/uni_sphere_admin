import 'package:beamer/beamer.dart';
import 'package:uni_sphere_admin/core/styles/colors.dart';
import 'package:uni_sphere_admin/features/subjects_management/data/models/subjects_management_model.dart';
import 'package:uni_sphere_admin/features/subjects_management/presentation/ui/screens/subject_details_screen.dart';
import 'package:uni_sphere_admin/shared/imports/imports.dart';
import 'package:uni_sphere_admin/shared/widgets/custom_network_image.dart';

/// A card widget that displays information about a subject.
/// Reuses the same design from the student app's SubjectItemCard
class SubjectItemCard extends StatelessWidget {
  const SubjectItemCard({
    super.key,
    required this.subject,
    this.haveFullInfo = false,
    this.showOnlyNameAndImage = false,
  });

  final bool haveFullInfo;
  final bool showOnlyNameAndImage;
  final Subject subject;

  static const double _containerHorizontalPadding = 12;
  static const double _containerVerticalPadding = 14;
  static const double _borderRadius = 22;
  static const double _spacing = 10;
  static const double _imageSize = 100;

  @override
  Widget build(BuildContext context) {
    try {
      final imageSize = showOnlyNameAndImage ? 60.0 : _imageSize;

      return GestureDetector(
        onTap: () => _handleTap(context),
        child: Container(
          clipBehavior: Clip.hardEdge,
          margin: REdgeInsets.symmetric(vertical: 6),
          padding: REdgeInsets.symmetric(
            horizontal: _containerHorizontalPadding.w,
            vertical: _containerVerticalPadding.h,
          ),
          decoration: BoxDecoration(
            color: context.cardColor,
            borderRadius: BorderRadius.circular(_borderRadius.r),
            boxShadow: AppColors.primaryShadow(context),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: imageSize.w,
                height: imageSize.h,
                child: _buildSubjectImage(),
              ),
              _spacing.horizontalSpace,
              Expanded(
                child: _buildSubjectInfo(context),
              )
            ],
          ),
        ),
      );
    } catch (e) {
      debugPrint('Error building SubjectItemCard: $e');
      return const SizedBox.shrink();
    }
  }

  void _handleTap(BuildContext context) {
    try {
      context.beamToNamed(
        SubjectDetailsScreen.pagePath,
        data: subject,
      );
    } catch (e) {
      debugPrint('Error handling tap: $e');
    }
  }

  Widget _buildSubjectImage() {
    return CustomNetworkImage(
      imageUrl: subject.image,
      borderRadius: _borderRadius,
      fit: BoxFit.cover,
    );
  }

  Widget _buildSubjectInfo(BuildContext context) {
    return _buildTitle(context);
  }

  Widget _buildTitle(BuildContext context) {
    return Text(
      subject.name,
      style:
          context.textTheme.titleMedium!.withColor(context.onBackgroundColor),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}
