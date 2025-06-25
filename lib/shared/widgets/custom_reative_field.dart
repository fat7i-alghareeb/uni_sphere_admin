// ignore_for_file: must_be_immutable

// 📦 Package imports:
import 'package:reactive_forms/reactive_forms.dart';
import 'package:flutter/services.dart';
// 🌎 Project imports:

import '../../common/constant/app_strings.dart' show AppStrings;
import '../../core/styles/colors.dart' show AppColors;
import '../imports/imports.dart';

class CustomReactiveField extends StatelessWidget {
  CustomReactiveField({
    super.key,
    this.hintText,
    this.textInputAction = TextInputAction.next,
    required this.controller,
    this.initialValue,
    this.isExpend = false,
    this.onSuffixTap,
    this.maxLines = 1,
    this.onPrefixTap,
    this.height,
    this.width,
    this.onChanged,
    this.assetPrefix,
    this.textDirection,
    this.asset,
    this.borderRadius = const BorderRadius.all(Radius.circular(12)),
    this.borderAlwaysEnable = false,
    this.keyboardType = TextInputType.text,
    this.readOnly = false,
    this.isPassword = false,
    this.title,
    this.onTap,
    this.fill = true,
    this.titleColor,
    this.suffixPassIcon,
    this.fieldPadding,
    this.prefixPadding,
    this.suffixPadding,
    this.fillColor,
    this.onEditingComplete,
    this.isRequired = false,
    this.inputFormatters,
    this.minLengthValidatorMessage,
  });
  final String? hintText;
  final Object? asset;
  final Object? assetPrefix;
  final String? initialValue;
  final TextInputAction textInputAction;
  final TextDirection? textDirection;
  final TextInputType keyboardType;
  final String controller;
  final int maxLines;
  final double? height;
  final bool isExpend;
  final VoidCallback? onSuffixTap;
  final BorderRadius borderRadius;
  final VoidCallback? onPrefixTap;
  final Function(FormControl<dynamic>)? onChanged;
  final double? width;
  final bool borderAlwaysEnable;
  final bool readOnly;
  final ReactiveFormFieldCallback? onTap;
  final String? title;
  final Color? titleColor;
  final bool fill;
  final Object? suffixPassIcon;
  bool isPassword;
  final EdgeInsets? fieldPadding;
  final EdgeInsets? prefixPadding;
  final EdgeInsets? suffixPadding;
  final Color? fillColor;
  final void Function()? onEditingComplete;
  final bool isRequired;
  final List<TextInputFormatter>? inputFormatters;
  final String? minLengthValidatorMessage;
  bool hidden = true;
  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, setState) {
      final borderColor = context.greyColor.withValues(alpha: 0.5);
      return IgnorePointer(
        ignoring: readOnly,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            title != null
                ? Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.r),
                    child: Row(
                      children: [
                        Text(
                          title!,
                          style: context.textTheme.bodyLarge?.copyWith(
                            color: Colors.black,
                            fontSize: 15.sp,
                          ),
                        ),
                        if (isRequired)
                          Text(
                            "*",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(color: AppColors.danger),
                          ),
                      ],
                    ),
                  )
                : const SizedBox(),
            SizedBox(
              height: title != null ? 8.h : 0,
            ),
            ReactiveTextField(
              formControlName: controller,
              maxLines: isExpend ? null : maxLines,
              minLines: isExpend ? null : maxLines,
              expands: isExpend,
              readOnly: readOnly,
              onTap: onTap,
              keyboardType: keyboardType,
              obscuringCharacter: "*",
              textInputAction: textInputAction,
              validationMessages: {
                ValidationMessage.required: (e) => AppStrings.thisFieldRequired,
                ValidationMessage.email: (e) => AppStrings.validEmail,
                ValidationMessage.min: (e) => AppStrings.minValue,
                ValidationMessage.minLength: (e) =>
                    minLengthValidatorMessage ?? AppStrings.passwordMinLength,
                ValidationMessage.mustMatch: (e) => AppStrings.mustMatch,
              },
              onChanged: onChanged,
              textDirection: textDirection,
              inputFormatters: inputFormatters,
              decoration: InputDecoration(
                hintText: hintText,
                errorStyle: context.textTheme.labelSmall!
                    .copyWith(color: AppColors.danger),
                // hintTextDirection: hintText?.textDirection,
                filled: fill,
                fillColor: readOnly
                    ? context.greyColor.withValues(alpha: 0.5)
                    : fillColor ?? context.primaryColor.withValues(alpha: 0.08),
                contentPadding: fieldPadding ??
                    REdgeInsets.symmetric(vertical: 8, horizontal: 16),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: borderColor),
                  borderRadius: borderRadius,
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: borderColor),
                ),
                disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: borderColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: context.primaryColor),
                  borderRadius: borderRadius,
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: AppColors.danger),
                  borderRadius: borderRadius,
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: AppColors.danger),
                  borderRadius: borderRadius,
                ),
                hintStyle: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: context.greyColor.withValues(alpha: 0.5)),
                labelStyle: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: context.greyColor.withValues(alpha: 0.9)),
                prefixIcon: assetPrefix != null
                    ? GestureDetector(
                        onTap: onPrefixTap,
                        child: Padding(
                          padding: prefixPadding ??
                              EdgeInsets.symmetric(
                                  horizontal: 16.r, vertical: 6.r),
                          child: assetPrefix is String
                              ? SvgPicture.asset(assetPrefix!.toString())
                              : assetPrefix! as Widget,
                        ),
                      )
                    : null,
                suffixIcon: asset != null
                    ? GestureDetector(
                        onTap: isPassword && suffixPassIcon != null
                            ? () {
                                setState(() {
                                  hidden = !hidden;
                                });
                              }
                            : onSuffixTap,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 22),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              AnimatedCrossFade(
                                alignment: Alignment.centerRight,
                                firstChild: asset is String
                                    ? SvgPicture.asset(asset!.toString())
                                    : asset! as Widget,
                                secondChild: suffixPassIcon is String
                                    ? SvgPicture.asset(
                                        suffixPassIcon!.toString())
                                    : suffixPassIcon! as Widget,
                                crossFadeState: hidden
                                    ? CrossFadeState.showSecond
                                    : CrossFadeState.showFirst,
                                duration: const Duration(milliseconds: 400),
                              ),
                            ],
                          ),
                        ),
                      )
                    : null,
              ),
              obscureText: isPassword && hidden,
            ),
          ],
        ),
      );
    });
  }
}
