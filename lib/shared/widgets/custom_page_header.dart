import 'package:beamer/beamer.dart';

import '../imports/imports.dart';

class CustomPageHeader extends StatelessWidget {
  const CustomPageHeader({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 20.r,
          height: 20.r,
        ),
        Text(
          title,
          style: context.textTheme.titleSmall!.copyWith(
            fontSize: 18.r,
            color: context.onBackgroundColor,
          ),
        ),
        GestureDetector(
          onTap: () {
            context.beamBack();
          },
          child: Icon(
            Icons.arrow_forward_ios_rounded,
            color: context.onBackgroundColor,
            size: 20.r,
          ),
        ),
      ],
    );
  }
}
