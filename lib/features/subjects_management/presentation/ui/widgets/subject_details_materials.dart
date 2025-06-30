import 'dart:io';
import 'package:uni_sphere_admin/common/constant/app_strings.dart';
import 'package:uni_sphere_admin/core/injection/injection.dart';
import 'package:uni_sphere_admin/core/result_builder/result.dart';
import 'package:uni_sphere_admin/features/subjects_management/data/models/subjects_management_model.dart';
import 'package:uni_sphere_admin/features/subjects_management/presentation/state/bloc/get_subjects_bloc.dart';
import 'package:uni_sphere_admin/shared/entities/role.dart';
import 'package:uni_sphere_admin/shared/imports/imports.dart';
import 'package:uni_sphere_admin/shared/widgets/custom_reative_field.dart';

class SubjectDetailsMaterials extends StatefulWidget {
  const SubjectDetailsMaterials({
    super.key,
    required this.subject,
    required this.onMaterialUploaded,
  });

  final Subject subject;
  final VoidCallback onMaterialUploaded;

  @override
  State<SubjectDetailsMaterials> createState() =>
      _SubjectDetailsMaterialsState();
}

class _SubjectDetailsMaterialsState extends State<SubjectDetailsMaterials> {
  final TextEditingController _urlController = TextEditingController();
  File? _selectedFile;
  final bool _isUploading = false;

