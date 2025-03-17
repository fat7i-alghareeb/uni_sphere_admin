// 📦 Package imports:
import 'package:cached_network_image/cached_network_image.dart';

// 🌎 Project imports:
import '../imports/imports.dart';

class CustomNetworkImage extends StatelessWidget {
  final String imageUrl;
  final BoxFit fit;
  final double? width;
  const CustomNetworkImage({
    super.key,
    required this.imageUrl,
    this.fit = BoxFit.cover,
    this.width,
  });
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      width: width,
      filterQuality: FilterQuality.high,
      placeholder: (context, url) => Padding(
        padding: REdgeInsets.all(8.0),
        child: const Center(
          child: CircularProgressIndicator(
            color: Colors.green,
          ),
        ),
      ),
      errorWidget: (context, url, error) => const FlutterLogo(),
      fit: fit,
    );
  }
}
