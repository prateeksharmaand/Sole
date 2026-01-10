import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import '../models/user_model.dart';

/// Service to manage authentication data in local storage
class AuthStorageService {
  final GetStorage _storage = GetStorage();

  // Storage keys
  static const String _tokenKey = 'auth_token';
  static const String _userKey = 'user_data';
  static const String _deviceIdKey = 'device_id';

  /// Save authentication token
  Future<void> saveToken(String token) async {
    await _storage.write(_tokenKey, token);
  }

  /// Get authentication token
  String? getToken() {
    return _storage.read<String>(_tokenKey);
  }

  /// Save user data
  Future<void> saveUser(UserModel user) async {
    await _storage.write(_userKey, jsonEncode(user.toJson()));
  }

  /// Get user data
  UserModel? getUser() {
    final userData = _storage.read<String>(_userKey);
    if (userData != null) {
      return UserModel.fromJson(jsonDecode(userData));
    }
    return null;
  }

  /// Save device ID
  Future<void> saveDeviceId(int deviceId) async {
    await _storage.write(_deviceIdKey, deviceId);
  }

  /// Get device ID
  int? getDeviceId() {
    return _storage.read<int>(_deviceIdKey);
  }

  /// Clear all authentication data (logout)
  Future<void> clearAuth() async {
    await _storage.remove(_tokenKey);
    await _storage.remove(_userKey);
    // Note: We don't clear device_id as it should persist across logins
  }

  /// Check if user is logged in
  bool isLoggedIn() {
    final token = getToken();
    return token != null && token.isNotEmpty;
  }

  /// Get user ID
  String? getUserId() {
    final user = getUser();
    return user?.userId;
  }

  /// Get user email
  String? getUserEmail() {
    final user = getUser();
    return user?.email;
  }

  /// Check if user is first time login
  bool isFirstLogin() {
    final user = getUser();
    return user?.isFirstLogin ?? false;
  }
}
