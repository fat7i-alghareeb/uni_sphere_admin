import 'package:beamer/beamer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:uni_sphere_admin/common/constant/app_strings.dart';
import 'package:uni_sphere_admin/core/constants/app_constants.dart';
import 'package:uni_sphere_admin/core/constants/dummy_data.dart';
import 'package:uni_sphere_admin/core/injection/injection.dart';
import 'package:uni_sphere_admin/core/result_builder/result.dart';
import 'package:uni_sphere_admin/core/result_builder/result_builder.dart';
import 'package:uni_sphere_admin/core/styles/colors.dart';
import 'package:uni_sphere_admin/features/announcements_management/domain/entities/announcement_entity.dart';
import 'package:uni_sphere_admin/features/announcements_management/presentation/state/bloc/announcements_management_bloc.dart';
import 'package:uni_sphere_admin/features/announcements_management/presentation/ui/screens/announcement_details_screen.dart';
import 'package:uni_sphere_admin/shared/entities/role.dart';
import 'package:uni_sphere_admin/shared/imports/imports.dart';
import 'package:uni_sphere_admin/shared/widgets/custom_shimmer.dart';
import 'package:uni_sphere_admin/shared/widgets/custom_network_image.dart';
import 'package:uni_sphere_admin/shared/widgets/spacing.dart';

class AnnouncementListWidget extends StatefulWidget {
  const AnnouncementListWidget({super.key});

  @override
  State<AnnouncementListWidget> createState() => _AnnouncementListWidgetState();
}

