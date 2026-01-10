import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../data/repositories/auth_repository.dart';

/// Controller to handle app initialization tasks
/// This includes device registration and other startup tasks
class AppInitializationController extends GetxController {
  final isInitializing = true.obs;
  final initializationComplete = false.obs;

  @override
  void onInit() {
    super.onInit();
    _initializeApp();
  }

  /// Initialize the app by performing startup tasks
  Future<void> _initializeApp() async {
    try {
      isInitializing.value = true;

      // Register device if not already registered
      await _registerDeviceIfNeeded();

      // Add other initialization tasks here if needed
      // e.g., check for updates, load cached data, etc.

      initializationComplete.value = true;
    } catch (e) {
      print('⚠️ App initialization error: $e');
      // Even if there's an error, mark initialization as complete
      // to prevent the app from being stuck
      initializationComplete.value = true;
    } finally {
      isInitializing.value = false;
    }
  }

  /// Register device if not already registered
  Future<void> _registerDeviceIfNeeded() async {
    final storage = GetStorage();
    final existingDeviceId = storage.read('device_id');

    if (existingDeviceId == null) {
      try {
        print('📱 Registering device...');
        final authRepo = AuthRepository();
        final response = await authRepo.registerDevice();

        if (response.success && response.data != null) {
          // Store device_id
          await storage.write('device_id', response.data);
          print('✅ Device registered successfully. ID: ${response.data}');
        } else {
          print('❌ Device registration failed: ${response.message}');
          // Note: We don't throw an error here because we want the app to continue
          // even if device registration fails
        }
      } catch (e) {
        print('⚠️ Device registration error: $e');
        // Don't throw - allow app to continue
      }
    } else {
      print('ℹ️ Device already registered. ID: $existingDeviceId');
    }
  }

  /// Force re-register device (useful for testing or troubleshooting)
  Future<void> forceRegisterDevice() async {
    final storage = GetStorage();

    try {
      print('📱 Force registering device...');
      final authRepo = AuthRepository();
      final response = await authRepo.registerDevice();

      if (response.success && response.data != null) {
        await storage.write('device_id', response.data);
        print('✅ Device force-registered successfully. ID: ${response.data}');
      } else {
        print('❌ Device registration failed: ${response.message}');
      }
    } catch (e) {
      print('⚠️ Force device registration error: $e');
    }
  }
}
