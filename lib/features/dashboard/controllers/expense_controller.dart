import 'package:get/get.dart';

class ExpenseController extends GetxController{
  var selectedMonth = 'This Month'.obs;

  final List<String> months = [
    'This Month',
    'Last Month',
    'Last 3 Months',
    'Last 6 Months',
    'This Year',
  ];

  void changeMonth(String value) {
    selectedMonth.value = value;
  }
}