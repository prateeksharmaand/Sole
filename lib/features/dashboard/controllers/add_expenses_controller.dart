import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class AddExpensesController extends GetxController {
  /// Checkbox
  RxBool isPaidWithCash = false.obs;

  /// Switch
  RxBool isGstIncluded = false.obs;

  /// Report
  var selectedReport = RxnString();

  var selectedCategory = RxnString();

  /// Date
  Rx<DateTime?> selectedDate = Rx<DateTime?>(null);

  String get formattedDate {
    if (selectedDate.value == null) return '';
    return DateFormat('dd MMM yyyy').format(selectedDate.value!);
  }

  final List<String> reports = [
    "Balance Sheet",
    "Transaction Listing",
    "GST Extract",
    "Profit & Loss",
  ];
  final List<String> categoryList = [
    "category 1",
    "category 2",
    "category 3",
    "category 4",
  ];


  Rx<File?> selectedImage = Rx<File?>(null);

  final ImagePicker _picker = ImagePicker();

  Future pickFromGallery() async {
    final picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      selectedImage.value = File(picked.path);
    }
  }

  Future pickFromCamera() async {
    final picked = await _picker.pickImage(source: ImageSource.camera);
    if (picked != null) {
      selectedImage.value = File(picked.path);
    }
  }

  void clearImage() {
    selectedImage.value = null;
  }
}
