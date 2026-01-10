import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sole/data/services/auth_storage_service.dart';
import 'package:sole/features/authentication/controllers/app_initialization_controller.dart';
import 'package:sole/routes/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AuthStorageService _authStorage = AuthStorageService();

  @override
  void initState() {
    super.initState();

    // Initialize the app (includes device registration)
    final appInitController = Get.put(AppInitializationController());

    // Wait for minimum splash duration and initialization to complete
    Future.wait([
      Future.delayed(const Duration(seconds: 3)),
      Future.doWhile(() async {
        await Future.delayed(const Duration(milliseconds: 100));
        return !appInitController.initializationComplete.value;
      }),
    ]).then((_) {
      // Check if user is logged in
      if (_authStorage.isLoggedIn()) {
        // User is logged in, navigate to dashboard
        Get.offAllNamed(URoutes.dashboard);
      } else {
        // User not logged in, navigate to onboarding
        Get.offAllNamed(URoutes.onBoarding);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Image.asset("assets/logo/Logo.png")));
  }
}
