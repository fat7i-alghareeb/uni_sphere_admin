import '../../../../../shared/imports/imports.dart';
import '../../../../../shared/widgets/custom_network_image.dart';

class AnnouncementDetailsImageGallery extends StatelessWidget {
  const AnnouncementDetailsImageGallery({
    super.key,
    required this.images,
    required this.onImageSelected,
    required this.selectedImageUrl,
  });

  final List<String> images;
  final void Function(String) onImageSelected;
  final String? selectedImageUrl;

  static const double _spacing = 12;
  static const double _selectedBorderWidth = 2;

  @override
  Widget build(BuildContext context) {
    if (images.length <= 1) return const SizedBox.shrink();

    return ListView.separated(
      scrollDirection: Axis.horizontal,
      padding: REdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      itemCount: images.length,
      separatorBuilder: (context, index) => _spacing.horizontalSpace,
      itemBuilder: (context, index) {
        final isSelected = images[index] == selectedImageUrl;
        return GestureDetector(
          onTap: () => onImageSelected(images[index]),
          child: AspectRatio(
            aspectRatio: 1,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(
                  color: isSelected ? context.primaryColor : Colors.transparent,
                  width: _selectedBorderWidth,
                ),
                boxShadow: [
                  BoxShadow(
                    color: context.primaryColor.withValues(alpha: 0.1),
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius:
                    BorderRadius.circular((8 - _selectedBorderWidth).r),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    CustomNetworkImage(
                      imageUrl: images[index],
                      fit: BoxFit.cover,
                    ),
                    if (isSelected)
                      Container(
                        decoration: BoxDecoration(
                          color: context.primaryColor.withValues(alpha: 0.2),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
