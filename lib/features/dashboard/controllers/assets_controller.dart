import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AssetsController extends GetxController{
  var selectedReport = RxnString();
  var selectedCategory = RxnString();

  final List<String> reports = [
    "Balance Sheet",
    "Transaction Listing",
    "GST Extract",
    "Profit & Loss",
  ];

  final List<String> categoryList = [
    "Category 1",
    "Category 2",
    "Category 3",
    "Category 4",
  ];

  /// Checkbox
  RxBool isPaidWithCash = false.obs;

  /// Switch
  RxBool isGstIncluded = false.obs;


  Rx<File?> receiptImage = Rx<File?>(null);

  final ImagePicker picker = ImagePicker();

  Future<void> pickFromGallery() async {
    final XFile? file = await picker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      receiptImage.value = File(file.path);
    }
  }

  void clearImage() {
    receiptImage.value = null;
  }
}