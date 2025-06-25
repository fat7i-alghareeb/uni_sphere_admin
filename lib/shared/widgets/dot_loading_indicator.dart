import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DotLoadingIndicator extends StatefulWidget {
  final Color color;
  final double dotSize;
  final double spacing;
  final Duration duration;
  final double? height;
  final double? width;
  final MainAxisAlignment? mainAxisAlignment;
  const DotLoadingIndicator({
    super.key,
    required this.color,
    this.dotSize = 6,
    this.spacing = 4.0,
    this.duration = const Duration(milliseconds: 300),
    this.height,
    this.width,
    this.mainAxisAlignment,
  });

  @override
  State<DotLoadingIndicator> createState() => _DotLoadingIndicatorState();
}

class _DotLoadingIndicatorState extends State<DotLoadingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Animation<double>> _dotAnimations;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration * 2,
    )..repeat();

    _dotAnimations = List.generate(3, (index) {
      final delay = index * 0.2;
      return TweenSequence<double>([
        TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.0), weight: 0.5),
        TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.0), weight: 0.5),
      ]).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(delay, 1.0, curve: Curves.easeInOut),
        ),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height?.h,
      width: widget.width?.w,
      child: Row(
        mainAxisAlignment: widget.mainAxisAlignment ?? MainAxisAlignment.center,
        children: List.generate(3, (index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: (widget.spacing.w) / 2),
            child: AnimatedBuilder(
              animation: _dotAnimations[index],
              builder: (context, child) {
                return Opacity(
                  opacity: _dotAnimations[index].value,
                  child: child,
                );
              },
              child: Container(
                width: widget.dotSize.r,
                height: widget.dotSize.r,
                decoration: BoxDecoration(
                  color: widget.color,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
