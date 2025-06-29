import 'package:beamer/beamer.dart';
import 'package:uni_sphere_admin/common/constant/app_strings.dart';
import 'package:uni_sphere_admin/features/subjects_management/data/models/subjects_management_model.dart';
import 'package:uni_sphere_admin/router/router_config.dart';
import 'package:uni_sphere_admin/shared/imports/imports.dart';
import 'package:uni_sphere_admin/shared/widgets/custom_network_image.dart';

class SubjectDetailsScreen extends StatefulWidget {
  const SubjectDetailsScreen({super.key, required this.subject});

  final Subject subject;

  static const String pagePath = 'subject_details';

  static BeamerBuilder pageBuilder = (context, state, data) {
    final subject = data as Subject?;
    return BeamPage(
      key: ValueKey('subject_details_${subject?.id ?? ''}'),
      child: SubjectDetailsScreen(
          subject: subject ??
              Subject(
                id: '',
                name: '',
                description: '',
                majorId: '',
                year: 0,
                semester: 0,
                midtermGrade: 0,
                finalGrade: 0,
                isLabRequired: false,
                isMultipleChoice: false,
                isOpenBook: false,
                image: '',
                materialUrls: [],
              )),
      type: BeamPageType.fadeTransition,
    );
  };

  @override
  State<SubjectDetailsScreen> createState() => _SubjectDetailsScreenState();
}

