import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sole/features/dashboard/dashboard/dashboard_screen.dart';
import 'package:sole/routes/app_routes.dart';
import 'package:sole/utils/theme/theme.dart';
import 'bindings/bindings.dart';
import 'features/authentication/screens/splash/splash_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: UAppTheme.lightTheme,
      darkTheme: UAppTheme.darkTheme,

      getPages: UAppRoutes.screens,

      initialBinding: UBindings(),
      home: DashboardScreen(),
    );
  }
}
