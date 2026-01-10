import 'package:get/get.dart';
import '../../../../data/repositories/dashboard_repository.dart';
import '../../../../data/models/dashboard_model.dart';

class DashboardController extends GetxController {
  static DashboardController get instance => Get.find();

  final DashboardRepository _dashboardRepository = DashboardRepository();

  // API Data
  final Rx<DashboardData?> dashboardData = Rx<DashboardData?>(null);
  final RxBool isLoadingDashboard = false.obs;

  // UI state
  final RxBool isFirstTimeOpen = false.obs; // show onboarding first time
  final RxBool isFabOpen = false.obs; // floating action menu state

  // Observable variables for UI updates
  final RxString selectedTimeRange = 'MTD'.obs;
  final RxDouble currentBalance = 100000.00.obs;

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
  final RxDouble draftAmount = 0.00.obs;
  final RxDouble overdueAmount = 0.00.obs;
  final RxInt reconcilePending = 0.obs;
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

  /// Fetch dashboard data from API
  Future<void> fetchDashboardData() async {
    isLoadingDashboard.value = true;

    try {
      final response = await _dashboardRepository.getDashboardData();

      if (response.success && response.data != null) {
        dashboardData.value = response.data;

        // Update Invoice Total observables
        paidAmount.value = response.data!.invoiceTotal.paidAmount.toDouble();
        unpaidAmount.value = response.data!.invoiceTotal.dueAmount.toDouble();
        draftAmount.value = response.data!.invoiceTotal.draftAmount.toDouble();
        overdueAmount.value = response.data!.invoiceTotal.overdueAmount
            .toDouble();

        // Update Balance and Assets
        currentBalance.value = response.data!.bankBalance.toDouble();
        totalExpense.value = response.data!.assetsTotal.toDouble();
        reconcilePending.value = response.data!.reconcilePending.toInt();

        // Update Tax information
        totalTax.value = response.data!.estimatedTax.toDouble();

        // Note: The following fields are available in the API but need UI implementation:
        // - response.data!.bankAccounts
        // - response.data!.snapshot
        // - response.data!.appUpdate
        // - response.data!.estimatedTaxCalcDate

        print('Dashboard data loaded successfully');
        print('Paid Amount: ${paidAmount.value}');
        print('Due Amount: ${unpaidAmount.value}');
        print('Bank Balance: ${currentBalance.value}');
        print('Assets Total: ${totalExpense.value}');
        print('Estimated Tax: ${totalTax.value}');
      } else {
        // Handle error
        Get.snackbar(
          'Error',
          response.message ?? 'Failed to load dashboard data',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      print('Error fetching dashboard data: $e');
      Get.snackbar(
        'Error',
        'An unexpected error occurred',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoadingDashboard.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    // Don't auto-fetch here - only fetch when user is authenticated
    // and navigates to dashboard. This prevents unauthorized API calls.
    // Call fetchDashboardData() manually when needed.
  }

  @override
  void onReady() {
    super.onReady();
    // Fetch data when controller is ready and user is on dashboard
    // This is called after the widget is built, so it's safe to fetch
    fetchDashboardData();
  }
}
