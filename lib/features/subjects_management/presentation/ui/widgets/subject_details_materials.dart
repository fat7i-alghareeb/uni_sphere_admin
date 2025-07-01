import 'package:uni_sphere_admin/common/constant/app_strings.dart';
import 'package:uni_sphere_admin/features/subjects_management/data/models/subjects_management_model.dart';
import 'package:uni_sphere_admin/features/subjects_management/presentation/ui/widgets/material_upload_card.dart';
import 'package:uni_sphere_admin/shared/entities/role.dart';
import 'package:uni_sphere_admin/shared/imports/imports.dart';
import 'package:uni_sphere_admin/features/subjects_management/services/materials_service.dart';
import 'package:uni_sphere_admin/shared/widgets/custom_network_image.dart';
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
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: REdgeInsets.symmetric(
        horizontal: AppConstants.horizontalScreensPadding,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SubjectDescriptionCard(subject: widget.subject),
          18.verticalSpace,
          MaterialsListCard(subject: widget.subject),
          if (AppConstants.userRole == Role.professor) ...[
            18.verticalSpace,
            MaterialUploadCard(
              subjectId: widget.subject.id,
              onMaterialUploaded: widget.onMaterialUploaded,
            ),
          ],
        ],
      ),
    );
  }
}

/// Widget for displaying subject description
class SubjectDescriptionCard extends StatelessWidget {
  const SubjectDescriptionCard({
    super.key,
    required this.subject,
  });

  final Subject subject;

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
            AppStrings.subjectDescription,
            style:
                context.textTheme.titleMedium!.withColor(context.primaryColor),
          ),
          16.verticalSpace,
          Text(
            subject.description,
            style: context.textTheme.bodyMedium!
                .withColor(context.onBackgroundColor),
          ),
        ],
      ),
    );
  }
}

/// Widget for displaying materials list
class MaterialsListCard extends StatelessWidget {
  const MaterialsListCard({
    super.key,
    required this.subject,
  });

  final Subject subject;

  @override
  Widget build(BuildContext context) {
    if (subject.materialUrls.isEmpty) {
      return EmptyMaterialsCard();
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
          itemCount: subject.materialUrls.length,
          separatorBuilder: (context, index) => 8.verticalSpace,
          itemBuilder: (context, index) {
            final material = subject.materialUrls[index];
            return MaterialItemCard(material: material);
          },
        ),
      ],
    );
  }
}

/// Widget for empty materials state
class EmptyMaterialsCard extends StatelessWidget {
  const EmptyMaterialsCard({super.key});

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
            AppStrings.materials,
            style:
                context.textTheme.titleMedium!.withColor(context.primaryColor),
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
}

/// Widget for individual material item
class MaterialItemCard extends StatelessWidget {
  const MaterialItemCard({
    super.key,
    required this.material,
  });

  final MaterialsUrl material;

  @override
  Widget build(BuildContext context) {
    final materialsService = MaterialsService();
    return FutureBuilder<bool>(
      future: materialsService.isFileActuallyDownloaded(material.url),
      builder: (context, snapshot) {
        final isDownloaded = snapshot.data ?? false;
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
              MaterialTypeIcon(type: material.type),
              16.horizontalSpace,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      MaterialsService().getCommonFileName(material.url),
                      style: context.textTheme.bodyMedium!
                          .withColor(context.onBackgroundColor),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (material.type == MaterialsUrlType.link)
                      Text(
                        material.url,
                        style: context.textTheme.bodySmall!.copyWith(
                          color: context.greyColor,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    if (material.type == MaterialsUrlType.image) ...[
                      8.verticalSpace,
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.r),
                        child: CustomNetworkImage(
                          imageUrl: material.url,
                          width: 80,
                          height: 60,
                          fit: BoxFit.cover,
                          borderRadius: 8,
                        ),
                      ),
                    ],
                    if (isDownloaded) ...[
                      4.verticalSpace,
                      Row(
                        children: [
                          Icon(
                            Icons.check_circle,
                            size: 16.r,
                            color: Colors.blue,
                          ),
                          4.horizontalSpace,
                          Text(
                            AppStrings.availableOffline,
                            style: context.textTheme.bodySmall!.copyWith(
                              color: Colors.blue,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
              16.horizontalSpace,
              MaterialActionButton(
                  material: material, isDownloadedOverride: isDownloaded),
            ],
          ),
        );
      },
    );
  }
}

/// Widget for material type icon
class MaterialTypeIcon extends StatelessWidget {
  const MaterialTypeIcon({
    super.key,
    required this.type,
  });

  final MaterialsUrlType type;

  @override
  Widget build(BuildContext context) {
    final materialsService = MaterialsService();
    final iconData = materialsService.getMaterialIcon(type);
    final iconColor = materialsService.getMaterialIconColor(type);

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
}

/// Widget for material action button
class MaterialActionButton extends StatefulWidget {
  const MaterialActionButton({
    super.key,
    required this.material,
    this.isDownloadedOverride,
  });

  final MaterialsUrl material;
  final bool? isDownloadedOverride;

  @override
  State<MaterialActionButton> createState() => _MaterialActionButtonState();
}

class _MaterialActionButtonState extends State<MaterialActionButton> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final materialsService = MaterialsService();
    return FutureBuilder<bool>(
      future: widget.isDownloadedOverride != null
          ? Future.value(widget.isDownloadedOverride)
          : materialsService.isFileActuallyDownloaded(widget.material.url),
      builder: (context, snapshot) {
        final isDownloaded = snapshot.data ?? false;
        return GestureDetector(
          onTap: _isLoading
              ? null
              : () async {
                  setState(() {
                    _isLoading = true;
                  });

                  try {
                    await materialsService.handleMaterialAction(
                        context, widget.material);
                  } catch (e) {
                    String errorMessage = _getErrorMessage(e.toString());

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(errorMessage),
                        backgroundColor: Colors.red,
                        duration: const Duration(seconds: 5),
                      ),
                    );
                  } finally {
                    if (mounted) {
                      setState(() {
                        _isLoading = false;
                      });
                    }
                  }
                },
          child: Container(
            padding: REdgeInsets.all(8),
            decoration: BoxDecoration(
              color: isDownloaded
                  ? Colors.blue.withValues(alpha: 0.1)
                  : context.primaryColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: _isLoading
                ? SizedBox(
                    width: 20.r,
                    height: 20.r,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: context.primaryColor,
                    ),
                  )
                : Icon(
                    isDownloaded
                        ? materialsService.getViewIcon()
                        : materialsService.getActionIcon(widget.material.type),
                    color: isDownloaded ? Colors.blue : context.primaryColor,
                    size: 20.r,
                  ),
          ),
        );
      },
    );
  }

  String _getErrorMessage(String error) {
    if (error.contains('UnimplementedError') ||
        error.contains('Download not supported')) {
      return AppStrings.downloadNotSupported;
    } else if (error.contains('SSL certificate error')) {
      return AppStrings.sslCertificateError;
    } else if (error.contains('CERTIFICATE_VERIFY_FAILED')) {
      return AppStrings.certificateVerificationFailed;
    } else if (error.contains('HandshakeException')) {
      return AppStrings.connectionError;
    } else if (error.contains('Could not open link')) {
      return AppStrings.failedToOpenLink;
    } else if (error.contains('Could not access storage directory')) {
      return AppStrings.storageAccessDenied;
    } else if (error.contains('Network connection error')) {
      return AppStrings.networkConnectionError;
    } else {
      return AppStrings.anErrorOccurred;
    }
  }
}
