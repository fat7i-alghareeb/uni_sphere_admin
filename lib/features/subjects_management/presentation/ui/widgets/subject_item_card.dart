import 'package:beamer/beamer.dart';
import 'package:uni_sphere_admin/common/constant/app_strings.dart';
import 'package:uni_sphere_admin/core/styles/colors.dart';
import 'package:uni_sphere_admin/features/subjects_management/data/models/subjects_management_model.dart';
import 'package:uni_sphere_admin/features/subjects_management/presentation/ui/screens/subject_details_screen.dart';
import 'package:uni_sphere_admin/shared/extensions/string_extension.dart';
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
            crossAxisAlignment: CrossAxisAlignment.start,
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
    if (showOnlyNameAndImage) {
      return _buildTitle(context);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildTitle(context),
        _buildDescription(context),
        _spacing.verticalSpace,
        _buildSubInfoTags(context),
      ],
    );
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

  Widget _buildDescription(BuildContext context) {
    return Text(
      subject.description,
      style: context.textTheme.labelMedium!.withColor(context.greyColor),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildSubInfoTags(BuildContext context) {
    final tags = _buildSubInfoContainers(context);
    final halfLength = (tags.length / 2).ceil();

    return SizedBox(
      height: 50.h, // Height for two rows
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: tags.sublist(0, halfLength),
              ),
            ),
          ),
          Flexible(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: tags.sublist(halfLength),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildSubInfoContainers(BuildContext context) {
    return _getNeededSubInfo(fullInfo: haveFullInfo)
        .map((info) => Padding(
              padding: REdgeInsets.only(right: 8),
              child: _buildSubInfoContainer(context, info),
            ))
        .toList();
  }

  Widget _buildSubInfoContainer(BuildContext context, SubInfo info) {
    return Container(
      decoration: BoxDecoration(
        color: info.color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(8.r),
      ),
      padding: REdgeInsets.symmetric(horizontal: 4, vertical: 2),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          info.title,
          style: context.textTheme.labelSmall!.withColor(info.color),
        ),
      ),
    );
  }

  List<SubInfo> _getNeededSubInfo({bool fullInfo = false}) {
    return [
      SubInfo(
        title: "${AppStrings.year} ${subject.year}",
        color: const Color(0xFF496ce5),
      ),
      SubInfo(
        title: subject.semester.semesterName,
        color: const Color(0xFFfc7cac),
      ),
      SubInfo(
        title:
            "${AppStrings.isMultipleChoice} ${_getAnswer(subject.isMultipleChoice)}",
        color: const Color.fromARGB(255, 252, 182, 52),
      ),
      SubInfo(
        title:
            "${AppStrings.isLabRequired} ${_getAnswer(subject.isLabRequired)}",
        color: const Color(0xFFa874f3),
      ),
      if (fullInfo) ...[
        SubInfo(
          title: "${AppStrings.isOpenBook} ${_getAnswer(subject.isOpenBook)}",
          color: const Color(0xFF1dceb2),
        ),
        SubInfo(
          title: "${AppStrings.midtermGrade} ${subject.midtermGrade}",
          color: const Color(0xFF70e8dc),
        ),
        SubInfo(
          title: "${AppStrings.finalGrade} ${subject.finalGrade}",
          color: const Color(0xFF70e8dc),
        ),
      ]
    ];
  }

  String _getAnswer(bool state) => state ? "نعم" : "لا";
}

/// A class that holds information about a subject's sub-info tag.
class SubInfo {
  final String title;
  final Color color;

  const SubInfo({
    required this.title,
    required this.color,
  });
}
