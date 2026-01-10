import 'package:flutter_dotenv/flutter_dotenv.dart';

class UApiUrls {
  static String get baseUrl => dotenv.env['BASE_URL'] ?? '';

  static String uploadApi(String cloudName) =>
      'https://api.cloudinary.com/v1_1/$cloudName/image/upload';

  static String deleteApi(String cloudName) =>
      'https://api.cloudinary.com/v1_1/$cloudName/image/destroy';

  static String stripeCreateIntents =
      'https://api.stripe.com/v1/payment_intents';

  // API v2 Endpoints
  static const String clients = '/api/v2/clients';
  static const String suppliers = '/api/v2/suppliers';
  static const String dashboard = '/api/v2/dashboard';
  static const String login = '/api/v2/user/login';
  static const String signup = '/api/v2/user/signup';
  static const String getProfile = '/api/v1/user/getProfile';
  static const String saveBranding = '/api/v2/settings/save-branding';
  static const String getBranding = '/api/v2/settings/get-branding';

  // Asset Endpoints
  static const String assets = '/api/v2/assets';
  static const String asset = '/api/v2/asset';
  static const String assetEdit = '/api/v1/asset/edit';

  // Expense Endpoints
  static const String expenses = '/api/v2/expenses';
  static const String expense = '/api/v2/expense';
  static const String expenseEdit = '/api/v2/expense/edit';

  // Transaction Endpoints
  static const String addTransaction = '/api/v2/bank/add-transaction';
  static const String bankTransactions = '/api/v2/bank/bank-transactions';
  static const String soleSavedTransactions =
      '/api/v2/bank/sole-saved-transactions';
  static const String bulkTransactionsUpload =
      '/api/v2/bulk-transactions/upload-file';

  // Auth Endpoints
  static const String logout = '/auth/logout';
  static const String authProfile = '/auth/profile';
  static const String deviceRegister = '/api/v1/device/register';
  static const String accountActivate = '/api/v1/user/account/activate';
}
