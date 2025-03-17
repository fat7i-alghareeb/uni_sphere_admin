// 📦 Package imports:

// 🌎 Project imports:


import 'package:jwt_decoder/jwt_decoder.dart';

import '../../core/auth_data_source/local/auth_local.dart';
import '../../core/injection/injection.dart';
import '../entities/user.dart';
import '../utils/helper/colored_print.dart';

bool isTokenAboutToExpire(String token, {int bufferTimeInSeconds = 900}) {
  try {
    // Decode the token
    DateTime expirationDate = JwtDecoder.getExpirationDate(token);
    printK("expirationDate:     $expirationDate");

    // Get the current time
    DateTime now = DateTime.now();
    printK("currentTime:     $now");

    // Add buffer time (default: 15 minutes)
    DateTime bufferTime =
        expirationDate.subtract(Duration(seconds: bufferTimeInSeconds));

    // Check if the token is about to expire
    bool shouldRefresh = now.isAfter(bufferTime);
    if (shouldRefresh) {
      printW("Should Refresh Token");
    }
    return shouldRefresh;
  } catch (e) {
    // Handle invalid token
    printR('Error decoding token: $e');
    return true; // Treat invalid token as expired
  }
}

Future<void> updateStorageToken(
  User user,
  String accessToken,
) async {
  User user2 = User(
    id: user.id,
    accessToken: accessToken,
    refreshToken: user.refreshToken,
    fullName: user.fullName,
    deviceToken: user.deviceToken,
  );
  await getIt<AuthLocal>().setUser(user2);
}
