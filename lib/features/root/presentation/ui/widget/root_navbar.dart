// 📦 Package imports:

// 📦 Package imports:

// 🌎 Project imports:
import 'package:provider/provider.dart';

import '../../../../../shared/imports/imports.dart';
import '../../state/provider/nav_bar_provider.dart';

class RootNavbar extends StatelessWidget {
  const RootNavbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<NavBarProvider>(
      builder: (context, pro, _) => const SizedBox(),
    );
  }

  Widget _buildNavBarItem({
    required String icon,
    required String label,
    required bool isSelected,
    required BuildContext context,
  }) {
    return const SizedBox();
  }
}
