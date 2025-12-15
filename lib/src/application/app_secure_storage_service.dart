import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AppSecureStorageService {
  static const String _accessToken = 'accessToken';
  static const String _refreshToken = 'refreshToken';

  AppSecureStorageService._();
  static AppSecureStorageService? _instance;

  late final FlutterSecureStorage _storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
    iOptions: IOSOptions(
      accessibility: KeychainAccessibility.first_unlock_this_device,
    ),
  );

  factory AppSecureStorageService() {
    _instance ??= AppSecureStorageService._();
    return _instance!;
  }

  Future<void> writeTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    await _storage.write(key: _accessToken, value: accessToken);
    await _storage.write(key: _refreshToken, value: refreshToken);
  }

  Future<void> deleteAll() async {
    await _storage.deleteAll();
  }

  Future<String?> readAccessToken() async {
    return await _storage.read(key: _accessToken);
  }

  Future<String?> readRefreshToken() async {
    return await _storage.read(key: _refreshToken);
  }

  Future<void> clearTokens() async {
    await _storage.delete(key: _accessToken);
    await _storage.delete(key: _refreshToken);
  }
}
