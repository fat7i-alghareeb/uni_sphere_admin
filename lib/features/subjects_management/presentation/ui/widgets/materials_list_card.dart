import 'package:uni_sphere_admin/common/constant/app_strings.dart';
import 'package:uni_sphere_admin/features/subjects_management/data/models/subjects_management_model.dart';
import 'package:uni_sphere_admin/shared/imports/imports.dart';
import 'empty_materials_card.dart';
import 'material_item_card.dart';

class MaterialsListCard extends StatelessWidget {
  const MaterialsListCard({
    super.key,
    required this.subject,
  });

  final Subject subject;

  @override
  Widget build(BuildContext context) {
    if (subject.materialUrls.isEmpty) {
      return const EmptyMaterialsCard();
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
