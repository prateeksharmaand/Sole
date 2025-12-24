import 'package:get/get.dart';

class TransactionsController extends GetxController {
  static TransactionsController get instance => Get.find();

  // Selected Bank Account Index
  final RxInt selectedAccountIndex = 0.obs;

  // Search query
  final RxString searchQuery = ''.obs;

  // Matched/Unmatched Toggle
  final RxString selectedTab = 'Unmatched'.obs; // 'Unmatched' or 'Matched'

  // Mock Bank Accounts Data
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

  // Mock Transactions Data
  final RxList<Map<String, dynamic>> unmatchedTransactions =
      <Map<String, dynamic>>[
        {
          'title': 'Transfer to Thomas\'s NetBank',
          'id': '#1030319',
          'date': '15 Dec, 2025',
          'amount': 2527.19,
          'type': 'Credit',
        },
        {
          'title': 'Transfer to Thomas\'s NetBank',
          'id': '#1030319',
          'date': '15 Dec, 2025',
          'amount': -2527.19,
          'type': 'Debit',
        },
        {
          'title': 'Transfer to Thomas\'s NetBank',
          'id': '#1030319',
          'date': '15 Dec, 2025',
          'amount': 2527.19,
          'type': 'Credit',
        },
        {
          'title': 'Transfer to Thomas\'s NetBank',
          'id': '#1030319',
          'date': '15 Dec, 2025',
          'amount': -2527.19,
          'type': 'Debit',
        },
      ].obs;

  final RxList<Map<String, dynamic>> matchedTransactions =
      <Map<String, dynamic>>[
        {
          'title': 'Invoice paid in cash',
          'id': '#1032137',
          'date': '15 Dec, 2025',
          'amount': 11.00,
          'type': 'Credit',
          'category': 'Sales...',
        },
        {
          'title': 'Invoice paid in cash',
          'id': '#1032137',
          'date': '15 Dec, 2025',
          'amount': -11.00,
          'type': 'Debit',
          'category': 'Sales...',
        },
      ].obs;

  void changeTab(String tab) {
    selectedTab.value = tab;
  }

  void updateSearch(String query) {
    searchQuery.value = query;
  }

  void selectAccount(int index) {
    selectedAccountIndex.value = index;
  }
}
