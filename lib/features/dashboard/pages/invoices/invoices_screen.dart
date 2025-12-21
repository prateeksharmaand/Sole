import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sole/routes/routes.dart';

class InvoicesScreen extends StatelessWidget {
  const InvoicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextButton(onPressed: (){
              Get.toNamed(URoutes.notificationScreen);
            }, child: Text("Notification")),
            TextButton(onPressed: (){
              Get.toNamed(URoutes.invoiceQuoteBrandingScreen);
            }, child: Text("InvoiceQuoteBrandingScreen")),
          ],
        ),
      ),
    );
  }
}
