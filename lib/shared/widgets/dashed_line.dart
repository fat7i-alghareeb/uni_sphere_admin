import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DashedLinePainter extends CustomPainter {
  final Color dashColor;
  final Color gapColor;
  final double strokeWidth;
  final double dashWidth;
  final double dashHeight;
  final double gapWidth;
  final double gapHeight;
  final bool isVertical;

  DashedLinePainter({
    required this.dashColor,
    required this.gapColor,
    this.strokeWidth = 2.0,
    this.dashWidth = 10.0,
    this.dashHeight = 2.0,
    this.gapWidth = 10.0,
    this.gapHeight = 2.0,
    this.isVertical = false,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint dashPaint = Paint()
      ..color = dashColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.fill;

    Paint gapPaint = Paint()
      ..color = gapColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.fill;

    double position = 0;

    if (isVertical) {
      while (position < size.height) {
        // Draw dash
        canvas.drawRect(
          Rect.fromLTWH(
            (size.width - dashWidth) / 2, // Centered horizontally
            position,
            dashWidth,
            dashHeight,
          ),
          dashPaint,
        );

        position += dashHeight; // Move down by dash height

        // Draw gap
        canvas.drawRect(
          Rect.fromLTWH(
            (size.width - gapWidth) / 2, // Centered horizontally
            position,
            gapWidth,
            gapHeight,
          ),
          gapPaint,
        );

        position += gapHeight; // Move down by gap height
      }
    } else {
      while (position < size.width) {
        // Draw dash
        canvas.drawRect(
          Rect.fromLTWH(
            position,
            (size.height - dashHeight) / 2, // Centered vertically
            dashWidth,
            dashHeight,
          ),
          dashPaint,
        );

        position += dashWidth; // Move right by dash width

        // Draw gap
        canvas.drawRect(
          Rect.fromLTWH(
            position,
            (size.height - gapHeight) / 2, // Centered vertically
            gapWidth,
            gapHeight,
          ),
          gapPaint,
        );

        position += gapWidth; // Move right by gap width
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class DashedLine extends StatelessWidget {
  final double height;
  final double width;
  final Color dashColor;
  final Color gapColor;
  final double strokeWidth;
  final double dashWidth;
  final double dashHeight;
  final double gapWidth;
  final double gapHeight;
  final bool isVertical;

  const DashedLine({
    super.key,
    this.height = 1,
    this.width = 1,
    this.dashColor = Colors.black,
    this.gapColor = Colors.transparent,
    this.strokeWidth = 1,
    this.dashWidth = 1,
    this.dashHeight = 1,
    this.gapWidth = 1,
    this.gapHeight = 1,
    this.isVertical = false,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(width, height),
      painter: DashedLinePainter(
        dashColor: dashColor,
        gapColor: gapColor,
        strokeWidth: strokeWidth.w,
        dashWidth: dashWidth.w,
        dashHeight: dashHeight.h,
        gapWidth: gapWidth.w,
        gapHeight: gapHeight.h,
        isVertical: isVertical,
      ),
    );
  }
}
