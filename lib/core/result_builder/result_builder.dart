// ignore_for_file: must_be_immutable

// 🐦 Flutter imports:
import 'package:flutter/material.dart';

import '../../shared/utils/helper/show_error_overlay.dart';
import '../../shared/widgets/failed_widget.dart';
// 🌎 Project imports:
import '../../shared/widgets/loading_progress.dart';
import 'result.dart';

class ResultBuilder<T> extends StatelessWidget {
  const ResultBuilder({
    super.key,
    required this.success,
    this.loading,
    this.init,
    this.onError,
    required this.result,
    this.errorMessage,
    this.showLoadingProgress = true,
    this.showInitWidget = true,
  });

  final Result<T> result;
  final Widget Function()? loading;
  final Widget Function()? init;
  final Widget Function(T data) success;
  final Function()? onError;
  final String? errorMessage;
  final bool showLoadingProgress;
  final bool showInitWidget;

  @override
  Widget build(BuildContext context) {
    late final Widget next;

    defaultLoading() => showLoadingProgress
        ? const Center(child: LoadingProgress())
        : const SizedBox.shrink();

    defaultInit() => const SizedBox.shrink();

    result.when(
      init: () => next = init?.call() ?? defaultInit(),
      loading: () => next = loading?.call() ?? defaultLoading(),
      loaded: (data) => next = success(data),
      error: (message) {
        if (onError != null) {
          return next = FailedWidget(
            error: errorMessage ?? message,
            onPressed: onError!,
          );
        } else {
          showErrorOverlay(context, errorMessage ?? message);
          return next = const SizedBox.shrink();
        }
      },
    );

    return next;
  }
}
