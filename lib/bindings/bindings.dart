import 'package:get/get.dart';
import 'package:sole/features/authentication/controller/auth_controller.dart';
import 'package:sole/features/authentication/controller/onboarding_controller.dart';
import 'package:sole/features/dashboard/controllers/assets_controller.dart';
import '../features/dashboard/controllers/add_expenses_controller.dart';
import '../features/dashboard/controllers/audit_trail_controller.dart';
import '../features/dashboard/controllers/balance_sheet_controller.dart';
import '../features/dashboard/controllers/cash_flow_controller.dart';
import '../features/dashboard/controllers/chart_of_account_controller.dart';
import '../features/dashboard/controllers/communication_preferences_controller.dart';
import '../features/dashboard/controllers/expense_controller.dart';
import '../features/dashboard/controllers/notification_controller.dart';
import '../features/dashboard/controllers/reports_controller.dart';
import 'package:sole/features/dashboard/pages/transactions/transactions_controller.dart';
import '../features/dashboard/pages/bas_reports/bas_reports_screen.dart';
import '../features/dashboard/pages/customers_suppliers/customers_screen.dart';
import '../features/dashboard/controllers/profile_branding_controller.dart';
import '../features/dashboard/pages/transaction_listing/transaction_listing_screen.dart';
import '../features/dashboard/pages/trial_balance/trial_balance_screen.dart';

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
    Get.lazyPut<AuditTrailController>(
      () => AuditTrailController(),
      fenix: true,
    );
    Get.lazyPut<CashFlowController>(() => CashFlowController(), fenix: true);
    Get.lazyPut<ChartOfAccountController>(
      () => ChartOfAccountController(),
      fenix: true,
    );
    Get.lazyPut<CustomersSuppliersController>(
      () => CustomersSuppliersController(),
      fenix: true,
    );
    Get.lazyPut<BasReportsController>(
      () => BasReportsController(),
      fenix: true,
    );
    Get.lazyPut<TransactionListingController>(
      () => TransactionListingController(),
      fenix: true,
    );
    Get.lazyPut<ProfileAndBrandingController>(
      () => ProfileAndBrandingController(),
      fenix: true,
    );
    Get.lazyPut<TrialBalanceController>(
      () => TrialBalanceController(),
      fenix: true,
    );

    Get.put(AuthController());
    Get.put(OnboardingController());
    Get.lazyPut<TransactionsController>(
      () => TransactionsController(),
      fenix: true,
    );
  }
}
