import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get_storage/get_storage.dart';

/// Service to collect device information
class DeviceInfoService {
  final DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();
  final GetStorage _storage = GetStorage();

  /// Get unique device identifier
  Future<String> getDeviceUid() async {
    String? deviceUid = _storage.read('device_uid');

    if (deviceUid != null) {
      return deviceUid;
    }

    // Generate new device UID
    if (Platform.isAndroid) {
      final androidInfo = await _deviceInfo.androidInfo;
      deviceUid = androidInfo.id; // Android ID
    } else if (Platform.isIOS) {
      final iosInfo = await _deviceInfo.iosInfo;
      deviceUid = iosInfo.identifierForVendor ?? '';
    } else {
      deviceUid = 'unknown-${DateTime.now().millisecondsSinceEpoch}';
    }

    // Store for future use
    await _storage.write('device_uid', deviceUid);
    return deviceUid;
  }

  /// Get platform (ANDR for Android, IOS for iOS)
  Future<String> getPlatform() async {
    if (Platform.isAndroid) {
      return 'ANDR';
    } else if (Platform.isIOS) {
      return 'IOS';
    } else {
      return 'OTHER';
    }
  }

  /// Get device name
  Future<String> getDeviceName() async {
    if (Platform.isAndroid) {
      final androidInfo = await _deviceInfo.androidInfo;
      return '${androidInfo.manufacturer} ${androidInfo.model}';
    } else if (Platform.isIOS) {
      final iosInfo = await _deviceInfo.iosInfo;
      return iosInfo.name;
    } else {
      return 'Unknown Device';
    }
  }

  /// Get device OS version
  Future<String> getDeviceOs() async {
    if (Platform.isAndroid) {
      final androidInfo = await _deviceInfo.androidInfo;
      return 'Android ${androidInfo.version.release}';
    } else if (Platform.isIOS) {
      final iosInfo = await _deviceInfo.iosInfo;
      return 'iOS ${iosInfo.systemVersion}';
    } else {
      return 'Unknown OS';
    }
  }

  /// Get app version
  Future<String> getAppVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    return 'V${packageInfo.version}';
  }

  /// Get push notification token
  Future<String> getPushToken() async {
    try {
      String? token = await FirebaseMessaging.instance.getToken();
      return token ?? 'no-token-${DateTime.now().millisecondsSinceEpoch}';
    } catch (e) {
      // If Firebase is not configured, return a placeholder
      return 'no-firebase-token';
    }
  }

  /// Get all device information at once
  Future<Map<String, String>> getDeviceInfo() async {
    return {
      'device_uid': await getDeviceUid(),
      'platform': await getPlatform(),
      'device_name': await getDeviceName(),
      'device_os': await getDeviceOs(),
      'app_version': await getAppVersion(),
      'push_token': await getPushToken(),
    };
  }
}
