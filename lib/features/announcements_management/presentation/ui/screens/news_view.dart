import 'package:uni_sphere_admin/shared/imports/imports.dart';

class NewsView extends StatelessWidget {
  const NewsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.announcement,
            size: 100.r,
            color: context.primaryColor,
          ),
          20.verticalSpace,
          Text(
            'News View',
            style: context.textTheme.headlineMedium?.copyWith(
              color: context.primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
