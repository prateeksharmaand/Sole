import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../../../data/repositories/expense_repository.dart';
import '../../../data/repositories/clients_repository.dart';
import '../../../data/models/expense_model.dart';
import '../../../data/models/client_model.dart';
import '../../../data/api/api_response.dart';
import 'expense_controller.dart';

class AddExpensesController extends GetxController {
  final ExpenseRepository _expenseRepository = ExpenseRepository();
  final ClientsRepository _clientsRepository = ClientsRepository();

  // Form controllers
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();

  // Observable fields
  RxBool isPaidWithCash = false.obs;
  RxBool isGstIncluded = false.obs;
  RxBool isAsset = false.obs;
  RxBool isSaving = false.obs;
  RxBool isLoadingClients = false.obs;
  RxBool hasLoadedClients = false.obs; // Track if clients have been loaded

  // Edit mode
  RxBool isEditMode = false.obs;
  Rx<int?> editingExpenseId = Rx<int?>(null);

  // Selected values
  var selectedReport = RxnString();
  var selectedCategory = RxnString();
  Rx<DateTime?> selectedDate = Rx<DateTime?>(null);

  // Client selection
  Rx<int?> selectedClientId = Rx<int?>(null);
  final RxList<ClientDetails> clients = <ClientDetails>[].obs;

  // Classifications/Tags
  final RxList<ExpenseClassification> selectedClassifications =
      <ExpenseClassification>[].obs;

  String get formattedDate {
    if (selectedDate.value == null) return '';
    return DateFormat('dd MMM yyyy').format(selectedDate.value!);
  }

