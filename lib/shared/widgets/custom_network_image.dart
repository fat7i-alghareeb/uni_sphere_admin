// 📦 Package imports:
import 'package:cached_network_image/cached_network_image.dart';

// 🌎 Project imports:
import '../../core/constants/app_url.dart';
import '../imports/imports.dart';

class CustomNetworkImage extends StatefulWidget {
  const CustomNetworkImage({
    super.key,
    required this.imageUrl,
    this.fit = BoxFit.fill,
    this.width,
    this.height,
    this.borderRadius,
    this.filterQuality = FilterQuality.high,
    this.cacheKey,
    this.useOldImageOnUrlChange = false,
  });

  final String? imageUrl;
  final BoxFit fit;
  final double? width;
  final double? height;
  final double? borderRadius;
  final FilterQuality filterQuality;
  final String? cacheKey;
  final bool useOldImageOnUrlChange;

  @override
  State<CustomNetworkImage> createState() => _CustomNetworkImageState();
}

class _CustomNetworkImageState extends State<CustomNetworkImage> {
  String get fullUrl {
    if (widget.imageUrl == null || widget.imageUrl!.isEmpty) return '';
    return widget.imageUrl!.startsWith("http")
        ? widget.imageUrl!
        : AppUrl.baseUrlDevelopment + widget.imageUrl!;
  }

  @override
  Widget build(BuildContext context) {
    final errorImage = ClipRRect(
      borderRadius: BorderRadius.circular(widget.borderRadius ?? 0),
      child: Image.asset(
        Assets.images.test.keyName,
        fit: BoxFit.fill,
      ),
    );

    if (widget.imageUrl == null || widget.imageUrl!.isEmpty) {
      return errorImage;
    }

    final image = SizedBox(
      width: widget.width?.w,
      height: widget.height?.h,
      child: CachedNetworkImage(
        imageUrl: fullUrl,
        memCacheWidth: widget.filterQuality == FilterQuality.low ? 500 : null,
        memCacheHeight: widget.filterQuality == FilterQuality.low ? 500 : null,
        maxHeightDiskCache:
            widget.filterQuality == FilterQuality.low ? 500 : null,
        maxWidthDiskCache:
            widget.filterQuality == FilterQuality.low ? 500 : null,
        filterQuality: widget.filterQuality,
        placeholder: (context, url) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: CircularProgressIndicator(
              color: context.primaryColor,
              strokeWidth: (widget.width != null &&
                      widget.width!.isFinite &&
                      widget.width! > 0)
                  ? (widget.width! * 0.05)
                  : 4,
            ),
          ),
        ),
        errorWidget: (context, url, error) {
          debugPrint('Image load error: $error for URL: $url');
          return errorImage;
        },
        fit: widget.fit,
        imageBuilder: (context, imageProvider) {
          return Image(
            image: imageProvider,
            fit: widget.fit,
            filterQuality: widget.filterQuality,
            width: widget.width,
            height: widget.height,
            errorBuilder: (context, error, stackTrace) {
              debugPrint('Image rendering error: $error');
              return errorImage;
            },
          );
        },
      ),
    );

    if (widget.borderRadius == null) {
      return image;
    } else {
      return ClipRRect(
        borderRadius: BorderRadius.circular(widget.borderRadius!.r),
        child: image,
      );
    }
  }
}
