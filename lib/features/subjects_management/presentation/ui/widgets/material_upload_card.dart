import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:file_picker/file_picker.dart'
    show FilePicker, FileType;
import 'package:reactive_forms/reactive_forms.dart';
import 'package:uni_sphere_admin/common/constant/app_strings.dart';
import 'package:uni_sphere_admin/core/injection/injection.dart';
import 'package:uni_sphere_admin/core/result_builder/result.dart';
import 'package:uni_sphere_admin/features/subjects_management/presentation/state/bloc/get_subjects_bloc.dart';
import 'package:uni_sphere_admin/shared/imports/imports.dart';
import 'package:uni_sphere_admin/shared/widgets/custom_reative_field.dart';
import 'package:uni_sphere_admin/features/subjects_management/services/material_types.dart'
    as mt;

class MaterialUploadCard extends StatefulWidget {
  const MaterialUploadCard({
    super.key,
    required this.subjectId,
    required this.onMaterialUploaded,
  });

  final String subjectId;
  final VoidCallback onMaterialUploaded;

  @override
  State<MaterialUploadCard> createState() => _MaterialUploadCardState();
}

class _MaterialUploadCardState extends State<MaterialUploadCard> {
  late FormGroup _formGroup;
  bool _isUploading = false;
  bool _isFileSelected = false;
  String? _selectedFilePath;
  String? _selectedFileName;

  @override
  void initState() {
    super.initState();
    _initializeForm();
  }

  void _initializeForm() {
    _formGroup = FormGroup({
      'materialUrl': FormControl<String>(
        validators: [
          Validators.required,
          Validators.pattern(
            r'^https?://.+',
            validationMessage: 'Please enter a valid URL',
          ),
        ],
      ),
    });
  }

  @override
  void dispose() {
    _formGroup.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: REdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.cardColor,
        borderRadius: BorderRadius.circular(22.r),
        boxShadow: [
          BoxShadow(
            color: context.primaryColor.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.uploadMaterial,
            style:
                context.textTheme.titleMedium!.withColor(context.primaryColor),
          ),
          16.verticalSpace,
          ReactiveForm(
            formGroup: _formGroup,
            child: Column(
              children: [
                _buildFilePickerSection(),
                16.verticalSpace,
                _buildUrlInputSection(),
                16.verticalSpace,
                _buildUploadButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilePickerSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.selectFile,
          style: context.textTheme.bodyMedium!
              .withColor(context.onBackgroundColor),
        ),
        8.verticalSpace,
        GestureDetector(
          onTap: _isUploading ? null : _pickFile,
          child: Container(
            width: double.infinity,
            padding: REdgeInsets.all(16),
            decoration: BoxDecoration(
              color: context.primaryColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: context.primaryColor.withValues(alpha: 0.3),
                width: 2,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.upload_file,
                  color: context.primaryColor,
                  size: 24.r,
                ),
                12.horizontalSpace,
                Expanded(
                  child: Text(
                    _isFileSelected
                        ? _selectedFileName ?? 'File selected'
                        : 'Tap to select a file',
                    style: context.textTheme.bodyMedium!.copyWith(
                      color: _isFileSelected
                          ? context.onBackgroundColor
                          : context.greyColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildUrlInputSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                height: 1,
                color: context.greyColor.withValues(alpha: 0.3),
              ),
            ),
            12.horizontalSpace,
            Text(
              AppStrings.or,
              style: context.textTheme.bodySmall!.copyWith(
                color: context.greyColor,
              ),
            ),
            12.horizontalSpace,
            Expanded(
              child: Container(
                height: 1,
                color: context.greyColor.withValues(alpha: 0.3),
              ),
            ),
          ],
        ),
        16.verticalSpace,
        Text(
          AppStrings.enterMaterialUrl,
          style: context.textTheme.bodyMedium!
              .withColor(context.onBackgroundColor),
        ),
        8.verticalSpace,
        CustomReactiveField(
          controller: 'materialUrl',
          hintText: 'https://example.com/material.pdf',
          readOnly: _isFileSelected,
        ),
      ],
    );
  }

  Widget _buildUploadButton() {
    return BlocConsumer<GetSubjectsBloc, SubjectState>(
      listenWhen: (previous, current) =>
          previous.operationResult != current.operationResult,
      listener: (context, state) {
        if (state.operationResult.isError()) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.operationResult.getError()),
              backgroundColor: Colors.red,
            ),
          );
        }
        if (state.operationResult.isLoaded()) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Material uploaded successfully'),
              backgroundColor: Colors.green,
            ),
          );
          _resetForm();
          widget.onMaterialUploaded();
        }
      },
      builder: (context, state) {
        final isLoading = state.operationResult.isLoading() || _isUploading;

        return SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: isLoading ? null : _handleUpload,
            style: ElevatedButton.styleFrom(
              backgroundColor: context.primaryColor,
              foregroundColor: Colors.white,
              padding: REdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            child: isLoading
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 20.r,
                        height: 20.r,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      ),
                      8.horizontalSpace,
                      Text(AppStrings.uploading),
                    ],
                  )
                : Text(AppStrings.uploadMaterial),
          ),
        );
      },
    );
  }

  Future<void> _pickFile() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowMultiple: false,
        allowedExtensions: mt.MaterialTypeUtils.getAllowedExtensions(),
      );

      if (result != null && result.files.isNotEmpty) {
        final file = result.files.first;

        // Check if file type is restricted
        final extension = file.extension?.toLowerCase() ?? '';
        if (mt.MaterialTypeUtils.isRestrictedFileType(extension)) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Video and audio files are not allowed'),
              backgroundColor: Colors.orange,
            ),
          );
          return;
        }

        setState(() {
          _selectedFilePath = file.path;
          _selectedFileName = file.name;
          _isFileSelected = true;
        });

        // Clear URL input when file is selected
        _formGroup.control('materialUrl').reset();
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error picking file: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _handleUpload() async {
    if (!_isFileSelected && !_formGroup.valid) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please select a file or enter a valid URL'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    setState(() {
      _isUploading = true;
    });

    try {
      if (_isFileSelected && _selectedFilePath != null) {
        // Handle file upload
        await _uploadFile();
      } else {
        // Handle URL upload
        await _uploadUrl();
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Upload failed: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        _isUploading = false;
      });
    }
  }

  Future<void> _uploadFile() async {
    final file = File(_selectedFilePath!);
    getIt<GetSubjectsBloc>().add(
      UploadMaterialEvent(
        id: widget.subjectId,
        file: file,
        url: null,
      ),
    );
  }

  Future<void> _uploadUrl() async {
    final url = _formGroup.control('materialUrl').value as String;

    getIt<GetSubjectsBloc>().add(
      UploadMaterialEvent(
        id: widget.subjectId,
        file: null,
        url: url,
      ),
    );
  }

  void _resetForm() {
    setState(() {
      _isFileSelected = false;
      _selectedFilePath = null;
      _selectedFileName = null;
    });
    _formGroup.reset();
  }
}
