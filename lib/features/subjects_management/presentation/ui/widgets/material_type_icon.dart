import 'package:uni_sphere_admin/features/subjects_management/data/models/subjects_management_model.dart';
import 'package:uni_sphere_admin/features/subjects_management/services/materials_service.dart';
import 'package:uni_sphere_admin/shared/imports/imports.dart';

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
