import 'package:get/get.dart';
import 'package:sole/features/authentication/controller/auth_controller.dart';
import 'package:sole/features/authentication/controller/onboarding_controller.dart';


class UBindings extends Bindings{
  @override
  void dependencies() {
     Get.put(AuthController());
     Get.put(OnboardingController());
  }

}