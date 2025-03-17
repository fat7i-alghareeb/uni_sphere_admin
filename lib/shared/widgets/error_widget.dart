// 📦 Package imports:
import 'package:lottie/lottie.dart';

// 🌎 Project imports:
import '../../core/styles/colors.dart';
import '../imports/imports.dart';

class CustomErrorWidget extends StatelessWidget {
  const CustomErrorWidget({
    super.key,
    required this.assets,
    required this.title,
    required this.description,
    this.onPressed,
  });

  final String assets;
  final String title;
  final String description;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                SizedBox(
                  width: 300.r,
                  height: 300.r,
                  child: assets.contains('svg')
                      ? SvgPicture.asset(assets)
                      : Lottie.asset(assets),
                ),
                Text(
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .displayLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: EdgeInsets.all(16.r),
                  child: Text(
                    description,
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(color: AppColors.grey),
                  ),
                ),
                SizedBox(
                  width: 118.w,
                  child: ElevatedButton(
                    onPressed: onPressed,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.secondary,
                    ),
                    child: Text("try again test test test "),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
