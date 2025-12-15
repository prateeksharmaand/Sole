import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sole/utils/constants/colors.dart';


class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(LoadingController());
    return Scaffold(
      backgroundColor: UColors.primary,
      body: Center(
        child: CircularProgressIndicator(color: UColors.white),
      ),
    );
  }
}

class LoadingController extends GetxController{
  static LoadingController get instance => Get.find();


  @override
  void onInit() {
    // BranchServices.instance.trackLink((data){
    //   AuthenticationRepository.instance.screenRedirect();
    // }, onError: () => AuthenticationRepository.instance.screenRedirect());
    super.onInit();
  }
}

