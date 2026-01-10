import 'package:get/get.dart';
import '../../../data/models/expense_model.dart';
import '../../../data/repositories/expense_repository.dart';

class ExpenseDetailsController extends GetxController {
  final ExpenseRepository _expenseRepository = ExpenseRepository();

  // Observable fields
  Rx<ExpenseModel?> expense = Rx<ExpenseModel?>(null);
  RxBool isLoading = false.obs;

  /// Load expense details by ID
  Future<void> loadExpenseDetails(int expenseId) async {
    isLoading.value = true;

    try {
      final response = await _expenseRepository.getExpenseById(expenseId);

      if (response.success && response.data != null) {
        expense.value = response.data;
        print('✅ Loaded expense details: ${expense.value?.name}');
      } else {
        print('❌ Failed to load expense: ${response.message}');
      }
    } catch (e) {
      print('⚠️ Error loading expense: $e');
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();

    // Get expense ID from route arguments
    final expenseId = Get.arguments as int?;
    if (expenseId != null) {
      loadExpenseDetails(expenseId);
    }
  }
}
