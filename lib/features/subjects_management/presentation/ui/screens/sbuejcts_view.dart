import 'package:uni_sphere_admin/shared/imports/imports.dart';

class SubjectsView extends StatelessWidget {
  const SubjectsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.book,
            size: 100.r,
            color: context.primaryColor,
          ),
          20.verticalSpace,
          Text(
            'Subjects View',
            style: context.textTheme.headlineMedium?.copyWith(
              color: context.primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
