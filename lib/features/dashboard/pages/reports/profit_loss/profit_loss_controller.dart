import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfitLossController extends GetxController {
  final selectedYear = '2025-2026'.obs;
  final selectedMonth = 'Dec 2025'.obs;
  final hasData = true.obs; // Toggle this to test empty state

  // Mock data for UI
  final totalIncome = 1897.82.obs;
  final totalExpenses = 1102.00.obs;
  final netProfit = 795.82.obs;

  final incomeDetails = <Map<String, dynamic>>[
    {'title': 'Accounts Receivable', 'amount': 941.82, 'ytd': 941.82},
    {'title': 'Rounding Income', 'amount': 941.82, 'ytd': 941.82},
    {'title': 'Sales Revenue', 'amount': 941.82, 'ytd': 941.82},
  ].obs;

  final accountsReceivableBreakdown = <Map<String, dynamic>>[
    {'period': 'Jan 2025', 'amount': 1200.00},
    {'period': 'Feb 2025', 'amount': 1200.00},
    {'period': 'Mar 2025', 'amount': 2500.00},
    {'period': 'Apr 2025', 'amount': 3750.00},
    {'period': 'May 2025', 'amount': 4800.00},
    {'period': 'Jun 2025', 'amount': 6000.00},
    {'period': 'Jul 2025', 'amount': 7500.00},
    {'period': 'Aug 2025', 'amount': 8200.00},
    {'period': 'Sep 2025', 'amount': 9000.00},
    {'period': 'Oct 2025', 'amount': 10500.00},
    {'period': 'Nov 2025', 'amount': 12000.00},
    {'period': 'Dec 2025', 'amount': 15000.00},
  ].obs;

  // Send Report Screen Controller Variables
  final sendToController = TextEditingController();
  final accountantEmailController = TextEditingController();
  final bookkeeperEmailController = TextEditingController();

  final sendToAccountant = false.obs;
  final sendToBookkeeper = false.obs;

  final selectedAccountant = Rx<String?>(null);
  final selectedBookkeeper = Rx<String?>(null);

  void downloadReport() {
    // Implement download logic
    Get.snackbar('Download', 'Downloading Profit & Loss Report...');
  }

  void sendReport() {
    // Implement send logic
    Get.snackbar('Send', 'Sending Profit & Loss Report...');
  }

  @override
  void onClose() {
    sendToController.dispose();
    accountantEmailController.dispose();
    bookkeeperEmailController.dispose();
    super.onClose();
  }

  void submitSendReport() {
    Get.back(); // Close screen
    Get.snackbar(
      'Report sent successfully',
      'The report has been sent to the selected recipients.',
      backgroundColor: Colors.white,
      colorText: const Color(0xFF101828), // UColors.text1828
      icon: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFFE8FBF5),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(Icons.check_circle, color: Color(0xFF297F67)),
        ),
      ),
      margin: const EdgeInsets.all(16),
      snackPosition: SnackPosition.TOP,
      boxShadows: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 10,
          offset: const Offset(0, 4),
          spreadRadius: 2,
        ),
      ],
    );
  }
}
