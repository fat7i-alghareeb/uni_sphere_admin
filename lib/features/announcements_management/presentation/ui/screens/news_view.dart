import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../common/constant/app_strings.dart';
import '../../../../../core/constants/app_constants.dart';
import '../../../../../core/injection/injection.dart';
import '../../../../../shared/entities/role.dart';
import '../../../../../shared/imports/imports.dart';
import '../../state/bloc/announcements_management_bloc.dart';
import '../widgets/announcement_list_widget.dart';

class NewsView extends StatelessWidget {
  const NewsView({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint('🔍 NewsView: Building for role: ${AppConstants.userRole}');
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: getIt<AnnouncementsManagementBloc>()),
      ],
      child: BlocListener<AnnouncementsManagementBloc,
          AnnouncementsManagementState>(
        listener: (context, state) {
          debugPrint('🔍 NewsView: State changed');
          debugPrint(
              '🔍 NewsView: Admin result: ${state.adminAnnouncementsResult}');
          debugPrint(
              '🔍 NewsView: SuperAdmin result: ${state.superAdminAnnouncementsResult}');
        },
        child: const AnnouncementListWidget(),
      ),
    );
  }
}