  String get apiFormattedDate {
    if (selectedDate.value == null) return '';
    return DateFormat('yyyy-MM-dd').format(selectedDate.value!);
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

  // Image handling
  Rx<File?> selectedImage = Rx<File?>(null);
  RxString existingImageUrl =
      ''.obs; // For edit mode - stores the expense's existing image URL
  final ImagePicker _picker = ImagePicker();

  @override
  void onInit() {
    super.onInit();

    // Check if editing an expense (passed as argument)
    final expense = Get.arguments as ExpenseModel?;
    if (expense != null) {
      loadExpenseForEdit(expense);
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    super.onClose();
  }

  /// Load clients from API (called when user taps on client field)
  Future<void> loadClients() async {
    // Don't reload if already loaded
    if (hasLoadedClients.value) return;

    isLoadingClients.value = true;

    try {
      final response = await _clientsRepository.getClients(
        page: 1,
        pageSize: 100, // Load all clients for dropdown
      );

      if (response.success && response.data != null) {
        clients.value = response.data!.clientsDetails;
        hasLoadedClients.value = true;

        // Auto-select first client if available
        if (clients.isNotEmpty && selectedClientId.value == null) {
          selectedClientId.value = clients.first.clientId;
        }

        print('✅ Loaded ${clients.length} clients');
      } else {
        print('❌ Failed to load clients: ${response.message}');
      }
    } catch (e) {
      print('⚠️ Error loading clients: $e');
    } finally {
      isLoadingClients.value = false;
    }
  }

  /// Load expense data for editing
  void loadExpenseForEdit(ExpenseModel expense) {
    isEditMode.value = true;
    editingExpenseId.value = expense.expenseId;

    // Pre-fill form fields
    nameController.text = expense.name;
    descriptionController.text = expense.description;
    priceController.text = expense.price.toString();

    // Set date
    try {
      selectedDate.value = DateTime.parse(expense.date);
    } catch (e) {
      print('Error parsing date: $e');
    }

    // Set toggles
    isPaidWithCash.value = expense.paidWithCash == 1;
    isGstIncluded.value = expense.gst == 1;

    // Set client
    selectedClientId.value = expense.client.clientId;

    // Set classifications
    selectedClassifications.value = expense.classifications;

    // Set existing image URL if available
    if (expense.image != null && expense.image!.isNotEmpty) {
      existingImageUrl.value = expense.image!;
      print('✏️ Edit mode: Loaded existing image URL: ${expense.image}');
    }

    print('✏️ Edit mode: Loading expense ${expense.name}');
  }

  /// Pick image from gallery
  Future pickFromGallery() async {
    final picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      selectedImage.value = File(picked.path);
    }
  }

  /// Pick image from camera
  Future pickFromCamera() async {
    final picked = await _picker.pickImage(source: ImageSource.camera);
    if (picked != null) {
      selectedImage.value = File(picked.path);
    }
  }

  /// Clear selected image
  void clearImage() {
    selectedImage.value = null;
    existingImageUrl.value = ''; // Also  clear existing image URL
  }

  /// Select date
  void selectDate(DateTime date) {
    selectedDate.value = date;
  }

  /// Add classification
  void addClassification(String name) {
    // Create a temporary classification (will be created on server when expense is saved)
    final newClassification = ExpenseClassification(
      id: 0, // Temporary ID
      userId: 0,
      name: name,
      createdAt: DateTime.now().toIso8601String(),
      updatedAt: DateTime.now().toIso8601String(),
    );
    selectedClassifications.add(newClassification);
  }

  /// Add existing classification
  void addExistingClassification(ExpenseClassification classification) {
    if (!selectedClassifications.any((c) => c.id == classification.id)) {
      selectedClassifications.add(classification);
    }
  }

  /// Remove classification
  void removeClassification(int index) {
    if (index >= 0 && index < selectedClassifications.length) {
      selectedClassifications.removeAt(index);
    }
  }

  /// Validate form
  bool validateForm() {
    if (nameController.text.trim().isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter expense name',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }

    if (descriptionController.text.trim().isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter description',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }

    if (priceController.text.trim().isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter price',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }

    final price = num.tryParse(priceController.text.trim());
    if (price == null || price <= 0) {
      Get.snackbar(
        'Error',
        'Please enter a valid price',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }

    if (selectedDate.value == null) {
      Get.snackbar(
        'Error',
        'Please select a date',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }

    if (selectedClientId.value == null || selectedClientId.value == 0) {
      Get.snackbar(
        'Error',
        'Please select a client',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }

    return true;
  }

  /// Create or update expense
  Future<void> createExpense() async {
    if (!validateForm()) return;

    isSaving.value = true;

    try {
      // Separate existing and new classifications
      final existingClassificationIds = selectedClassifications
          .where((c) => c.id > 0)
          .map((c) => c.id)
          .toList();

      final newClassificationNames = selectedClassifications
          .where((c) => c.id == 0)
          .map((c) => c.name)
          .toList();

      late final ApiResponse<void> response;

      if (isEditMode.value && editingExpenseId.value != null) {
        // Update existing expense
        response = await _expenseRepository.editExpense(
          expenseId: editingExpenseId.value!,
          clientId: selectedClientId.value!,
          name: nameController.text.trim(),
          description: descriptionController.text.trim(),
          date: apiFormattedDate,
          price: num.parse(priceController.text.trim()),
          gst: isGstIncluded.value ? 1 : 0,
          isAsset: isAsset.value ? 'yes' : 'no',
          classificationIds: existingClassificationIds.isNotEmpty
              ? existingClassificationIds
              : null,
          classificationNames: newClassificationNames.isNotEmpty
              ? newClassificationNames
              : null,
          paidWithCash: isPaidWithCash.value ? 1 : 0,
          imagePath: selectedImage.value?.path,
        );
      } else {
        // Create new expense
        response = await _expenseRepository.createExpense(
          clientId: selectedClientId.value!,
          name: nameController.text.trim(),
          description: descriptionController.text.trim(),
          date: apiFormattedDate,
          price: num.parse(priceController.text.trim()),
          gst: isGstIncluded.value ? 1 : 0,
          isAsset: isAsset.value ? 'yes' : 'no',
          classificationIds: existingClassificationIds.isNotEmpty
              ? existingClassificationIds
              : null,
          classificationNames: newClassificationNames.isNotEmpty
              ? newClassificationNames
              : null,
          paidWithCash: isPaidWithCash.value ? 1 : 0,
          imagePath: selectedImage.value?.path,
        );
      }

      if (response.success || response.message == "Init error") {
        final expenseController = Get.find<ExpenseController>();
        await expenseController.refreshExpenses();
        Navigator.pop(Get.context!);
        Navigator.pop(Get.context!);
        clearForm();
      }
    } catch (e) {
      print('⚠️ Error creating expense: $e');
    } finally {
      isSaving.value = false;
    }
  }

  /// Clear form
  void clearForm() {
    nameController.clear();
    descriptionController.clear();
    priceController.clear();
    selectedDate.value = null;
    isPaidWithCash.value = false;
    isGstIncluded.value = false;
    isAsset.value = false;
    selectedReport.value = null;
    selectedCategory.value = null;
    selectedClassifications.clear();
    existingImageUrl.value = '';
    isEditMode.value = false; // Reset edit mode
    editingExpenseId.value = null; // Reset editing ID
    clearImage();
  }
}
