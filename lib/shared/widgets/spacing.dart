// 🐦 Flutter imports:

// 🐦 Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// 📦 Package imports:

SizedBox verticalSpace(double height) => SizedBox(
      height: height.h,
    );

SizedBox horizontalSpace(double width) => SizedBox(
      width: width.w,
    );

SliverToBoxAdapter sliverVerticalSpace(double height) => SliverToBoxAdapter(
      child: verticalSpace(height),
    );
