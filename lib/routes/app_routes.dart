import 'package:get/get.dart';
import 'package:sole/features/authentication/screens/onboarding/onboarding_screen.dart';
import 'package:sole/features/dashboard/pages/communication_preferences/communication_preferences_screen.dart';
import 'package:sole/loading.dart';
import 'package:sole/routes/routes.dart';
import '../features/dashboard/pages/add_expenses/add_expenses_screen.dart';
import '../features/dashboard/pages/add_expenses/details_expenses_screen.dart';
import '../features/dashboard/pages/assets/assets_screen.dart';
import '../features/dashboard/pages/assets/new_assets_screen.dart';
import '../features/dashboard/pages/balance_sheet/balance_sheet_screen.dart';
import '../features/dashboard/pages/invoice_quote_branding/invoice_quote_branding_screen.dart';
import '../features/dashboard/pages/notification/notification_screen.dart';
import '../features/dashboard/pages/quotes/quotes_screen.dart';
import '../features/dashboard/pages/quotes/create_quotes_screen.dart';
import '../features/dashboard/pages/reports/profit_loss/profit_loss_screen.dart';
import '../features/dashboard/pages/webview/webview_screen.dart';

class UAppRoutes {
  static final screens = [
    GetPage(name: URoutes.home, page: () => const LoadingScreen()),
    GetPage(name: URoutes.onBoarding, page: () => OnboardingScreen()),
    GetPage(
      name: URoutes.communicationScreen,
      page: () => CommunicationPreferencesScreen(),
    ),
    GetPage(name: URoutes.assetsScreen, page: () => AssetsScreen()),
    GetPage(name: URoutes.newAssetsScreen, page: () => NewAssetsScreen()),
    GetPage(name: URoutes.balanceSheetScreen, page: () => BalanceSheetScreen()),
    GetPage(name: URoutes.addExpensesScreen, page: () => AddExpensesScreen()),
    GetPage(
      name: URoutes.detailsExpensesScreen,
      page: () => DetailsExpensesScreen(),
    ),
    GetPage(name: URoutes.notificationScreen, page: () => NotificationScreen()),
    GetPage(
      name: URoutes.invoiceQuoteBrandingScreen,
      page: () => InvoiceQuoteBrandingScreen(),
    ),
    GetPage(name: URoutes.quotes, page: () => const QuotesScreen()),
    GetPage(name: URoutes.createQuote, page: () => const CreateQuotesScreen()),
    GetPage(name: URoutes.profitLoss, page: () => const ProfitLossScreen()),
    GetPage(name: URoutes.webview, page: () => const WebViewScreen()),
  ];
}
