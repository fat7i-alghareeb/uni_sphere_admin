import '../imports/imports.dart';

class CustomShimmerWidget extends StatelessWidget {
  final EdgeInsetsGeometry padding;
  final double? height;
  final double? width;
  final double? borderRadius;
  final Color? color;
  const CustomShimmerWidget({
    super.key,
    required this.padding,
    this.height,
    this.width,
    this.borderRadius,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Container(
        height: height?.h,
        width: width?.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius?.r ?? 0),
          color: color ?? Colors.grey.shade600.withOpacity(0.7),
        ),
      ),
    );
  }
}
