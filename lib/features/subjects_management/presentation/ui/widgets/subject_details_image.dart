import 'package:beamer/beamer.dart';
import 'package:uni_sphere_admin/shared/imports/imports.dart';
import 'package:uni_sphere_admin/shared/widgets/custom_network_image.dart';

class SubjectDetailsImage extends StatelessWidget {
  const SubjectDetailsImage({
    super.key,
    required this.imageUrl,
    required this.title,
  });

  final String imageUrl;
  final String title;

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
            IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 24.r,
              ),
              onPressed: () {
                context.beamBack();
              },
            ),
          ],
        ),
      ),
      expandedHeight: context.screenHeight * 0.35,
      pinned: true,
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: Container(
          height: 22.h,
          decoration: BoxDecoration(
            color: context.backgroundColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(22.r),
              topRight: Radius.circular(22.r),
            ),
          ),
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            CustomNetworkImage(
              imageUrl: imageUrl,
              fit: BoxFit.cover,
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.5),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: REdgeInsets.only(left: 24, bottom: 40, right: 24),
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: context.primaryColor,
    );
  }
}
