import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class LocalizationService {
  final BuildContext context;

  LocalizationService(this.context);

  String tr(String key) {
    return context.tr(key);
  }
}

