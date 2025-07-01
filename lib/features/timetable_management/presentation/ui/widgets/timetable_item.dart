import '../../../../../shared/extensions/date_time_extension.dart';
import '../../../../../shared/imports/imports.dart';
import '../../../../../shared/utils/helper/get_colored_svg_picture.dart';
import '../../../../../shared/widgets/dashed_line.dart';
import '../../../domain/entities/timetable_entity.dart';

class TimetableItem extends StatefulWidget {
  final TimetableEntity timetable;

  const TimetableItem({
    super.key,
    required this.timetable,
  });

  @override
  State<TimetableItem> createState() => _TimetableItemState();
}

class _TimetableItemState extends State<TimetableItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.98).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() => _isPressed = true);
        _animationController.forward();
      },
      onTapUp: (_) {
        setState(() => _isPressed = false);
        _animationController.reverse();
      },
      onTapCancel: () {
        setState(() => _isPressed = false);
        _animationController.reverse();
      },
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) => Transform.scale(
          scale: _isPressed ? _scaleAnimation.value : 1.0,
          child: Container(
            margin: REdgeInsets.symmetric(vertical: 8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 120.h,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildTimeColumn(context),
                      12.horizontalSpace,
                      Expanded(
                        child: _buildSubjectInfo(context),
                      ),
                    ],
                  ),
                ),
                16.verticalSpace,
                DashedLine(
                  width: double.infinity,
                  dashWidth: 3,
                  gapWidth: 3,
                  dashColor: context.greyColor.withValues(alpha: 0.3),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTimeColumn(BuildContext context) {
    return Container(
      width: 70.w,
      padding: REdgeInsets.symmetric(vertical: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            widget.timetable.startTime.formatTime,
            style: context.textTheme.bodyMedium?.copyWith(
              color: context.primaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          Container(
            height: 40.h,
            width: 1,
            color: context.greyColor.withValues(alpha: 0.3),
          ),
          Text(
            widget.timetable.endTime.formatTime,
            style: context.textTheme.bodyMedium?.copyWith(
              color: context.primaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubjectInfo(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: REdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: theme.shadowColor.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(
          color: theme.dividerColor.withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Container(
                padding: REdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: context.primaryColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: getColoredSvgPicture(
                  assetName: Assets.icons.lectureHallIcon,
                  width: 20.r,
                  height: 20.r,
                  color: context.primaryColor,
                ),
              ),
              12.horizontalSpace,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.timetable.subjectName,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    4.verticalSpace,
                    Text(
                      widget.timetable.lectureHall,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.textTheme.bodySmall?.color
                            ?.withValues(alpha: 0.7),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          12.verticalSpace,
          Text(
            widget.timetable.lecturerName,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.textTheme.bodyMedium?.color?.withValues(alpha: 0.8),
            ),
          ),
        ],
      ),
    );
  }
} 