import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'my_app.dart';

Future<void> main() async {
  /// Widgets Flutter Binding
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  /// Get Storage Initialization
  await GetStorage.init();

  /// Initialize Branch SDK
  // Get.put(BranchServices()).initBranch();

  /// Initialize Publishable Key
  //  Stripe.publishableKey = UKeys.stripePublishableKey;

  /// Portrait Up The Device
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(const MyApp());
}
