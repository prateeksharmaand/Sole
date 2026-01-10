import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../data/models/asset_model.dart';
import '../../../data/models/client_model.dart';
import '../../../data/repositories/assets_repository.dart';
import '../../../data/repositories/clients_repository.dart';

class AssetsController extends GetxController {
  final AssetsRepository _assetsRepository = AssetsRepository();
  final ClientsRepository _clientsRepository = ClientsRepository();

  // Dropdowns
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

  // Checkbox & Switch
  RxBool isPaidWithCash = false.obs;
  RxBool isGstIncluded = false.obs;

  // Image
  Rx<File?> receiptImage = Rx<File?>(null);
  final ImagePicker picker = ImagePicker();

  // Text Controllers for New Asset Form
  final TextEditingController assetNameController = TextEditingController();
  final TextEditingController assetValueController = TextEditingController();
  final TextEditingController datePurchaseController = TextEditingController();

  // Assets List
  final RxList<AssetDetails> assetsList = <AssetDetails>[].obs;
  final RxBool isLoadingAssets = false.obs;
  final RxBool isSavingAsset = false.obs;

  // Pagination
  final RxInt currentPage = 1.obs;
  final RxInt totalPages = 0.obs;
  final RxBool hasMoreAssets = true.obs;

  // Clients/Suppliers list
  final RxList<ClientDetails> clientsList = <ClientDetails>[].obs;
  final RxBool isLoadingClients = false.obs;
  final RxnInt selectedClientId = RxnInt();

  @override
  void onInit() {
    super.onInit();
    loadAssets();
    loadClients(); // Load clients for dropdown
  }

  @override
  void onClose() {
    assetNameController.dispose();
    assetValueController.dispose();
    datePurchaseController.dispose();
    super.onClose();
  }

  /// Load assets from API
  Future<void> loadAssets({int page = 1}) async {
    isLoadingAssets.value = true;

    try {
      final response = await _assetsRepository.getAssets(
        page: page,
        pageSize: 20,
      );

      if (response.success && response.data != null) {
        if (page == 1) {
          assetsList.value = response.data!.assetDetails;
        } else {
          assetsList.addAll(response.data!.assetDetails);
        }

        currentPage.value = page;
        totalPages.value = response.data!.totalPages;
        hasMoreAssets.value = response.data!.nextPage != -1;
      }
    } finally {
      isLoadingAssets.value = false;
    }
  }

  /// Load more assets (pagination)
  Future<void> loadMoreAssets() async {
    if (!isLoadingAssets.value && hasMoreAssets.value) {
      await loadAssets(page: currentPage.value + 1);
    }
  }

  /// Refresh assets list
  Future<void> refreshAssets() async {
    await loadAssets(page: 1);
  }

  /// Load clients for suppliers dropdown
  Future<void> loadClients() async {
    isLoadingClients.value = true;

    try {
      final response = await _clientsRepository.getClients(
        page: 1,
        pageSize: 100, // Get more clients for dropdown
      );

      if (response.success && response.data != null) {
        clientsList.value = response.data!.clientsDetails;
      }
    } finally {
      isLoadingClients.value = false;
    }
  }

  /// Create new asset
  Future<void> createNewAsset() async {
    // Validation
    if (assetNameController.text.trim().isEmpty) {
      Get.snackbar('Validation Error', 'Please enter asset name');
      return;
    }

    if (assetValueController.text.trim().isEmpty) {
      Get.snackbar('Validation Error', 'Please enter asset value');
      return;
    }

    if (datePurchaseController.text.trim().isEmpty) {
      Get.snackbar('Validation Error', 'Please select purchase date');
      return;
    }

    if (selectedClientId.value == null) {
      Get.snackbar('Validation Error', 'Please select supplier');
      return;
    }

    if (selectedCategory.value == null) {
      Get.snackbar('Validation Error', 'Please select category');
      return;
    }

    isSavingAsset.value = true;

    try {
      final response = await _assetsRepository.createAsset(
        accountSubcategoryId: 116, // Replace with actual category ID mapping
        name: assetNameController.text.trim(),
        dateOfPurchase: datePurchaseController.text.trim(),
        price: double.tryParse(assetValueController.text.trim()) ?? 0,
        clientId: selectedClientId.value!, // Use selected client ID
        gst: isGstIncluded.value ? 1 : 0,
        paidWithCash: isPaidWithCash.value ? 1 : 0,
        assetImagePath: receiptImage.value?.path,
      );

      if (response.success) {
        // Clear form
        clearNewAssetForm();

        // Refresh assets list
        await refreshAssets();

        // Navigate back
        Get.back();
      }
    } finally {
      isSavingAsset.value = false;
    }
  }

  /// Clear new asset form
  void clearNewAssetForm() {
    assetNameController.clear();
    assetValueController.clear();
    datePurchaseController.clear();
    selectedReport.value = null;
    selectedCategory.value = null;
    selectedClientId.value = null; // Clear selected client
    isPaidWithCash.value = false;
    isGstIncluded.value = false;
    receiptImage.value = null;
  }

  /// Image picker
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
