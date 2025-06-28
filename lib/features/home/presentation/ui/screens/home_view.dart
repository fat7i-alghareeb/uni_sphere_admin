import 'package:uni_sphere_admin/shared/imports/imports.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.home,
            size: 100.r,
            color: context.primaryColor,
          ),
          20.verticalSpace,
          Text(
            'Home View',
            style: context.textTheme.headlineMedium?.copyWith(
              color: context.primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