  @override
  void dispose() {
    _urlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: REdgeInsets.symmetric(
        horizontal: AppConstants.horizontalScreensPadding,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDescription(context),
          18.verticalSpace,
          _buildMaterials(context),
          if (AppConstants.userRole == Role.professor) ...[
            18.verticalSpace,
            _buildUploadSection(context),
          ],
        ],
      ),
    );
  }

  Widget _buildDescription(BuildContext context) {
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
            AppStrings.subjectDescription,
            style:
                context.textTheme.titleMedium!.withColor(context.primaryColor),
          ),
          16.verticalSpace,
          Text(
            widget.subject.description,
            style: context.textTheme.bodyMedium!
                .withColor(context.onBackgroundColor),
          ),
        ],
      ),
    );
  }

  Widget _buildMaterials(BuildContext context) {
    if (widget.subject.materialUrls.isEmpty) {
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
              AppStrings.materials,
              style: context.textTheme.titleMedium!
                  .withColor(context.primaryColor),
            ),
            16.verticalSpace,
            Center(
              child: Column(
                children: [
                  Icon(
                    Icons.folder_open,
                    size: 48.r,
                    color: context.greyColor.withValues(alpha: 0.5),
                  ),
                  8.verticalSpace,
                  Text(
                    AppStrings.noMaterialsAvailable,
                    style: context.textTheme.bodyMedium!.copyWith(
                      color: context.greyColor.withValues(alpha: 0.7),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.materials,
          style: context.textTheme.titleMedium!.withColor(context.primaryColor),
        ),
        16.verticalSpace,
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: widget.subject.materialUrls.length,
          separatorBuilder: (context, index) => 8.verticalSpace,
          itemBuilder: (context, index) {
            final material = widget.subject.materialUrls[index];
            return _buildMaterialItem(context, material);
          },
        ),
      ],
    );
  }

  Widget _buildMaterialItem(BuildContext context, MaterialsUrl material) {
    return Container(
      padding: REdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.cardColor,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: context.primaryColor.withValues(alpha: 0.1),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          _buildMaterialIcon(context, material.type),
          16.horizontalSpace,
          Expanded(
            child: Text(
              material.url.split('/').last,
              style: context.textTheme.bodyMedium!
                  .withColor(context.onBackgroundColor),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          16.horizontalSpace,
          Icon(
            Icons.download_rounded,
            color: context.primaryColor,
            size: 24.r,
          ),
        ],
      ),
    );
  }

  Widget _buildMaterialIcon(BuildContext context, MaterialsUrlType type) {
    IconData iconData;
    Color iconColor;

    switch (type) {
      case MaterialsUrlType.pdf:
        iconData = Icons.picture_as_pdf_rounded;
        iconColor = Colors.red;
        break;
      case MaterialsUrlType.video:
        iconData = Icons.video_library_rounded;
        iconColor = Colors.blue;
        break;
      case MaterialsUrlType.image:
        iconData = Icons.image_rounded;
        iconColor = Colors.green;
        break;
      case MaterialsUrlType.audio:
        iconData = Icons.audio_file_rounded;
        iconColor = Colors.orange;
        break;
      case MaterialsUrlType.document:
        iconData = Icons.description_rounded;
        iconColor = Colors.blue;
        break;
      case MaterialsUrlType.excel:
        iconData = Icons.table_chart_rounded;
        iconColor = Colors.green;
        break;
      case MaterialsUrlType.word:
        iconData = Icons.article_rounded;
        iconColor = Colors.blue;
        break;
      case MaterialsUrlType.powerpoint:
        iconData = Icons.slideshow_rounded;
        iconColor = Colors.orange;
        break;
      case MaterialsUrlType.zip:
      case MaterialsUrlType.rar:
        iconData = Icons.folder_zip_rounded;
        iconColor = Colors.purple;
        break;
      case MaterialsUrlType.link:
        iconData = Icons.link_rounded;
        iconColor = Colors.blue;
        break;
      case MaterialsUrlType.other:
        iconData = Icons.insert_drive_file_rounded;
        iconColor = Colors.grey;
        break;
    }

    return Container(
      padding: REdgeInsets.all(8),
      decoration: BoxDecoration(
        color: iconColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Icon(
        iconData,
        color: iconColor,
        size: 24.r,
      ),
    );
  }

  Widget _buildUploadSection(BuildContext context) {
    return BlocBuilder<GetSubjectsBloc, SubjectState>(
      buildWhen: (previous, current) =>
          previous.operationResult != current.operationResult,
      builder: (context, state) {
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
                style: context.textTheme.titleMedium!
                    .withColor(context.primaryColor),
              ),
              16.verticalSpace,
              _buildUploadOptions(context),
              16.verticalSpace,
              _buildUploadButton(context, state),
            ],
          ),
        );
      },
    );
  }

  Widget _buildUploadOptions(BuildContext context) {
    return Column(
      children: [
        // File upload option
        GestureDetector(
          onTap: _pickFile,
          child: Container(
            padding: REdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(
                color: _selectedFile != null
                    ? context.primaryColor
                    : context.greyColor.withValues(alpha: 0.3),
              ),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.upload_file,
                  color: _selectedFile != null
                      ? context.primaryColor
                      : context.greyColor,
                ),
                12.horizontalSpace,
                Expanded(
                  child: Text(
                    _selectedFile != null
                        ? _selectedFile!.path.split('/').last
                        : AppStrings.selectFile,
                    style: context.textTheme.bodyMedium!.copyWith(
                      color: _selectedFile != null
                          ? context.primaryColor
                          : context.greyColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        12.verticalSpace,
        Text(
          AppStrings.or,
          style: context.textTheme.bodyMedium!.copyWith(
            color: context.greyColor,
          ),
          textAlign: TextAlign.center,
        ),
        12.verticalSpace,
        // URL input option
        CustomReactiveField(
          controller: 'material_url',
          hintText: AppStrings.enterMaterialUrl,
          onChanged: (control) {
            _urlController.text = control.value ?? '';
          },
        ),
      ],
    );
  }

  Widget _buildUploadButton(BuildContext context, SubjectState state) {
    final isLoading = state.operationResult.isLoading();
    final hasFile = _selectedFile != null;
    final hasUrl = _urlController.text.trim().isNotEmpty;
    final canUpload = (hasFile || hasUrl) && !(hasFile && hasUrl);

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: canUpload && !isLoading ? _uploadMaterial : null,
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
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ),
                  8.horizontalSpace,
                  Text(AppStrings.uploading),
                ],
              )
            : Text(AppStrings.uploadMaterial),
      ),
    );
  }

  Future<void> _pickFile() async {
    // For now, we'll just show a placeholder since file_picker is not available
    // In a real implementation, you would use file_picker or image_picker
    debugPrint('File picker functionality not implemented yet');
    // TODO: Implement file picking when file_picker package is added
  }

  void _uploadMaterial() {
    if (_selectedFile == null && _urlController.text.trim().isEmpty) {
      return;
    }

    if (_selectedFile != null && _urlController.text.trim().isNotEmpty) {
      return;
    }

    final bloc = getIt<GetSubjectsBloc>();
    bloc.add(
      UploadMaterialEvent(
        id: widget.subject.id,
        file: _selectedFile,
        url: _urlController.text.trim().isNotEmpty
            ? _urlController.text.trim()
            : null,
      ),
    );

    // Reset form
    setState(() {
      _selectedFile = null;
      _urlController.clear();
    });

    // Call callback to refresh data
    widget.onMaterialUploaded();
  }
}
