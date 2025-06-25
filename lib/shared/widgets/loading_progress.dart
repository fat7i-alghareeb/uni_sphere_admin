// 🌎 Project imports:
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../imports/imports.dart';

// Custom widget to control the size of the ResponsiveCircularProgressIndicator globally
class LoadingProgress extends StatelessWidget {
  final double size;
  final double strokeWidth;
  final Color? color;

  const LoadingProgress({
    super.key,
    this.size = 60,
    this.strokeWidth = 3,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpinKitCircle(
        color: color ?? context.primaryColor,
        size: size.r,
      ),
    );
  }
}
