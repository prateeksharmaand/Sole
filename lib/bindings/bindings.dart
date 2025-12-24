import 'package:get/get.dart';
import 'package:sole/features/authentication/controller/auth_controller.dart';
import 'package:sole/features/authentication/controller/onboarding_controller.dart';
import 'package:sole/features/dashboard/controllers/assets_controller.dart';
import '../features/dashboard/controllers/add_expenses_controller.dart';
import '../features/dashboard/controllers/balance_sheet_controller.dart';
import '../features/dashboard/controllers/communication_preferences_controller.dart';
import '../features/dashboard/controllers/expense_controller.dart';
import '../features/dashboard/controllers/notification_controller.dart';
import '../features/dashboard/controllers/reports_controller.dart';
import 'package:sole/features/dashboard/pages/dashboard/dashboard_controller.dart';
import 'package:sole/features/dashboard/pages/transactions/transactions_controller.dart';

class UBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController());
    Get.lazyPut<OnboardingController>(() => OnboardingController());
    Get.lazyPut<CommunicationPreferencesController>(
      () => CommunicationPreferencesController(),
      fenix: true,
    );
    Get.lazyPut<ReportsController>(() => ReportsController(), fenix: true);
    Get.lazyPut<AssetsController>(() => AssetsController(), fenix: true);
    Get.lazyPut<BalanceSheetController>(
      () => BalanceSheetController(),
      fenix: true,
    );
    Get.lazyPut<ExpenseController>(() => ExpenseController(), fenix: true);
    Get.lazyPut<AddExpensesController>(
      () => AddExpensesController(),
      fenix: true,
    );
    Get.lazyPut<NotificationController>(
      () => NotificationController(),
      fenix: true,
    );

    Get.put(AuthController());
    Get.put(OnboardingController());
    Get.put(DashboardController());
    Get.put(AuthController());
    Get.put(OnboardingController());
    Get.put(DashboardController());
    Get.put(TransactionsController());
  }
}
