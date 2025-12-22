import 'package:get/get.dart';

class DashboardController extends GetxController {
  static DashboardController get instance => Get.find();

  // UI state
  final RxBool isFirstTimeOpen = true.obs; // show onboarding first time
  final RxBool isFabOpen = false.obs; // floating action menu state

  // Observable variables for UI updates
  final RxString selectedTimeRange = 'MTD'.obs;
  final RxDouble currentBalance = 10000.00.obs;

  // Stats Data
  final RxDouble totalRevenue = 10000.00.obs;
  final RxDouble netProfit = 0.00.obs;
  final RxDouble profitMargin = 0.00.obs;
  final RxDouble totalExpense = 0.00.obs;
  final RxDouble forecast = 0.00.obs;
  final RxDouble totalTax = 0.00.obs;

  // Transaction Tabs
  final RxString selectedTransactionTab =
      'Income'.obs; // 'Income' or 'Expenses'

  // Mock Transactions Data
  final RxList<Map<String, dynamic>> incomeTransactions =
      <Map<String, dynamic>>[
        {
          'title': 'Social Media Kit',
          'date': '11/08/2025',
          'time': '09:24 AM',
          'amount': 384.0,
          'icon': 'arrow_down_left',
        },
        {
          'title': 'Project Logo Design',
          'date': '11/08/2025',
          'time': '09:24 AM',
          'amount': 1200.0,
          'icon': 'arrow_down_left',
        },
      ].obs;

  final RxList<Map<String, dynamic>> expenseTransactions =
      <Map<String, dynamic>>[
        {
          'title': 'Internet & Utilities',
          'date': '2 days ago',
          'time': '09:24 AM',
          'amount': -384.0,
          'icon': 'arrow_up_right',
        },
      ].obs;

  // Invoice Stats
  final RxDouble unpaidAmount = 2500.00.obs;
  final RxDouble paidAmount = 2500.00.obs;
  final RxInt daysRemainingBAS = 12.obs;

  // Money Goal
  final RxDouble moneyGoalCurrent = 3402.00.obs;
  final RxDouble moneyGoalTarget = 5000.00.obs;
  final RxDouble moneyGoalPercentage = 67.0.obs;

  void changeTimeRange(String? newValue) {
    if (newValue != null) {
      selectedTimeRange.value = newValue;
    }
  }

  void changeTransactionTab(String tab) {
    selectedTransactionTab.value = tab;
  }

  void toggleFab() {
    isFabOpen.value = !isFabOpen.value;
  }
}
