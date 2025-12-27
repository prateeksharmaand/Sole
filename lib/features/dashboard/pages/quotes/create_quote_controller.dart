import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuoteItem {
  final String title;
  final int quantity;
  final double price;

  QuoteItem({required this.title, required this.quantity, required this.price});

  double get total => quantity * price;
}

class CreateQuoteController extends GetxController {
  static CreateQuoteController get instance => Get.find();

  // Form Fields
  final selectedClient = 'Sarah Emily'.obs;
  final quoteNumber = 'QUO-000134'.obs;
  final quoteDate = '12 Sep 2025'.obs;
  final quoteExpiryDate = '26 Sep 2025'.obs;
  final projectCode = 'PRJ-2025-09-001'.obs;
  final jobCode = 'JOB-3421'.obs;

  // Items
  final items = <QuoteItem>[
    QuoteItem(title: 'Website Design Package', quantity: 1, price: 1500),
    QuoteItem(title: 'Monthly Hosting', quantity: 1, price: 50),
  ].obs;

  // Switches
  final showQuoteNotes = true.obs;
  final showCustomNote = true.obs;

  // TextEditingControllers for editable fields
  final quoteNotesController = TextEditingController(
    text: 'This quote is valid for 14 days. Please confirm to proceed.',
  );
  final customNoteController = TextEditingController(
    text: 'Preferred payment: Bank Transfer or Stripe.',
  );

  @override
  void onInit() {
    super.onInit();
  }

  // Calculations
  double get subtotal => items.fold(0, (sum, item) => sum + item.total);
  double get discount => 0.0;
  double get gst => 0.0;
  double get total => subtotal - discount + gst;

  Future<void> selectDate(BuildContext context, RxString dateObs) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      dateObs.value = "${picked.day} ${_getMonth(picked.month)} ${picked.year}";
    }
  }

  String _getMonth(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return months[month - 1];
  }

  void addItem() {
    items.add(QuoteItem(title: 'New Service', quantity: 1, price: 100));
  }

  void removeItem(int index) {
    items.removeAt(index);
  }

  void saveAsDraft() {
    Get.back();
  }

  void saveAndSend() {
    Get.back();
  }

  @override
  void onClose() {
    quoteNotesController.dispose();
    customNoteController.dispose();
    super.onClose();
  }
}
