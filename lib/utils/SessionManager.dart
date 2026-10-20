import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SessionManager {
  static const _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
    iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
  );

  static const String _keyIsLoggedIn = "isLoggedIn";
  static const String _keyUserId = "userId";
  static const String _keyUserName = "userName";
  static const String _keyUserToken = "userToken";
  static const String _keyPhone = "userPhone";

  // Save Session After Login
  static Future<void> saveSession({
    required String userId,
    required String userName,
    required String phone,
    required String token,
  }) async {
    await _storage.write(key: _keyIsLoggedIn, value: "true");
    await _storage.write(key: _keyUserId, value: userId);
    await _storage.write(key: _keyUserName, value: userName);
    await _storage.write(key: _keyPhone, value: phone);
    await _storage.write(key: _keyUserToken, value: token);
  }

  static Future<bool> isLoggedIn() async {
    String? logged = await _storage.read(key: _keyIsLoggedIn);
    String? token = await _storage.read(key: _keyUserToken);
    return logged == "true" && token != null && token.isNotEmpty;
  }

  static Future<Map<String, String?>> getUser() async {
    return {
      'userId': await _storage.read(key: _keyUserId),
      'userName': await _storage.read(key: _keyUserName),
      'phone': await _storage.read(key: _keyPhone),
      'token': await _storage.read(key: _keyUserToken),
    };
  }

  static Future<String?> getToken() async {
    return await _storage.read(key: _keyUserToken);
  }

  // Logout - Clear All
  static Future<void> clearSession() async {
    await _storage.deleteAll();
  }

  // Update single value (like token refresh)
  static Future<void> updateToken(String newToken) async {
    await _storage.write(key: _keyUserToken, value: newToken);
  }
}