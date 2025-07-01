import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../shared/extensions/string_extension.dart';
import '../../../domain/entities/day_schedule_entity.dart';

class DaySelector extends StatefulWidget {
  final List<DayScheduleEntity> days;
  final int selectedDayIndex;
  final Function(int) onDaySelected;

  const DaySelector({
    super.key,
    required this.days,
    required this.selectedDayIndex,
    required this.onDaySelected,
  });

  @override
  State<DaySelector> createState() => _DaySelectorState();
}

class _DaySelectorState extends State<DaySelector>
    with SingleTickerProviderStateMixin {
  late ScrollController _scrollController;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  int? _pressedIndex;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _scrollToSelectedDay(int index) {
    if (!_scrollController.hasClients) return;

    final itemWidth = 80.w; // Approximate width of each day item
    final screenWidth = MediaQuery.of(context).size.width;
    final offset = (itemWidth * index) - (screenWidth / 2) + (itemWidth / 2);

    _scrollController.animateTo(
      offset.clamp(0.0, _scrollController.position.maxScrollExtent),
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  void didUpdateWidget(DaySelector oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedDayIndex != widget.selectedDayIndex) {
      _scrollToSelectedDay(widget.selectedDayIndex);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      height: 100.h,
      margin: REdgeInsets.symmetric(vertical: 8),
      child: ListView.builder(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        itemCount: widget.days.length,
        itemBuilder: (context, index) => _buildDayItem(context, index, theme),
      ),
    );
  }

  Widget _buildDayItem(BuildContext context, int index, ThemeData theme) {
    final day = widget.days[index].day;
    final isSelected = index == widget.selectedDayIndex;
    final isPressed = index == _pressedIndex;

    return GestureDetector(
      onTapDown: (_) {
        setState(() => _pressedIndex = index);
        _animationController.forward();
      },
      onTapUp: (_) {
        setState(() => _pressedIndex = null);
        _animationController.reverse();
        HapticFeedback.lightImpact();
        widget.onDaySelected(index);
      },
      onTapCancel: () {
        setState(() => _pressedIndex = null);
        _animationController.reverse();
      },
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) => Transform.scale(
          scale: isPressed ? _scaleAnimation.value : 1.0,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            margin: REdgeInsets.symmetric(horizontal: 8, vertical: 12),
            padding: REdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: isSelected ? theme.primaryColor : theme.cardColor,
              borderRadius: BorderRadius.circular(16),
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: theme.primaryColor.withValues(alpha: 0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ]
                  : null,
              border: Border.all(
                color: isSelected
                    ? theme.primaryColor
                    : theme.dividerColor.withValues(alpha: 0.1),
                width: 1,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${day.day}',
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: isSelected
                        ? Colors.white
                        : theme.textTheme.titleMedium?.color,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  day.weekday.weekdayShort,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: isSelected
                        ? Colors.white.withValues(alpha: 0.9)
                        : theme.textTheme.bodySmall?.color
                            ?.withValues(alpha: 0.7),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
