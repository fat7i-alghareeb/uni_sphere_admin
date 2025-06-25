// 🐦 Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show Icons;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uni_sphere_admin/features/access/presentation/input_forms/auth_input_keys.dart' show AuthInputKeys;
import 'package:uni_sphere_admin/shared/extensions/context_extension.dart';
import 'package:uni_sphere_admin/shared/widgets/custom_reative_field.dart' show CustomReactiveField;

class PasswordField extends StatelessWidget {
  const PasswordField({
    super.key,
    required this.isConfirmPassword,
    required this.hintText,
    this.isOldPassword = false,
    this.withTitle = false,
    this.readOnly = false,
  });
  final bool isConfirmPassword;
  final bool isOldPassword;
  final bool withTitle;
  final String hintText;
  final bool readOnly;
  @override
  Widget build(BuildContext context) {
    return CustomReactiveField(
      // fillColor: AppColors.lightPrimary.withOpacity(0.08),
      controller: isOldPassword
          ? AuthInputKeys.oldPassword
          : isConfirmPassword
              ? AuthInputKeys.confirmPassword
              : AuthInputKeys.password,
      keyboardType: TextInputType.text,
      assetPrefix: Icon(
        Icons.lock_outline,
        color:
            context.greyColor.withValues(alpha: context.isLightMode ? 1 : 0.5),
        size: 24.sp,
      ),
      isPassword: true,
      asset: Icon(
        CupertinoIcons.eye_slash,
        color:
            context.greyColor.withValues(alpha: context.isLightMode ? 1 : 0.5),
        size: 24.sp,
      ),
      suffixPassIcon: Icon(
        CupertinoIcons.eye,
        color:
            context.greyColor.withValues(alpha: context.isLightMode ? 1 : 0.5),
        size: 24.sp,
      ),
      title: withTitle ? hintText : null,
      hintText: hintText,
      readOnly: readOnly,
    );
  }
}
