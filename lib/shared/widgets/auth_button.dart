// 🌎 Project imports:

import 'package:flutter/services.dart';
import 'package:uni_sphere_admin/core/styles/colors.dart' show AppColors;
import 'package:uni_sphere_admin/shared/imports/imports.dart' ;
import 'package:uni_sphere_admin/shared/widgets/loading_progress.dart' show LoadingProgress;

class AuthButton extends StatefulWidget {
  final bool isLoading;
  final String title;
  final void Function() onPressed;
  final LinearGradient? gradient;
  final List<BoxShadow>? shadow;
  final Widget? child;
  final double? height;
  final double? width;
  final REdgeInsets? margin;
  final double? borderRadius;

  const AuthButton({
    super.key,
    this.isLoading = false,
    required this.title,
    required this.onPressed,
    this.gradient,
    this.child,
    this.margin,
    this.shadow,
    this.height,
    this.width,
    this.borderRadius,
  });

  factory AuthButton.primary({
    required String title,
    required void Function() onPressed,
    bool isLoading = false,
    double? height,
    double? width,
    double? borderRadius,
    required BuildContext context,
  }) {
    return AuthButton(
      title: title,
      onPressed: onPressed,
      isLoading: isLoading,
      gradient: AppColors.primaryGradient(context),
      shadow: AppColors.primaryShadow(context),
      height: height,
      width: width,
      borderRadius: borderRadius,
    );
  }

  factory AuthButton.danger({
    required String title,
    required void Function() onPressed,
    bool isLoading = false,
    double? height,
    double? width,
    double? borderRadius,
  }) {
    return AuthButton(
      title: title,
      onPressed: onPressed,
      isLoading: isLoading,
      gradient: AppColors.dangerGradient,
      shadow: AppColors.dangerShadow(),
      height: height,
      width: width,
      borderRadius: borderRadius,
    );
  }

  // factory AuthButton.warning({
  //   required String title,
  //   required void Function() onPressed,
  //   bool isLoading = false,
  //   double? height,
  //   double? width,
  //   double? borderRadius,
  // }) {
  //   return AuthButton(
  //     title: title,
  //     onPressed: onPressed,
  //     isLoading: isLoading,
  //     gradient: AppColors.warningGradient,
  //     shadow: AppColors.warningShadow,
  //     height: height,
  //     width: width,
  //     borderRadius: borderRadius,
  //   );
  // }

  @override
  State<AuthButton> createState() => _AuthButtonState();
}

class _AuthButtonState extends State<AuthButton>
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
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.97).animate(
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
        if (!widget.isLoading) {
          setState(() => _isPressed = true);
          _animationController.forward();
          HapticFeedback.lightImpact();
        }
      },
      onTapUp: (_) {
        if (!widget.isLoading) {
          setState(() => _isPressed = false);
          _animationController.reverse();
          widget.onPressed();
        }
      },
      onTapCancel: () {
        if (!widget.isLoading) {
          setState(() => _isPressed = false);
          _animationController.reverse();
        }
      },
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) => Transform.scale(
          scale: _isPressed ? _scaleAnimation.value : 1.0,
          child: Container(
            width: widget.width ?? context.screenWidth,
            height: widget.height ?? 40.h,
            margin: widget.margin,
            decoration: BoxDecoration(
              gradient: widget.gradient ?? AppColors.primaryGradient(context),
              borderRadius:
                  BorderRadius.circular(widget.borderRadius?.r ?? 12.r),
              boxShadow: widget.shadow ??
                  [
                    BoxShadow(
                      offset: const Offset(0, 12),
                      blurRadius: 20,
                      color: context.primaryColor.withValues(alpha: 0.3),
                    ),
                    BoxShadow(
                      offset: const Offset(0, 8),
                      blurRadius: 16,
                      color: context.primaryColor.withValues(alpha: 0.3),
                    ),
                  ],
            ),
            alignment: Alignment.center,
            child: widget.isLoading
                ? Center(
                    child: LoadingProgress(
                      color: AppColors.white,
                      size: 30.h,
                    ),
                  )
                : widget.child ??
                    Text(
                      widget.title,
                      style: context.textTheme.bodyLarge!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
          ),
        ),
      ),
    );
  }
}

class OutLinedButton extends StatelessWidget {
  final bool isLoading;
  final Widget? child;
  final String title;
  final Color color;
  final void Function() onPressed;

  const OutLinedButton({
    super.key,
    required this.isLoading,
    required this.title,
    this.child,
    this.color = Colors.transparent,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isLoading ? () {} : onPressed,
      child: Container(
        width: context.screenWidth,
        height: 40.h,
        decoration: BoxDecoration(
          border: Border.all(color: color),
          borderRadius: BorderRadius.circular(12.r),
        ),
        alignment: Alignment.center,
        child: isLoading
            ? Center(
                child: LoadingProgress(
                  size: 30.h,
                ),
              )
            : child ??
                Text(
                  title,
                  style: context.textTheme.headlineMedium!.copyWith(
                    color: color,
                  ),
                ),
      ),
    );
  }
}
