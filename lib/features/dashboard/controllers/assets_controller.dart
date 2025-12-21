import 'package:get/get.dart';

class AssetsController extends GetxController{
  var selectedReport = RxnString();

  final List<String> reports = [
    "Balance Sheet",
    "Transaction Listing",
    "GST Extract",
    "Profit & Loss",
  ];

  /// Checkbox
  RxBool isPaidWithCash = false.obs;

  /// Switch
  RxBool isGstIncluded = false.obs;
}