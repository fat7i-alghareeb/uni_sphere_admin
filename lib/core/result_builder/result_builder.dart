// ignore_for_file: must_be_immutable

// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:


import '../../shared/widgets/failed_widget.dart';
import '../../shared/widgets/loading_progress.dart';
import 'result.dart';

class ResultBuilder<T> extends StatelessWidget {
  ResultBuilder({
    super.key,
    required this.success,
    this.loading,
    this.init,
    required this.onError,
    required this.result,
    this.showFailedWidget = false,
  });

  final Result<T> result;
  Widget Function()? loading;
  Widget Function()? init;
  final Widget Function(T data) success;
  final Function() onError;
  final bool showFailedWidget;
  @override
  Widget build(BuildContext context) {
    late final Widget next;

    loading ??= () => const Center(child: LoadingProgress());
    init ??= () => const SizedBox();

    result.when(
        init: () => next = init!(),
        loading: () => next = loading!(),
        loaded: (data) => next = success(data),
        error: (message) {
          if (showFailedWidget) {
            return next = FailedWidget(
              error: message,
              onPressed: onError,
            );
          }
          return next = const SizedBox.shrink();
        });
    return next;
  }
}
