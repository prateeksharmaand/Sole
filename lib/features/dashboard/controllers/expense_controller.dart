import 'package:get/get.dart';

// class ExpenseController extends GetxController{
//   var selectedMonth = 'This Month'.obs;
//
//   final List<String> months = [
//     'This Month',
//     'Last Month',
//     'Last 3 Months',
//     'Last 6 Months',
//     'This Year',
//   ];
//
//   void changeMonth(String value) {
//     selectedMonth.value = value;
//   }
// }

class ExpenseController extends GetxController {
  // Month filter
  var selectedMonth = 'This Month'.obs;

  final List<String> months = [
    'This Month',
    'Last Month',
    'Last 3 Months',
    'Last 6 Months',
    'This Year',
  ];

  // Price range
  RxDouble minPrice = 0.0.obs;
  RxDouble maxPrice = 1000.0.obs;

  // Toggle
  RxBool paidByCash = false.obs;

  void changeMonth(String value) {
    selectedMonth.value = value;
  }

  void resetFilter() {
    selectedMonth.value = 'This Month';
    minPrice.value = 0;
    maxPrice.value = 1000;
    paidByCash.value = false;
  }
}
