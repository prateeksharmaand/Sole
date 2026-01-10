import 'package:get/get.dart';
import '../../../data/repositories/profile_repository.dart';
import '../../../data/repositories/auth_repository.dart';
import '../../../data/services/auth_storage_service.dart';
import '../../../data/models/user_model.dart';

class ProfileController extends GetxController {
  final ProfileRepository _profileRepository = ProfileRepository();
  final AuthRepository _authRepository = AuthRepository();
  final AuthStorageService _authStorageService = AuthStorageService();

  // User profile data
  final Rx<UserModel?> userProfile = Rx<UserModel?>(null);

  // Loading state
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadUserProfile();
  }

  /// Load user profile from API
  Future<void> loadUserProfile() async {
    if (isLoading.value) return;

    isLoading.value = true;

    try {
      final response = await _profileRepository.getProfile();

      if (response.success && response.data != null) {
        userProfile.value = response.data!;
        print('✅ Loaded user profile: ${response.data!.email}');
      } else {
        print('❌ Failed to load profile: ${response.message}');
      }
    } catch (e) {
      print('⚠️ Error loading profile: $e');
    } finally {
      isLoading.value = false;
    }
  }

  /// Refresh profile data
  Future<void> refreshProfile() async {
    await loadUserProfile();
  }

  /// Get display name (fallback to email if name is empty)
  String get displayName {
    if (userProfile.value == null) return '';

    final user = userProfile.value!;
    if (user.fullName.isNotEmpty) return user.fullName;
    if (user.firstName.isNotEmpty || user.lastName.isNotEmpty) {
      return '${user.firstName} ${user.lastName}'.trim();
    }
    return user.email;
  }

  /// Get profile picture URL
  String? get profilePictureUrl {
    return userProfile.value?.profilePic;
  }

  /// Get email
  String get email {
    return userProfile.value?.email ?? '';
  }

  /// Logout user
  Future<bool> logout() async {
    try {
      // Call logout API
      final response = await _authRepository.logout();

      // Clear local storage regardless of API response
      await _authStorageService.clearAuth();

      if (response.success) {
        print('✅ Logout successful');
        return true;
      } else {
        print(
          '⚠️ Logout API failed but local data cleared: ${response.message}',
        );
        return true; // Still return true since local data is cleared
      }
    } catch (e) {
      print('❌ Error during logout: $e');
      // Even if API call fails, clear local storage
      await _authStorageService.clearAuth();
      return true; // Return true since we still cleared local data
    }
  }
}
