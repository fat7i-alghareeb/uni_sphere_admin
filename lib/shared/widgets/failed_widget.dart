// 📦 Package imports:
import 'package:google_fonts/google_fonts.dart';

// 🌎 Project imports:
import '../imports/imports.dart';
import '../../core/styles/colors.dart';
import 'spacing.dart';

/// A modern, animated error widget that displays error messages with smooth animations
/// and provides a retry mechanism. This widget includes comprehensive error handling
/// to ensure it never crashes, even if animations fail.
///
/// Features:
/// - Smooth fade-in animation for the entire widget (600ms)
/// - Subtle scale animation for the error icon (500ms)
/// - Gentle shake animation for the retry button on press (400ms)
/// - Compact error icon design (140x140 with 56px icon)
/// - Gradient backgrounds and shadows following app design system
/// - Responsive design using ScreenUtil
/// - Comprehensive try-catch error handling
/// - Fallback widgets in case of any failures
///
/// Usage:
/// ```dart
/// FailedWidget(
///   error: "Something went wrong",
///   onPressed: () => retryOperation(),
///   retryText: "Try Again",
///   showAnimation: true,
/// )
/// ```
class FailedWidget extends StatefulWidget {
  const FailedWidget({
    super.key,
    required this.error,
    this.onPressed,
    this.retryText = "إعادة المحاولة",
    this.showAnimation = true,
  });

  /// The error message to display
  final String error;

  /// Callback function to execute when retry button is pressed
  final void Function()? onPressed;

  /// Custom text for the retry button (defaults to Arabic "إعادة المحاولة")
  final String retryText;

  /// Whether to show animations (defaults to true)
  final bool showAnimation;

  @override
  State<FailedWidget> createState() => _FailedWidgetState();
}

class _FailedWidgetState extends State<FailedWidget>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _scaleController;
  late AnimationController _shakeController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _shakeAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    try {
      // Fade animation for smooth appearance - made more subtle
      _fadeController = AnimationController(
        duration: const Duration(milliseconds: 600), // Reduced from 800ms
        vsync: this,
      );
      _fadeAnimation = Tween<double>(
        begin: 0.0,
        end: 1.0,
      ).animate(CurvedAnimation(
        parent: _fadeController,
        curve: Curves.easeOut, // Changed from easeInOut for smoother feel
      ));

      // Scale animation for the error icon - made more subtle
      _scaleController = AnimationController(
        duration: const Duration(milliseconds: 500), // Reduced from 600ms
        vsync: this,
      );
      _scaleAnimation = Tween<double>(
        begin: 0.8, // Changed from 0.5 to 0.8 for less dramatic effect
        end: 1.0,
      ).animate(CurvedAnimation(
        parent: _scaleController,
        curve:
            Curves.easeOutBack, // Changed from elasticOut for more refined feel
      ));

      // Shake animation for the retry button - made more subtle
      _shakeController = AnimationController(
        duration: const Duration(milliseconds: 400), // Reduced from 500ms
        vsync: this,
      );
      _shakeAnimation = Tween<double>(
        begin: 0.0,
        end: 1.0,
      ).animate(CurvedAnimation(
        parent: _shakeController,
        curve: Curves.easeInOut,
      ));

      // Start animations with better timing
      _fadeController.forward();
      Future.delayed(const Duration(milliseconds: 150), () {
        // Reduced delay
        if (mounted) {
          _scaleController.forward();
        }
      });
    } catch (e) {
      // Fallback if animation initialization fails
      debugPrint('Animation initialization failed: $e');
    }
  }

  @override
  void dispose() {
    try {
      _fadeController.dispose();
      _scaleController.dispose();
      _shakeController.dispose();
    } catch (e) {
      debugPrint('Animation disposal failed: $e');
    }
    super.dispose();
  }

  void _handleRetryPress() {
    try {
      // Add shake animation to button
      _shakeController.forward().then((_) {
        _shakeController.reverse();
      });

      // Call the original onPressed callback
      if (widget.onPressed != null) {
        widget.onPressed!();
      }
    } catch (e) {
      debugPrint('Retry button press failed: $e');
      // Fallback: just call the original callback
      if (widget.onPressed != null) {
        widget.onPressed!();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    try {
      return FadeTransition(
        opacity: _fadeAnimation,
        child: Material(
          color: Colors.transparent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    // Animated error icon
                    if (widget.showAnimation) ...[
                      ScaleTransition(
                        scale: _scaleAnimation,
                        child: Container(
                          width: 140.r,
                          height: 140.r,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: AppColors.dangerGradient,
                            boxShadow: AppColors.dangerShadow(),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.error_outline,
                              size: 56.r,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      verticalSpace(24),
                    ] else ...[
                      // Fallback static icon
                      Container(
                        width: 140.r,
                        height: 140.r,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: AppColors.dangerGradient,
                          boxShadow: AppColors.dangerShadow(),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.error_outline,
                            size: 56.r,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      verticalSpace(24),
                    ],

                    // Error message with proper styling
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.r),
                      child: Text(
                        widget.error,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.almarai(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                          color: context.textColor,
                        ),
                      ),
                    ),
                    verticalSpace(32),

                    // Animated retry button
                    AnimatedBuilder(
                      animation: _shakeAnimation,
                      builder: (context, child) {
                        return Transform.translate(
                          offset: Offset(
                            _shakeAnimation.value *
                                2 *
                                (_shakeAnimation.value - 0.5),
                            0,
                          ),
                          child: Container(
                            width: 140.w,
                            height: 48.h,
                            decoration: BoxDecoration(
                              gradient: AppColors.primaryGradient(context),
                              borderRadius: BorderRadius.circular(24.r),
                              boxShadow: AppColors.primaryShadow(context),
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: _handleRetryPress,
                                borderRadius: BorderRadius.circular(24.r),
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.refresh_rounded,
                                        color: Colors.white,
                                        size: 20.r,
                                      ),
                                      horizontalSpace(8),
                                      Text(
                                        widget.retryText,
                                        style: GoogleFonts.almarai(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    } catch (e) {
      // Fallback widget in case of any build errors
      debugPrint('FailedWidget build failed: $e');
      return _buildFallbackWidget(context);
    }
  }

  Widget _buildFallbackWidget(BuildContext context) {
    try {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 56.r,
              color: context.primaryColor,
            ),
            verticalSpace(16),
            Text(
              widget.error,
              textAlign: TextAlign.center,
              style: GoogleFonts.almarai(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            verticalSpace(24),
            SizedBox(
              width: 120.w,
              child: ElevatedButton(
                onPressed: widget.onPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: context.primaryColor,
                  foregroundColor: Colors.white,
                ),
                child: Text(widget.retryText),
              ),
            ),
          ],
        ),
      );
    } catch (e) {
      // Ultimate fallback
      debugPrint('Fallback widget also failed: $e');
      return const Center(
        child: Text('Something went wrong'),
      );
    }
  }
}