class _SubjectDetailsScreenState extends State<SubjectDetailsScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final List<Animation<double>> _animations;
  bool _isDisposed = false;
  bool _hasAnimated = false;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _animations = List.generate(
      3,
      (index) => Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(
            index * (0.5 / 3),
            (index * (0.5 / 3)) + 0.5,
            curve: Curves.easeOut,
          ),
        ),
      ),
    );

    if (!_isDisposed && !_hasAnimated) {
      _controller.forward();
      _hasAnimated = true;
    }
  }

  @override
  void dispose() {
    _isDisposed = true;
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildImageHeader(context),
          SliverToBoxAdapter(
            child: AnimatedBuilder(
              animation: _animations[0],
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(0, -20 * (1 - _animations[0].value)),
                  child: Opacity(
                    opacity: _animations[0].value,
                    child: child,
                  ),
                );
              },
              child: Padding(
                padding: REdgeInsets.symmetric(vertical: 9),
                child: _buildSubjectHeader(context),
              ),
            ),
          ),
          if (widget.subject.midtermGrade > 0 || widget.subject.finalGrade > 0)
            SliverToBoxAdapter(
              child: AnimatedBuilder(
                animation: _animations[1],
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(0, -20 * (1 - _animations[1].value)),
                    child: Opacity(
                      opacity: _animations[1].value,
                      child: child,
                    ),
                  );
                },
                child: Padding(
                  padding: REdgeInsets.symmetric(vertical: 9.0),
                  child: _buildGradesSection(context),
                ),
              ),
            ),
          SliverToBoxAdapter(
            child: AnimatedBuilder(
              animation: _animations.last,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(0, -20 * (1 - _animations.last.value)),
                  child: Opacity(
                    opacity: _animations.last.value,
                    child: child,
                  ),
                );
              },
              child: Padding(
                padding: REdgeInsets.symmetric(vertical: 9.0),
                child: _buildDescriptionAndMaterials(context),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageHeader(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      leadingWidth: AppConstants.horizontalScreensPadding + 60.r,
      collapsedHeight: 70.r,
      leading: SizedBox(
        child: Row(
          children: [
            AppConstants.horizontalScreensPadding.horizontalSpace,
            IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 24.r,
              ),
              onPressed: () {
                context.beamBack();
              },
            ),
          ],
        ),
      ),
      expandedHeight: context.screenHeight * 0.35,
      pinned: true,
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: Container(
          height: 22.h,
          decoration: BoxDecoration(
            color: context.backgroundColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(22.r),
              topRight: Radius.circular(22.r),
            ),
          ),
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            CustomNetworkImage(
              imageUrl: widget.subject.image,
              fit: BoxFit.cover,
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.5),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: REdgeInsets.only(left: 24, bottom: 40, right: 24),
                child: Text(
                  widget.subject.name,
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: context.primaryColor,
    );
  }

  Widget _buildSubjectHeader(BuildContext context) {
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
            widget.subject.name,
            style: context.textTheme.bodyLarge!
                .withColor(context.onBackgroundColor),
          ),
          8.verticalSpace,
          Text(
            widget.subject.description,
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
            AppStrings.subjectName,
            style:
                context.textTheme.titleMedium!.withColor(context.primaryColor),
          ),
          16.verticalSpace,
          _buildInfoRow(context, AppStrings.year,
              '${AppStrings.year} ${widget.subject.year}'),
          8.verticalSpace,
          _buildInfoRow(context, AppStrings.semester,
              '${AppStrings.semester} ${widget.subject.semester}'),
          8.verticalSpace,
          _buildInfoRow(context, AppStrings.isLabRequired,
              widget.subject.isLabRequired ? "نعم" : "لا"),
          8.verticalSpace,
          _buildInfoRow(context, AppStrings.isMultipleChoice,
              widget.subject.isMultipleChoice ? "نعم" : "لا"),
          8.verticalSpace,
          _buildInfoRow(context, AppStrings.isOpenBook,
              widget.subject.isOpenBook ? "نعم" : "لا"),
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

  Widget _buildGradesSection(BuildContext context) {
    final totalGrade = widget.subject.midtermGrade + widget.subject.finalGrade;

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
              if (widget.subject.midtermGrade > 0) ...[
                _buildGradeItem(
                  context,
                  AppStrings.midtermGrade,
                  widget.subject.midtermGrade.toString(),
                ),
              ],
              if (widget.subject.finalGrade > 0) ...[
                _buildGradeItem(
                  context,
                  AppStrings.finalGrade,
                  widget.subject.finalGrade.toString(),
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

  Widget _buildDescriptionAndMaterials(BuildContext context) {
    return Container(
      padding: REdgeInsets.symmetric(
        horizontal: AppConstants.horizontalScreensPadding,
      ),
      child: Column(
        spacing: 18.h,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDescription(context),
          _buildMaterials(context),
        ],
      ),
    );
  }

  Widget _buildDescription(BuildContext context) {
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
        spacing: 16.h,
        children: [
          Text(
            AppStrings.subjectDescription,
            style:
                context.textTheme.titleMedium!.withColor(context.primaryColor),
          ),
          Text(
            widget.subject.description,
            style: context.textTheme.bodyMedium!
                .withColor(context.onBackgroundColor),
          ),
        ],
      ),
    );
  }

  Widget _buildMaterials(BuildContext context) {
    if (widget.subject.materialUrls.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.materials,
          style: context.textTheme.titleMedium!.withColor(context.primaryColor),
        ),
        16.verticalSpace,
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: widget.subject.materialUrls.length,
          separatorBuilder: (context, index) => 8.verticalSpace,
          itemBuilder: (context, index) {
            final material = widget.subject.materialUrls[index];
            return _buildMaterialItem(context, material);
          },
        ),
      ],
    );
  }

  Widget _buildMaterialItem(BuildContext context, MaterialsUrl material) {
    return Container(
      padding: REdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.cardColor,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: context.primaryColor.withValues(alpha: 0.1),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          _buildMaterialIcon(context, material.type),
          16.horizontalSpace,
          Expanded(
            child: Text(
              material.url.split('/').last,
              style: context.textTheme.bodyMedium!
                  .withColor(context.onBackgroundColor),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          16.horizontalSpace,
          Icon(
            Icons.download_rounded,
            color: context.primaryColor,
            size: 24.r,
          ),
        ],
      ),
    );
  }

  Widget _buildMaterialIcon(BuildContext context, MaterialsUrlType type) {
    IconData iconData;
    Color iconColor;

    switch (type) {
      case MaterialsUrlType.pdf:
        iconData = Icons.picture_as_pdf_rounded;
        iconColor = Colors.red;
        break;
      case MaterialsUrlType.video:
        iconData = Icons.video_library_rounded;
        iconColor = Colors.blue;
        break;
      case MaterialsUrlType.image:
        iconData = Icons.image_rounded;
        iconColor = Colors.green;
        break;
      case MaterialsUrlType.audio:
        iconData = Icons.audio_file_rounded;
        iconColor = Colors.orange;
        break;
      case MaterialsUrlType.document:
        iconData = Icons.description_rounded;
        iconColor = Colors.blue;
        break;
      case MaterialsUrlType.excel:
        iconData = Icons.table_chart_rounded;
        iconColor = Colors.green;
        break;
      case MaterialsUrlType.word:
        iconData = Icons.article_rounded;
        iconColor = Colors.blue;
        break;
      case MaterialsUrlType.powerpoint:
        iconData = Icons.slideshow_rounded;
        iconColor = Colors.orange;
        break;
      case MaterialsUrlType.zip:
      case MaterialsUrlType.rar:
        iconData = Icons.folder_zip_rounded;
        iconColor = Colors.purple;
        break;
      case MaterialsUrlType.other:
        iconData = Icons.insert_drive_file_rounded;
        iconColor = Colors.grey;
        break;
    }

    return Container(
      padding: REdgeInsets.all(8),
      decoration: BoxDecoration(
        color: iconColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Icon(
        iconData,
        color: iconColor,
        size: 24.r,
      ),
    );
  }
}
