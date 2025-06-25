import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'custom_page_header.dart';
import '../../core/constants/app_constants.dart';
import '../extensions/context_extension.dart';

import '../../gen/assets.gen.dart';

class CustomScaffoldBody extends StatelessWidget {
  const CustomScaffoldBody({super.key, required this.child, this.title});
  final Widget child;
  final String? title;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(Assets.images.patternNew.keyName),
          repeat: ImageRepeat.repeat,
          colorFilter: ColorFilter.mode(
            context.onBackgroundColor.withValues(alpha: 0.05),
            BlendMode.srcIn,
          ),
        ),
      ),
      child: Column(
        children: [
          if (title != null) 55.verticalSpace,
          if (title != null)
            Padding(
                padding: REdgeInsets.symmetric(
                  horizontal: AppConstants.horizontalScreensPadding,
                  vertical: 5,
                ),
                child: CustomPageHeader(title: title!)),
          Expanded(child: child),
        ],
      ),
    );
  }
}
