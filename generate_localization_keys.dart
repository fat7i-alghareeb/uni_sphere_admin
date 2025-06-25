// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';

void main() {
  const jsonFilePath = 'assets/l10n/ar.json'; // Change if needed
  const serviceFilePath = 'lib/shared/helper/localization_service.dart';
  const keysFilePath = 'lib/common/constant/app_strings.dart';

  final jsonFile = File(jsonFilePath);
  if (!jsonFile.existsSync()) {
    print('Error: JSON file not found.');
    return;
  }

  final jsonString = jsonFile.readAsStringSync();
  final Map<String, dynamic> jsonMap = jsonDecode(jsonString);

  // Ensure the directories exist
  Directory(
    serviceFilePath.substring(0, serviceFilePath.lastIndexOf('/')),
  ).createSync(recursive: true);
  Directory(
    keysFilePath.substring(0, keysFilePath.lastIndexOf('/')),
  ).createSync(recursive: true);

  // Generate LocalizationService
  final serviceBuffer = StringBuffer();
  serviceBuffer.writeln('''
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class LocalizationService {
  final BuildContext context;

  LocalizationService(this.context);

  String tr(String key) {
    return context.tr(key);
  }
}
''');

  File(serviceFilePath).writeAsStringSync(serviceBuffer.toString());
  print('✅ LocalizationService generated successfully.');

  // Generate LocalizationKeys
  final keysBuffer = StringBuffer();
  keysBuffer.writeln('''
import 'package:get_it/get_it.dart';
import '../../shared/helper/localization_service.dart';
// dart run generate_localization_keys.dart  
// AUTO-GENERATED FILE, DO NOT EDIT
class AppStrings {
  static final _localization = GetIt.instance<LocalizationService>();
''');

  void generateKeys(Map<String, dynamic> map, [String prefix = '']) {
    for (var key in map.keys) {
      final newKey = key.contains('_') ? _toCamelCase(key) : key;
      final fullKey = prefix.isNotEmpty ? '$prefix.$key' : key;

      if (map[key] is Map) {
        generateKeys(map[key], fullKey);
      } else {
        keysBuffer.writeln(
          "  static String get $newKey => _localization.tr('$fullKey');",
        );
      }
    }
  }

  generateKeys(jsonMap);

  keysBuffer.writeln('}');

  File(keysFilePath).writeAsStringSync(keysBuffer.toString());
  print('✅ LocalizationKeys generated successfully.');
}

// Function to convert snake_case to camelCase
String _toCamelCase(String text) {
  return text
      .split('_')
      .mapIndexed((index, word) {
        if (index == 0) return word.toLowerCase();
        return word[0].toUpperCase() + word.substring(1).toLowerCase();
      })
      .join('');
}

// Helper function to iterate over a list with an index
extension IterableExtensions<E> on Iterable<E> {
  Iterable<T> mapIndexed<T>(T Function(int index, E element) f) sync* {
    int index = 0;
    for (var element in this) {
      yield f(index++, element);
    }
  }
}
