import 'package:beamer/beamer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../shared/imports/imports.dart';
import '../../../../../shared/widgets/custom_icon.dart';
import '../../../../../shared/widgets/custom_network_image.dart';
import 'announcement_details_image_gallery.dart';

class AnnouncementDetailsImage extends StatelessWidget {
  const AnnouncementDetailsImage({
    super.key,
    required this.id,
    required this.imageUrl,
    required this.images,
    required this.selectedImageUrl,
    required this.onImageSelected,
  });
  final String id;
  final String imageUrl;
  final List<String> images;
  final String? selectedImageUrl;
  final void Function(String) onImageSelected;

  static const double _galleryHeight = 100;
  static const double _galleryBottomPadding = 0;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      leadingWidth: AppConstants.horizontalScreensPadding + 60.r,
      collapsedHeight: 70.r,
      leading: SizedBox(
        child: Row(
          children: [
            AppConstants.horizontalScreensPadding.horizontalSpace,
            CustomIcon(
              iconPath: !context.isEnglish
                  ? FontAwesomeIcons.chevronRight
                  : FontAwesomeIcons.chevronLeft,
              onTap: () {
                context.beamBack();
              },
            ),
          ],
        ),
      ),
      expandedHeight: context.screenHeight * 0.35 + _galleryHeight.h,
      pinned: true,
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(
            _galleryHeight.h - 10 + _galleryBottomPadding.h - 10),
        child: Container(
          height: _galleryHeight.h + _galleryBottomPadding.h,
          decoration: BoxDecoration(
            color: context.backgroundColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(22.r),
              topRight: Radius.circular(22.r),
            ),
          ),
          child: AnnouncementDetailsImageGallery(
            images: images,
            selectedImageUrl: selectedImageUrl,
            onImageSelected: onImageSelected,
          ),
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: CustomNetworkImage(
          imageUrl: imageUrl,
          fit: BoxFit.cover,
        ),
      ),
      backgroundColor: context.primaryColor,
    );
  }
}
