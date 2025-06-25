// ignore_for_file: must_be_immutable, deprecated_member_use

// 📦 Package imports:
import 'package:reactive_forms/reactive_forms.dart';
import 'package:uni_sphere_admin/common/constant/app_strings.dart' show AppStrings;

// 🌎 Project imports:
import '../imports/imports.dart';

class CustomDropDown extends StatelessWidget {
  CustomDropDown({
    super.key,
    this.title,
    required this.controller,
    required this.items,
    this.hintText,
    this.onChanged,
    this.focusedBorder,
  });

  final String? hintText;
  final String controller;
  final String? title;
  void Function(FormControl<dynamic>)? onChanged;
  List<DropdownMenuItem<dynamic>> items;
  final InputBorder? focusedBorder;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title != null
            ? Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.r),
                child: Text(
                  title!,
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              )
            : const SizedBox(),
        SizedBox(
          height: title != null ? 8.h : 0,
        ),
        ReactiveDropdownField(
          items: items,
          borderRadius: BorderRadius.circular(16),
          isExpanded: true,
          formControlName: controller,
          validationMessages: {
            ValidationMessage.required: (e) => AppStrings.thisFieldRequired,
            ValidationMessage.email: (e) => AppStrings.validEmail,
            ValidationMessage.minLength: (e) => AppStrings.passwordMinLength,
            ValidationMessage.mustMatch: (e) => AppStrings.mustMatch,
          },
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: hintText,
            contentPadding: REdgeInsets.symmetric(vertical: 8, horizontal: 16),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(32)),
            enabledBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32)),
            focusedBorder: focusedBorder ??
                OutlineInputBorder(
                    borderSide: BorderSide(color: context.primaryColor),
                    borderRadius: BorderRadius.circular(16)),
            errorBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32)),
            hintStyle: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(color: context.greyColor.withValues(alpha: 0.5)),
          ),
        ),
      ],
    );
  }
}
