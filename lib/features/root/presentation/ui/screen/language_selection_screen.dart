import 'package:beamer/beamer.dart' show BeamPage, BeamPageType;
import 'package:easy_localization/easy_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../../../common/constant/app_strings.dart' show AppStrings;
import '../../../../../../../core/constants/key_constants.dart';
import '../../../../../../../core/injection/injection.dart';
import '../../../../../../../router/router_config.dart';
import '../../../../../../../shared/imports/imports.dart';

class LanguageSelectionScreen extends StatelessWidget {
  static const supportedLanguages = [
    {'locale': Locale('en'), 'name': 'English', 'flag': '🇺🇸'},
    {'locale': Locale('ar'), 'name': 'العربية', 'flag': '🇸🇦'},
    // Add more languages here if needed
  ];

  const LanguageSelectionScreen({super.key});
  static const String pagePath = 'language_selection';

  static BeamerBuilder pageBuilder = (context, state, data) {
    return BeamPage(
      key: ValueKey(pagePath),
      child: const LanguageSelectionScreen(),
      type: BeamPageType.fadeTransition,
    );
  };
  @override
  Widget build(BuildContext context) {
    final currentLocale = context.locale;

    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.selectLanguage,
            style: context.textTheme.titleLarge),
        centerTitle: true,
        backgroundColor: context.backgroundColor,
        elevation: 0,
        iconTheme: IconThemeData(color: context.primaryColor),
      ),
      body: ListView.separated(
        padding: REdgeInsets.all(24),
        itemCount: supportedLanguages.length,
        separatorBuilder: (_, __) => 16.verticalSpace,
        itemBuilder: (context, index) {
          final lang = supportedLanguages[index];
          final isSelected = lang['locale'] == currentLocale;

          return AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
            decoration: BoxDecoration(
              color: isSelected
                  ? context.primaryColor.withValues(alpha: .08)
                  : context.cardColor,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(
                color: isSelected ? context.primaryColor : Colors.transparent,
                width: 2,
              ),
              boxShadow: [
                if (isSelected)
                  BoxShadow(
                    color: context.primaryColor.withValues(alpha: .08),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
              ],
            ),
            child: ListTile(
              leading: Text(lang['flag'] as String,
                  style: const TextStyle(fontSize: 28)),
              title: Text(
                lang['name'] as String,
                style: context.textTheme.titleMedium?.copyWith(
                  color: isSelected ? context.primaryColor : context.textColor,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
              trailing: AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                child: isSelected
                    ? Icon(Icons.check_circle_rounded,
                        color: context.primaryColor, key: ValueKey('selected'))
                    : SizedBox(width: 24, key: ValueKey('unselected')),
              ),
              onTap: () async {
                if (!isSelected) {
                  final locale = lang['locale'] as Locale;
                  await context.setLocale(locale);
                  // Also save to SharedPreferences for API calls
                  await getIt<SharedPreferences>()
                      .setString(kLanguage, locale.languageCode);
                }
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.r)),
              contentPadding:
                  REdgeInsets.symmetric(horizontal: 20, vertical: 8),
            ),
          );
        },
      ),
    );
  }
}
