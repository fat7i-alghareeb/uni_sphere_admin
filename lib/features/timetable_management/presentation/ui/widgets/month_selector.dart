import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../../core/injection/injection.dart';
import '../../../../../core/result_builder/result.dart';
import '../../state/time_table/time_table_bloc.dart';
import '../../../../../shared/extensions/string_extension.dart';
import '../../../../../shared/widgets/loading_progress.dart';
import '../../../../../shared/utils/helper/show_error_overlay.dart';

class MonthSelector extends StatefulWidget {
  final void Function(int newMonth, int year)? onMonthChanged;
  final int majorYear;
  const MonthSelector(
      {super.key, this.onMonthChanged, required this.majorYear});

  @override
  State<MonthSelector> createState() => _MonthSelectorState();
}

class _MonthSelectorState extends State<MonthSelector>
    with TickerProviderStateMixin {
  bool isLeftLoading = false;
  bool isRightLoading = false;
  late AnimationController _slideController;
  late AnimationController _fadeController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;
  bool _isAnimating = false;
  int? _pendingAnimationOffset;

  @override
  void initState() {
    super.initState();
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.0),
      end: const Offset(0.0, 0.0),
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeInOut,
    ));

    _fadeAnimation = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _slideController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  Future<void> _animateMonthChange(int offset) async {
    if (_isAnimating) return;
    _isAnimating = true;

    // Set the slide direction
    _slideAnimation = Tween<Offset>(
      begin: Offset(offset > 0 ? -0.5 : 0.5, 0.0),
      end: const Offset(0.0, 0.0),
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeInOut,
    ));

    // Start animations
    await _fadeController.forward();
    _slideController.forward(from: 0.0);
    await _fadeController.reverse();

    _isAnimating = false;
  }

  void _changeMonth(int offset) {
    HapticFeedback.heavyImpact();
    setState(() {
      if (offset < 0) {
        isLeftLoading = true;
      } else {
        isRightLoading = true;
      }
      _pendingAnimationOffset = offset;
    });

    final selectedMonth = DateTime(
      TimeTableBloc.selectedDateTime.year,
      TimeTableBloc.selectedDateTime.month + offset,
    );

    // Update the selected date time immediately for navigation
    TimeTableBloc.selectedDateTime = selectedMonth;

    getIt<TimeTableBloc>().add(
      LoadMonthEvent(
        month: selectedMonth,
        majorYear: widget.majorYear,
      ),
    );
    // Call the callback if provided
    if (widget.onMonthChanged != null) {
      widget.onMonthChanged!(selectedMonth.month, selectedMonth.year);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocListener<TimeTableBloc, TimeTableState>(
      listener: (context, state) {
        if (state.loadMonthResult.isLoaded()) {
          setState(() {
            isLeftLoading = false;
            isRightLoading = false;
          });

          // Trigger animation after loading is complete
          if (_pendingAnimationOffset != null) {
            _animateMonthChange(_pendingAnimationOffset!);
            _pendingAnimationOffset = null;
          }
        }
        if (state.loadMonthResult.isError()) {
          showErrorOverlay(
              context,
              state.loadMonthResult.maybeWhen(
                orElse: () => "لا يوجد بيانات لهذا الشهر",
                error: (error) => error,
              ));
          setState(() {
            isLeftLoading = false;
            isRightLoading = false;
          });
        }
      },
      child: Container(
        margin: REdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: REdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildMonthNavigationButton(
              isLoading: isLeftLoading,
              icon: FontAwesomeIcons.chevronLeft,
              onTap: () => _changeMonth(-1),
            ),
            AnimatedBuilder(
              animation: Listenable.merge([_slideController, _fadeController]),
              builder: (context, child) => FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: Text(
                    '${TimeTableBloc.selectedDateTime.month.monthName} ${TimeTableBloc.selectedDateTime.year}',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ),
            ),
            _buildMonthNavigationButton(
              isLoading: isRightLoading,
              icon: FontAwesomeIcons.chevronRight,
              onTap: () => _changeMonth(1),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMonthNavigationButton({
    required bool isLoading,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: isLoading ? null : onTap,
      borderRadius: BorderRadius.circular(12),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: REdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: isLoading
              ? Colors.transparent
              : Theme.of(context).primaryColor.withValues(alpha: 0.1),
        ),
        child: isLoading
            ? const LoadingProgress(size: 25)
            : Icon(
                icon,
                size: 25.r,
                color: Theme.of(context).primaryColor,
              ),
      ),
    );
  }
}
