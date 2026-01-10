import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../data/repositories/transaction_repository.dart';
import '../../../../data/repositories/client_repository.dart';
import '../../../../data/models/client_model.dart';
import 'transactions_controller.dart';

class AddTransactionController extends GetxController {
  final TransactionRepository _transactionRepository = TransactionRepository();
  final ClientRepository _clientRepository = ClientRepository();

  // Form controllers
  final transactionTypeController = TextEditingController(text: '1');
  final amountController = TextEditingController();
  final dateController = TextEditingController();
  final descriptionController = TextEditingController();

  // Observable values
  final RxString transactionType = 'Debit'.obs;
  final RxString selectedAccount = ''.obs;
  final Rx<ClientDetails?> selectedClient = Rx<ClientDetails?>(null);
  final RxBool includeGST = false.obs;
  final RxBool matchTransaction = false.obs;
  final RxBool isLoading = false.obs;
  final RxBool isSaving = false.obs;

  // Clients list
  final RxList<ClientDetails> clientsList = <ClientDetails>[].obs;

  // Form key for validation
  final formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    loadClients();
  }

  /// Load clients from API
  Future<void> loadClients() async {
    try {
      isLoading.value = true;
      final response = await _clientRepository.getClients(
        pageSize: 1000,
        type: 'client',
      );

      if (response.success && response.data != null) {
        clientsList.value = response.data!;
        print('Loaded ${clientsList.length} clients');
      } else {
        Get.snackbar(
          'Error',
          response.message ?? 'Failed to load clients',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      print('Error loading clients: $e');
      Get.snackbar(
        'Error',
        'Failed to load clients',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// Validate form
  bool validateForm() {
    if (formKey.currentState?.validate() ?? false) {
      // Additional validations
      if (amountController.text.isEmpty) {
        Get.snackbar(
          'Validation Error',
          'Please enter amount',
          snackPosition: SnackPosition.BOTTOM,
        );
        return false;
      }

      if (dateController.text.isEmpty) {
        Get.snackbar(
          'Validation Error',
          'Please select transaction date',
          snackPosition: SnackPosition.BOTTOM,
        );
        return false;
      }

      if (descriptionController.text.isEmpty) {
        Get.snackbar(
          'Validation Error',
          'Please enter description',
          snackPosition: SnackPosition.BOTTOM,
        );
        return false;
      }

      return true;
    }
    return false;
  }

  /// Save transaction
  Future<void> saveTransaction() async {
    if (!validateForm()) return;

    try {
      isSaving.value = true;

      // Parse amount
      final amount = double.tryParse(amountController.text) ?? 0.0;

      // Parse date to YYYY-MM-DD format
      final dateStr = _convertToApiDateFormat(dateController.text);

      // Transaction type (1 by default as per requirement)
      final txnType = int.tryParse(transactionTypeController.text) ?? 1;

      final response = await _transactionRepository.addTransaction(
        transactionType: txnType,
        amount: amount,
        transactionDate: dateStr,
        description: descriptionController.text,
        clientId: selectedClient.value?.clientId,
        expenseId: 13787, // Temporary hardcoded expense ID
      );

      if (response.success) {
        Get.snackbar(
          'Success',
          'Transaction added successfully!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Get.theme.colorScheme.primary,
          colorText: Get.theme.colorScheme.onPrimary,
        );

        // Navigate back
        Get.back();

        // Refresh transactions list
        try {
          final transactionsController = Get.find<TransactionsController>();
          await transactionsController.refreshTransactions();
        } catch (e) {
          print('TransactionsController not found: $e');
        }
      } else {
        Get.snackbar(
          'Error',
          response.message ?? 'Failed to add transaction',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      print('Error saving transaction: $e');
      Get.snackbar(
        'Error',
        'An unexpected error occurred',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isSaving.value = false;
    }
  }

  /// Convert date from "dd MMM, yyyy" to "yyyy-MM-dd"
  String _convertToApiDateFormat(String displayDate) {
    try {
      // Try parsing from display format
      final date = DateFormat('dd MMM, yyyy').parse(displayDate);
      return DateFormat('yyyy-MM-dd').format(date);
    } catch (e) {
      // If already in correct format, return as is
      return displayDate;
    }
  }

  @override
  void onClose() {
    transactionTypeController.dispose();
    amountController.dispose();
    dateController.dispose();
    descriptionController.dispose();
    super.onClose();
  }
}
