import '../../../../../common/constant/app_strings.dart';
import '../../../../../shared/imports/imports.dart';

class NoSchedulesWidget extends StatelessWidget {
  final bool isError;
  final String? errorMessage;
  final VoidCallback? onRetry;

  const NoSchedulesWidget({
    super.key,
    this.isError = false,
    this.errorMessage,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: REdgeInsets.symmetric(
          horizontal: AppConstants.horizontalScreensPadding),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.calendar_month_outlined,
              size: 80.r,
              color: theme.primaryColor.withValues(alpha: 0.5),
            ),
            16.verticalSpace,
            Text(
              _getMessage(),
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            if (onRetry != null) ...[
              24.verticalSpace,
              ElevatedButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh),
                label: Text(AppStrings.tryAgain),
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.primaryColor,
                  foregroundColor: Colors.white,
                  padding: REdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  String _getMessage() {
    if (isError) {
      return errorMessage ?? AppStrings.pleaseTryAgainLater;
    }
    return AppStrings.noSchedulesForThisMonth;
  }
}
