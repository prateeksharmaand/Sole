import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddExpensesController extends GetxController {
  /// Checkbox
  RxBool isPaidWithCash = false.obs;

  /// Switch
  RxBool isGstIncluded = false.obs;

  /// Report
  var selectedReport = RxnString();

  /// Date
  Rx<DateTime?> selectedDate = Rx<DateTime?>(null);

  String get formattedDate {
    if (selectedDate.value == null) return '';
    return DateFormat('dd MMM yyyy').format(selectedDate.value!);
  }

  final List<String> reports = [
    "Balance Sheet",
    "Transaction Listing",
    "GST Extract",
    "Profit & Loss",
  ];
}
