// 🎯 Dart imports:
import 'dart:async';
import 'dart:convert';

// 📦 Package imports:
import 'package:dio_refresh_bot/dio_refresh_bot.dart';

// 🌎 Project imports:
import '../../../shared/utils/storage_service/storage_service.dart';
import '../../constants/key_constants.dart';
import '../../models/auth_token_dio.dart';

class ReactiveTokenStorage extends BotMemoryTokenStorage<AuthTokenModel>
    with RefreshBotMixin<AuthTokenModel> {
  final StorageService storageService;

  ReactiveTokenStorage(this.storageService) : super();

  @override
  FutureOr<void> delete([String? message]) async {
    await storageService.remove(kTokenKey);
    super.delete(message);
  }

  @override
  FutureOr<void> write(AuthTokenModel? token) async {
    if (token != null) {
      await storageService.setString(kTokenKey, json.encode(token.toMap()));
    } else {
      await storageService.remove(kTokenKey);
    }
    _cachedToken = token;
    super.write(token);
  }

  AuthTokenModel? _cachedToken;

  @override
  AuthTokenModel? read() {
    return _cachedToken;
  }

  Future<void> loadToken() async {
    final String? string = await storageService.getString(kTokenKey);

    if (string != null) {
      _cachedToken = AuthTokenModel.fromMap(json.decode(string));
    } else {
      _cachedToken = null;
    }
  }
}
