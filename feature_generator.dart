// ignore_for_file: avoid_print

import 'dart:io';

void main(List<String> arguments) {
  if (arguments.isEmpty) {
    print('Usage: dart feature_generator.dart <feature_name>');
    return;
  }

  final featureName = arguments[0].toLowerCase();
  final featureDirectory = Directory('lib/features/$featureName');
  final injectionDirectory = Directory('lib/core/injection/src');

  if (featureDirectory.existsSync()) {
    print('Feature "$featureName" already exists!');
    return;
  }

  // Define the template structure
  final template = {
    // Feature files
    'data/datasources/${featureName}_remote_data_source.dart': '''
//!----------------------------  Imports  -------------------------------------!//
import 'package:dio/dio.dart';
import '../models/${featureName}_model.dart';
import '../../../../shared/services/exception/error_handler.dart';

//!----------------------------  The Class  -------------------------------------!//

class ${featureName.pascalCase}Remote {
  final Dio _dio;

  const ${featureName.pascalCase}Remote(Dio dio) : _dio = dio;

  //* Get All ${featureName.pascalCase}
  Future<${featureName.pascalCase}Model> getAll${featureName.pascalCase}() {
    return throwDioException(
      () async {
        final response = await _dio.get(
          "random/url",
        );
        return response.data;
      },
    );
  }
}
''',
    'data/models/${featureName}_model.dart': '''
class ${featureName.pascalCase}Model {}
''',
    'data/repositories/${featureName}_repository_impl.dart': '''
//!----------------------------  Imports  -------------------------------------!//
import 'package:fpdart/fpdart.dart';
import '../../domain/entities/${featureName}_entity.dart';
import '../datasources/${featureName}_remote_data_source.dart';
import '../../domain/repositories/${featureName}_repository.dart';
import '../../../../shared/services/exception/error_handler.dart';

//!----------------------------  The Class  -------------------------------------!//

class ${featureName.pascalCase}RepoImp implements ${featureName.pascalCase}Repo {
  final ${featureName.pascalCase}Remote _remote;

  ${featureName.pascalCase}RepoImp({
    required ${featureName.pascalCase}Remote remote,
  }) : _remote = remote;

  @override
  Future<Either<String, ${featureName.pascalCase}Entity>> getAll${featureName.pascalCase}() {
    return throwAppException(
      () async {
        return await _remote.getAll${featureName.pascalCase}();
      },
    );
  }
}
''',
    'domain/entities/${featureName}_entity.dart': '''
class ${featureName.pascalCase}Entity {}
''',
    'domain/repositories/${featureName}_repository.dart': '''
//!----------------------------  Imports  -------------------------------------!//
import 'package:fpdart/fpdart.dart';
import '../entities/${featureName}_entity.dart';

//!----------------------------  The Class  -------------------------------------!//

abstract class ${featureName.pascalCase}Repo {
  ${featureName.pascalCase}Repo();

  //* Get All ${featureName.pascalCase}
  Future<Either<String, ${featureName.pascalCase}Entity>> getAll${featureName.pascalCase}();
}
''',
    'domain/usecases/${featureName}_usecase.dart': '''
//!----------------------------  Imports  -------------------------------------!//
import 'package:fpdart/fpdart.dart';
import '../entities/${featureName}_entity.dart';
import '../repositories/${featureName}_repository.dart';

//!----------------------------  The Class  -------------------------------------!//

class ${featureName.pascalCase}Usecase {
  final ${featureName.pascalCase}Repo _repo;

  ${featureName.pascalCase}Usecase({
    required ${featureName.pascalCase}Repo repo,
  }) : _repo = repo;

  //* Get All ${featureName.pascalCase}
  Future<Either<String, ${featureName.pascalCase}Entity>> getAll${featureName.pascalCase}() =>
      _repo.getAll${featureName.pascalCase}();
}
''',
    'presentation/state/': null,
    'presentation/ui/screens/': null,
    'presentation/ui/widgets/': null,
  };

  // Create feature directories and files
  template.forEach((path, content) {
    final fullPath = '${featureDirectory.path}/$path';

    if (content == null) {
      // Create a directory
      final directory = Directory(fullPath);
      directory.createSync(recursive: true);
      print('Created directory: ${directory.path}');
    } else {
      // Create a file
      final file = File(fullPath);
      file.createSync(recursive: true);
      file.writeAsStringSync(content);
      print('Created file: ${file.path}');
    }
  });

  // Create injection file in main lib directory
  final injectionFile = File(
    '${injectionDirectory.path}/${featureName}_injection.dart',
  );
  injectionFile.createSync(recursive: true);
  injectionFile.writeAsStringSync('''
//!----------------------------  Imports  -------------------------------------!//
import 'package:dio/dio.dart';
import '../../../features/$featureName/data/datasources/${featureName}_remote_data_source.dart';
import '../../../features/$featureName/data/repositories/${featureName}_repository_impl.dart';
import '../../../features/$featureName/domain/repositories/${featureName}_repository.dart';
import '../../../features/$featureName/domain/usecases/${featureName}_usecase.dart';
import '../injection.dart';

//!----------------------------  The Class  -------------------------------------!//

Future<void> ${featureName}Injection() async {
  getIt.registerLazySingleton<${featureName.pascalCase}Remote>(
    () => ${featureName.pascalCase}Remote(
      getIt<Dio>(),
    ),
  );
  
  getIt.registerLazySingleton<${featureName.pascalCase}Repo>(
    () => ${featureName.pascalCase}RepoImp(
      remote: getIt<${featureName.pascalCase}Remote>(),
    ),
  );
  
  getIt.registerLazySingleton<${featureName.pascalCase}Usecase>(
    () => ${featureName.pascalCase}Usecase(
      repo: getIt<${featureName.pascalCase}Repo>(),
    ),
  );
}
''');

  print('Created injection file: ${injectionFile.path}');
  print('Feature "$featureName" generated successfully!');
}

// Helper extension to convert strings to PascalCase
extension StringExtensions on String {
  String get pascalCase {
    if (isEmpty) return this;
    return split(
      '_',
    ).map((word) => word[0].toUpperCase() + word.substring(1)).join();
  }
}
