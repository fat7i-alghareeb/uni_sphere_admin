// ignore_for_file: empty_catches, must_be_immutable

// 🌎 Project imports:

// Custom dropdown menu widget

import 'package:uni_sphere_admin/shared/entities/drop_down_data.dart';
import 'package:uni_sphere_admin/shared/imports/imports.dart';

class CustomDropDownMenuMain<T> extends StatefulWidget {
  CustomDropDownMenuMain({
    super.key,
    required this.data,
    required this.hintText,
    required this.onSelect,
    required this.selectedItem,
    required this.enableSearch,
    required this.isError,
    required this.validationMessage,
    required this.width,
    required this.isItemRequired,
    this.hintTextStyle,
    this.trailingIcon = const Icon(Icons.arrow_drop_down),
    this.leadingIcon,
    this.maxHeight,
    this.onFormattedSelect,
    this.onSearchCallback,
    this.isCustomerNumber = false,
  });
  final bool isItemRequired;

  // List of dropdown items
  final List<DropDownData> data;

  // Hint text to display when no item is selected
  final String? hintText;

  // Callback for when an item is selected
  final void Function(String? name, String? id) onSelect;
  final void Function(String query)? onSearchCallback;
  final void Function(DropDownData?)? onFormattedSelect;

  // Currently selected dropdown item
  final DropDownData? selectedItem;

  // Whether search is enabled within the dropdown
  final bool enableSearch;

  // Whether there is a validation error
  bool? isError;

  // Validation error message
  final String? validationMessage;

  // Width of the dropdown menu
  final double width;

  // Optional text style for the hint text
  final TextStyle? hintTextStyle;

  // Optional maximum height of the dropdown
  final double? maxHeight;

  // Icon to display at the end of the dropdown
  final Widget trailingIcon;

  // Optional icon to display at the start of the dropdown
  final Widget? leadingIcon;

  final bool isCustomerNumber;
  @override
  State<CustomDropDownMenuMain> createState() => _CustomDropDownMenuMainState();
}

class _CustomDropDownMenuMainState extends State<CustomDropDownMenuMain> {
  TextEditingController textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // Controller for the dropdown's input field

    // if (widget.onSearchCallback == null) {
    textController.text = (widget.isCustomerNumber == true)
        ? widget.selectedItem?.id ?? ''
        : widget.selectedItem?.name ?? '';
    // }

    return DropdownMenu<DropDownData>(
      controller: textController,
      width: widget.width,
      hintText: widget.hintText,
      enableSearch: widget.enableSearch,

      // Styling for the input field
      inputDecorationTheme: InputDecorationTheme(
        constraints: BoxConstraints(
          maxHeight: widget.maxHeight ?? (widget.isError == true ? 67.h : 47.h),
        ),
        fillColor: context.primaryColor.withValues(alpha: 0.1),
        hintStyle: widget.hintTextStyle ??
            TextStyle(
              color: context.greyColor,
              fontSize: 12.sp,
            ),
        filled: true,
        contentPadding: REdgeInsets.symmetric(vertical: 14, horizontal: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: context.greyColor.withValues(alpha: 0.15)),
          borderRadius: BorderRadius.circular(12.r),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: context.greyColor.withValues(alpha: 0.15)),
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),

      // Handles search functionality
      searchCallback: (entries, query) {
        if (query.isEmpty) {
          return null;
        }

        final int index = entries.indexWhere(
          (DropdownMenuEntry entry) => entry.label == query,
        );
        // if (widget.onSearchCallback != null) {
        //   if (index == -1) {
        //     widget.onSearchCallback!(query);
        //   }
        // }
        return index != -1 ? index : null;
      },

      // Display validation error message if any
      errorText: widget.isError == true ? widget.validationMessage : null,

      // Height of the dropdown menu
      menuHeight: context.screenHeight * 0.3,

      // Automatically focus the search field on tap
      requestFocusOnTap: widget.enableSearch,

      expandedInsets: REdgeInsets.symmetric(horizontal: 0),
      enableFilter: widget.enableSearch,

      textStyle: TextStyle(
        fontSize: 15.sp,
        color: const Color(0xFF4B465C),
        fontWeight: FontWeight.w400,
      ),

      // Callback for when an item is selected
      onSelected: (DropDownData? item) {
        if (item != null) {
          widget.onSelect(item.name, item.id);
          if (widget.onFormattedSelect != null) {
            widget.onFormattedSelect!(item);
          }
          widget.isError = false;

          if (context.mounted) {
            FocusScope.of(context).unfocus();
            setState(() {});
          }
        }
      },

      // Trailing icon with clear functionality
      trailingIcon: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.selectedItem?.name != null && !widget.isItemRequired)
            InkWell(
              onTap: () {
                widget.onSelect(null, null);
                if (widget.onFormattedSelect != null) {
                  widget.onFormattedSelect!(null);
                }
                if (context.mounted) {
                  setState(() {});
                }
              },
              child: Icon(
                Icons.close,
                size: 20.h,
                color: const Color(0xFF1D1B20),
              ),
            ),
          widget.trailingIcon,
        ],
      ),

      // Leading icon (optional)
      leadingIcon: widget.leadingIcon,

      // Dropdown menu entries
      dropdownMenuEntries: widget.data.map<DropdownMenuEntry<DropDownData>>(
        (DropDownData menu) {
          return DropdownMenuEntry(
            value: menu,
            label: menu.name ?? '',
          );
        },
      ).toList(),
    );
  }
}
