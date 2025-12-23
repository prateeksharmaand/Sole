import 'package:get/get.dart';
import 'package:sole/features/authentication/controller/auth_controller.dart';
import 'package:sole/features/authentication/controller/onboarding_controller.dart';
import 'package:sole/features/dashboard/dashboard/dashboard_controller.dart';
import 'package:sole/features/dashboard/transactions/transactions_controller.dart';

class UBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthController());
    Get.put(OnboardingController());
    Get.put(DashboardController());
    Get.put(TransactionsController());
  }
}
