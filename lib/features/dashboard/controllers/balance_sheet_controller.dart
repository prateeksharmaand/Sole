import 'package:get/get.dart';

import '../pages/balance_sheet/balance_sheet_screen.dart';

class BalanceSheetController extends GetxController{
  /// expand/collapse
  final assetsOpen = false.obs;
  final liabilitiesOpen = false.obs;

  /// dummy data (API se bhi laa sakte ho)
  final assets = [
    const BalanceItem(title: "Cash", amount: "-\$795.00"),
    const BalanceItem(title: "GST Receivable", amount: "\$42.00"),
    const BalanceItem(title: "Accounts Receivable", amount: "\$426.00"),
  ];

  final liabilities = [
    const BalanceItem(title: "GST Payable", amount: "-\$65.30"),
  ];

  String get totalAssets => "-\$327.00";
  String get totalLiabilities => "-\$65.30";

  final years = [
    "2022–2023",
    "2023–2024",
    "2024–2025",
    "2025–2026",
  ];

  final selectedYear = "2025–2026".obs;

  void changeYear(String value) {
    selectedYear.value = value;
  }
}