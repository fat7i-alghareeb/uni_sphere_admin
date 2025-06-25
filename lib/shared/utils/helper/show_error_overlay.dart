import '../../imports/imports.dart';
import 'colored_print.dart';

void showErrorOverlay(BuildContext context, String error) {
  printW("error: $error");
  OverlayEntry? overlayEntry;

  overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      top: MediaQuery.of(context).padding.top + 20,
      left: 0,
      right: 0,
      child: Material(
        color: Colors.transparent,
        child: Padding(
          padding: REdgeInsets.symmetric(horizontal: 16),
          child: Container(
            padding: REdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(8.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                const Icon(Icons.error_outline, color: Colors.white),
                8.horizontalSpace,
                Expanded(
                  child: Text(
                    error,
                    style: context.textTheme.labelLarge?.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.white),
                  onPressed: () {
                    overlayEntry?.remove();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );

  // Schedule the overlay insertion after the current build phase is complete
  WidgetsBinding.instance.addPostFrameCallback((_) {
    // Insert the overlay
    if (overlayEntry != null) {
      Overlay.of(context).insert(overlayEntry);

      // Remove the overlay after 3 seconds
      Future.delayed(const Duration(seconds: 3), () {
        overlayEntry?.remove();
      });
    }
  });
}
