import 'package:internet_connection_checker/internet_connection_checker.dart';

Future<bool> internetChecker() async {
  // Use createInstance() to create an instance of InternetConnectionChecker
  final internetConnectionChecker = InternetConnectionChecker.createInstance();
  
  // Check for an internet connection
  bool result = await internetConnectionChecker.hasConnection;
  return result;
}