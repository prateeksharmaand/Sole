import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get_storage/get_storage.dart';
import '../../../../data/repositories/transaction_repository.dart';
import '../../../../data/models/bank_transaction_model.dart';

class TransactionsController extends GetxController {
  static TransactionsController get instance => Get.find();

  final TransactionRepository _transactionRepository = TransactionRepository();
  final _storage = GetStorage();

  // API Data
  final Rx<BankTransactionData?> transactionData = Rx<BankTransactionData?>(
    null,
  );
  final RxList<BankTransactionDetail> allTransactions =
      <BankTransactionDetail>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool isUploading = false.obs;

  // Selected Bank Account Index
  final RxInt selectedAccountIndex = 0.obs;

  // Search query
  final RxString searchQuery = ''.obs;

  // Matched/Unmatched Toggle
  final RxString selectedTab = 'Unmatched'.obs; // 'Unmatched' or 'Matched'

  // Pagination
  final RxInt currentPage = 1.obs;
  final RxInt pageSize = 10.obs;
  final RxBool hasMore = true.obs;

  // Mock Bank Accounts Data (keep this for now until bank accounts API is integrated)
  final RxList<Map<String, dynamic>> bankAccounts = <Map<String, dynamic>>[
    {
      'name': 'Full-time Employee Acc',
      'balance': 5759.4,
      'lastSynced': '16 Dec 2025, - 02:09 AM',
      'accountNumber': '26949069',
      'type': 'TRANS_AND_SAVINGS_ACCOUNTS',
    },
    {
      'name': 'Savings Account',
      'balance': 12450.0,
      'lastSynced': '15 Dec 2025, - 10:15 PM',
      'accountNumber': '98765432',
      'type': 'SAVINGS_ACCOUNT',
    },
  ].obs;

  // Convert API data to Map format for UI compatibility
  List<Map<String, dynamic>> get unmatchedTransactions {
    return allTransactions
        .where((t) => !t.hasPossibleMatches)
        .map((t) => _convertToMapFormat(t))
        .toList();
  }

  List<Map<String, dynamic>> get matchedTransactions {
    return allTransactions
        .where((t) => t.hasPossibleMatches)
        .map((t) => _convertToMapFormat(t))
        .toList();
  }

  /// Convert BankTransactionDetail to Map<String, dynamic> format
  Map<String, dynamic> _convertToMapFormat(BankTransactionDetail t) {
    return {
      'title': t.description.isNotEmpty ? t.description : t.userDescription,
      'id': '#${t.transactionId}',
      'date': _formatDate(t.transactionDate),
      'amount': t.direction.toLowerCase() == 'debit'
          ? -t.amountValue
          : t.amountValue,
      'type': t.direction.toLowerCase() == 'credit' ? 'Credit' : 'Debit',
      'category': t.accountSubcategory.isNotEmpty ? 'Category' : '',
    };
  }

  /// Format date from API (2025-09-19) to UI format (19 Sep, 2025)
  String _formatDate(String dateStr) {
    try {
      final date = DateTime.parse(dateStr);
      return DateFormat('d MMM, yyyy').format(date);
    } catch (e) {
      return dateStr;
    }
  }

  void changeTab(String tab) {
    selectedTab.value = tab;
  }

  void updateSearch(String query) {
    searchQuery.value = query;
  }

  void selectAccount(int index) {
    selectedAccountIndex.value = index;
  }

  /// Upload bulk transactions from CSV file
  Future<void> uploadBulkTransactions() async {
    try {
      // Pick CSV file
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['csv'],
        allowMultiple: false,
      );

      if (result == null || result.files.isEmpty) {
        // User canceled the picker
        return;
      }

      final filePath = result.files.single.path;
      if (filePath == null) {
        Get.snackbar(
          'Error',
          'Could not access the file',
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }

      isUploading.value = true;

      // Get user ID from storage
      final userData = _storage.read('user');
      final userId = userData?['user_id'] ?? 0;

      if (userId == 0) {
        Get.snackbar(
          'Error',
          'User not logged in',
          snackPosition: SnackPosition.BOTTOM,
        );
        isUploading.value = false;
        return;
      }

      // Upload file
      final response = await _transactionRepository.uploadBulkTransactions(
        filePath: filePath,
        userId: userId,
      );

      if (response.success && response.data != null) {
        Get.snackbar(
          'Success',
          '${response.data!.transactionCount} transactions uploaded successfully!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Get.theme.colorScheme.primary,
          colorText: Get.theme.colorScheme.onPrimary,
        );

        // Refresh transactions list
        await refreshTransactions();
      } else {
        Get.snackbar(
          'Error',
          response.message ?? 'Failed to upload transactions',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      print('Error uploading bulk transactions: $e');
      Get.snackbar(
        'Error',
        'An unexpected error occurred while uploading',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isUploading.value = false;
    }
  }

  /// Fetch transactions from API
  Future<void> fetchTransactions({bool refresh = false}) async {
    if (refresh) {
      currentPage.value = 1;
      allTransactions.clear();
    }

    isLoading.value = true;

    try {
      final response = await _transactionRepository.getBankTransactions(
        pageSize: pageSize.value,
        page: currentPage.value,
        filterByType: 'debit',
      );

      if (response.success && response.data != null) {
        transactionData.value = response.data;

        if (refresh) {
          allTransactions.value =
              response.data!.bankTransactions.bankTransactionDetails;
        } else {
          allTransactions.addAll(
            response.data!.bankTransactions.bankTransactionDetails,
          );
        }

        hasMore.value = response.data!.bankTransactions.nextPage != -1;

        print('Transactions loaded successfully');
        print('Total: ${response.data!.bankTransactions.total}');
        print('Unmatched: ${unmatchedTransactions.length}');
        print('Matched: ${matchedTransactions.length}');
      } else {
        Get.snackbar(
          'Error',
          response.message ?? 'Failed to load transactions',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      print('Error fetching transactions: $e');
      Get.snackbar(
        'Error',
        'An unexpected error occurred',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// Load more transactions (pagination)
  Future<void> loadMore() async {
    if (!hasMore.value || isLoading.value) return;
    currentPage.value++;
    await fetchTransactions();
  }

  /// Refresh transactions
  Future<void> refreshTransactions() async {
    await fetchTransactions(refresh: true);
  }

  @override
  void onInit() {
    super.onInit();
    fetchTransactions();
  }
}