class _AnnouncementListWidgetState extends State<AnnouncementListWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late List<Animation<double>> _animations = [];
  final FormGroup _yearForm = FormGroup({
    'year': FormControl<int>(value: 1), // Default to year 1
  });

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fetchAnnouncements();
  }

  void _fetchAnnouncements() {
    if (AppConstants.userRole == Role.admin) {
      final selectedYear = _yearForm.control('year').value as int? ?? 1;
      debugPrint('🔍 Fetching Admin announcements with year: $selectedYear');
      getIt<AnnouncementsManagementBloc>()
          .add(GetAdminAnnouncementsEvent(year: selectedYear));
    } else if (AppConstants.userRole == Role.superadmin) {
      debugPrint('🔍 Fetching SuperAdmin announcements');
      getIt<AnnouncementsManagementBloc>()
          .add(GetSuperAdminAnnouncementsEvent());
    }
  }

  void _initializeAnimations(int itemCount) {
    try {
      _controller.reset();
      _animations = List.generate(
        itemCount,
        (index) => Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: _controller,
            curve: Interval(
              index * (0.5 / itemCount),
              (index * (0.5 / itemCount)) + 0.5,
              curve: Curves.easeOut,
            ),
          ),
        ),
      );

      _controller.forward();
    } catch (e) {
      debugPrint('Error initializing animations: $e');
      _animations = List.generate(
        itemCount,
        (index) => const AlwaysStoppedAnimation(1.0),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _yearForm.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AnnouncementsManagementBloc,
        AnnouncementsManagementState>(
      builder: (context, state) {
        final result = AppConstants.userRole == Role.admin
            ? state.adminAnnouncementsResult
            : state.superAdminAnnouncementsResult;

        debugPrint(
            '🔍 Building announcement list for role: ${AppConstants.userRole}');
        debugPrint('🔍 Result state: ${result.runtimeType}');
        debugPrint('🔍 Result isLoaded: ${result.isLoaded()}');
        debugPrint('🔍 Result isError: ${result.isError()}');
        debugPrint('🔍 Result isLoading: ${result.isLoading()}');

        return Column(
          children: [
            // Year picker for Admin role
            if (AppConstants.userRole == Role.admin) ...[
              Padding(
                padding: REdgeInsets.all(16),
                child: Container(
                  padding: REdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: context.cardColor,
                    borderRadius: BorderRadius.circular(16.r),
                    boxShadow: [
                      BoxShadow(
                        color: context.primaryColor.withValues(alpha: 0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: ReactiveForm(
                    formGroup: _yearForm,
                    child: ReactiveFormConsumer(
                      builder: (context, form, child) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppStrings.selectYear,
                              style: context.textTheme.titleMedium?.copyWith(
                                color: context.primaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            12.verticalSpace,
                            Container(
                              width: double.infinity,
                              height: 48.h,
                              decoration: BoxDecoration(
                                color: context.primaryColor
                                    .withValues(alpha: 0.08),
                                borderRadius: BorderRadius.circular(12.r),
                                border: Border.all(
                                  color:
                                      context.greyColor.withValues(alpha: 0.5),
                                ),
                              ),
                              child: DropdownButtonFormField<int>(
                                value: form.control('year').value,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: REdgeInsets.symmetric(
                                      horizontal: 16, vertical: 12),
                                ),
                                hint: Text(AppStrings.selectYear),
                                items: List.generate(4, (index) {
                                  final year = index + 1;
                                  return DropdownMenuItem(
                                    value: year,
                                    child: Text('${AppStrings.year} $year'),
                                  );
                                }),
                                onChanged: (value) {
                                  if (value != null) {
                                    form.control('year').value = value;
                                    getIt<AnnouncementsManagementBloc>().add(
                                        GetAdminAnnouncementsEvent(
                                            year: value));
                                  }
                                },
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
            // Announcements list
            Expanded(
              child: ResultBuilder<List<AnnouncementEntity>>(
                onError: () {
                  debugPrint('🔍 Error occurred, retrying...');
                  _fetchAnnouncements();
                },
                loading: () {
                  debugPrint('🔍 Loading announcements...');
                  return _buildLoadingShimmer();
                },
                success: (data) {
                  debugPrint(
                      '🔍 Successfully loaded ${data.length} announcements');
                  _initializeAnimations(data.length);
                  return Stack(
                    children: [
                      _buildShimmerList(data.length),
                      _buildAnimatedAnnouncementList(data),
                    ],
                  );
                },
                result: result,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildLoadingShimmer() {
    return ListView.builder(
      padding: REdgeInsets.only(
        left: AppConstants.horizontalScreensPadding,
        right: AppConstants.horizontalScreensPadding,
        bottom: 100.h,
      ),
      itemBuilder: (context, index) => Container(
        margin: REdgeInsets.only(bottom: 22.h),
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: context.cardColor,
          borderRadius: BorderRadius.circular(22.r),
          boxShadow: AppColors.primaryShadow(context),
        ),
        child: Padding(
          padding: REdgeInsets.all(22.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomShimmerWidget(
                height: 12.h,
                width: 100.w,
                borderRadius: 8,
              ),
              12.verticalSpace,
              CustomShimmerWidget(
                height: 25.h,
                width: double.infinity,
                borderRadius: 8,
              ),
              8.verticalSpace,
              CustomShimmerWidget(
                height: 18.h,
                width: double.infinity,
                borderRadius: 8,
              ),
              5.verticalSpace,
              CustomShimmerWidget(
                height: 18.h,
                width: double.infinity,
                borderRadius: 8,
              ),
              5.verticalSpace,
            ],
          ),
        ),
      ),
      itemCount: 10,
    );
  }

  Widget _buildShimmerList(int itemCount) {
    try {
      return ListView.builder(
        padding: REdgeInsets.only(
          left: AppConstants.horizontalScreensPadding,
          right: AppConstants.horizontalScreensPadding,
          bottom: 100.h,
        ),
        itemBuilder: (context, index) {
          if (index >= _animations.length) {
            return const SizedBox.shrink();
          }
          return AnimatedBuilder(
            animation: _animations[index],
            builder: (context, child) {
              return Opacity(
                opacity: 1 - _animations[index].value,
                child: child,
              );
            },
            child: _buildShimmerCard(),
          );
        },
        itemCount: itemCount,
      );
    } catch (e) {
      debugPrint('Error building shimmer list: $e');
      return const SizedBox.shrink();
    }
  }

  Widget _buildAnimatedAnnouncementList(List<AnnouncementEntity> data) {
    try {
      return ListView.builder(
        padding: REdgeInsets.only(
          left: AppConstants.horizontalScreensPadding,
          right: AppConstants.horizontalScreensPadding,
          bottom: 100.h,
        ),
        itemBuilder: (context, index) {
          if (index >= data.length || index >= _animations.length) {
            return const SizedBox.shrink();
          }
          return AnimatedBuilder(
            animation: _animations[index],
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(0, -20 * (1 - _animations[index].value)),
                child: Opacity(
                  opacity: _animations[index].value,
                  child: child,
                ),
              );
            },
            child: AppConstants.userRole == Role.superadmin
                ? _buildSuperAdminCard(data[index])
                : _buildAdminCard(data[index]),
          );
        },
        itemCount: data.length,
      );
    } catch (e) {
      debugPrint('Error building animated announcement list: $e');
      return const SizedBox.shrink();
    }
  }

  Widget _buildShimmerCard() {
    try {
      return Container(
        margin: REdgeInsets.only(bottom: 22.h),
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: context.cardColor,
          borderRadius: BorderRadius.circular(22.r),
          boxShadow: AppColors.primaryShadow(context),
        ),
        child: Padding(
          padding: REdgeInsets.all(22.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomShimmerWidget(
                height: 12.h,
                width: 100.w,
                borderRadius: 8,
              ),
              12.verticalSpace,
              CustomShimmerWidget(
                height: 25.h,
                width: double.infinity,
                borderRadius: 8,
              ),
              8.verticalSpace,
              CustomShimmerWidget(
                height: 18.h,
                width: double.infinity,
                borderRadius: 8,
              ),
              5.verticalSpace,
              CustomShimmerWidget(
                height: 18.h,
                width: double.infinity,
                borderRadius: 8,
              ),
              5.verticalSpace,
            ],
          ),
        ),
      );
    } catch (e) {
      debugPrint('Error building shimmer card: $e');
      return const SizedBox.shrink();
    }
  }

  // SuperAdmin card - same as all_news_widget from student app
  Widget _buildSuperAdminCard(AnnouncementEntity announcement) {
    return GestureDetector(
      onTap: () {
        context.beamToNamed(
          AnnouncementDetailsScreen.pagePath,
          data: announcement,
        );
      },
      child: Container(
        height: 300.h,
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
            if (announcement.image?.isNotEmpty ?? false) ...[
              Container(
                decoration: BoxDecoration(
                  boxShadow: AppColors.primaryShadow(context),
                ),
                child: Hero(
                  tag: announcement.id,
                  child: CustomNetworkImage(
                    imageUrl: announcement.image!.first,
                    height: 180.h,
                    width: double.infinity,
                    borderRadius: 22,
                  ),
                ),
              ),
            ],
            // Content section
            Expanded(
              child: Padding(
                padding:
                    REdgeInsets.symmetric(horizontal: 22.w, vertical: 12.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      announcement.createdAt,
                      style: context.textTheme.labelMedium?.copyWith(
                        color: context.greyColor,
                      ),
                    ),
                    5.verticalSpace,
                    Expanded(
                      child: Text(
                        announcement.description,
                        style: context.textTheme.labelLarge!.copyWith(
                          wordSpacing: 1.8,
                          height: 1.5,
                          letterSpacing: 0.4,
                          fontWeight: FontWeight.w900,
                          color:
                              context.onBackgroundColor.withValues(alpha: 0.95),
                        ),
                        softWrap: true,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Admin card - same as my_news_card from student app
  Widget _buildAdminCard(AnnouncementEntity announcement) {
    return Container(
      margin: REdgeInsets.only(bottom: 22.h),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: context.cardColor,
        borderRadius: BorderRadius.circular(22.r),
        boxShadow: AppColors.primaryShadow(context),
      ),
      child: Padding(
        padding: REdgeInsets.all(22.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              announcement.createdAt,
              style: context.textTheme.labelMedium?.copyWith(
                color: context.greyColor,
              ),
            ),
            12.verticalSpace,
            Text(
              announcement.title,
              style: context.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: context.onBackgroundColor,
              ),
            ),
            8.verticalSpace,
            Text(
              announcement.description,
              style: context.textTheme.bodyLarge?.copyWith(
                wordSpacing: 1.8,
                height: 1.5,
                letterSpacing: 0.4,
                color: context.onBackgroundColor.withValues(alpha: 0.95),
              ),
              softWrap: true,
            ),
          ],
        ),
      ),
    );
  }
}
