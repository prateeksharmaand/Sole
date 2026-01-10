import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/repositories/expense_repository.dart';
import '../../../data/repositories/clients_repository.dart';
import '../../../data/repositories/suppliers_repository.dart';
import '../../../data/models/expense_model.dart';
import '../../../data/models/client_model.dart';
import '../../../data/models/supplier_model.dart';

class ExpenseController extends GetxController {
  final ExpenseRepository _expenseRepository = ExpenseRepository();
  final ClientsRepository _clientsRepository = ClientsRepository();
  final SuppliersRepository _suppliersRepository = SuppliersRepository();

  // Expense list
  final RxList<ExpenseModel> expenses = <ExpenseModel>[].obs;

  // Clients and Suppliers for filter
  final RxList<ClientDetails> clients = <ClientDetails>[].obs;
  final RxList<SupplierDetails> suppliers = <SupplierDetails>[].obs;
  final RxBool isLoadingClients = false.obs;
  final RxBool isLoadingSuppliers = false.obs;

  // Loading states
  final RxBool isLoading = false.obs;
  final RxBool isLoadingMore = false.obs;
  final RxBool isRefreshing = false.obs;

  // Pagination
  final RxInt currentPage = 1.obs;
  final RxBool hasMorePages = true.obs;
  final RxInt totalExpenses = 0.obs;
  final RxDouble maxPrice = 0.0.obs;

  // Search and filter
  final RxString searchQuery = ''.obs;

  // Month filter
  var selectedMonth = 'This Month'.obs;

  final List<String> months = [
    'This Month',
    'Last Month',
    'Last 3 Months',
    'Last 6 Months',
    'This Year',
  ];

  // Price range filter
  RxDouble minPrice = 0.0.obs;
  RxDouble maxPriceFilter = 0.0.obs;

  // Filter selections
  RxBool paidByCash = false.obs;
  Rx<int?> selectedClientId = Rx<int?>(null);
  Rx<int?> selectedSupplierId = Rx<int?>(null);
  RxString selectedCategory = ''.obs;

  // Scroll controller for pagination
  late ScrollController scrollController;

  @override
  void onInit() {
    super.onInit();
    scrollController = ScrollController();
    scrollController.addListener(_scrollListener);
    loadExpenses();
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  /// Scroll listener for pagination
  void _scrollListener() {
    if (scrollController.position.pixels >=
            scrollController.position.maxScrollExtent * 0.8 &&
        !isLoadingMore.value &&
        hasMorePages.value) {
      loadMoreExpenses();
    }
  }

  /// Load expenses (initial load with loading state)
  Future<void> loadExpenses() async {
    if (isLoading.value) return;

    isLoading.value = true;
    currentPage.value = 1;
    hasMorePages.value = true;

    try {
      final response = await _expenseRepository.getExpenses(
        page: currentPage.value,
        pageSize: 10,
        filterName: searchQuery.value.isNotEmpty ? searchQuery.value : null,
        sortBy: 'date_of_purchase',
        sortOrder: 'desc',
      );

      if (response.success && response.data != null) {
        expenses.value = response.data!.expenseDetails;
        totalExpenses.value = response.data!.total;
        maxPrice.value = response.data!.maxPrice.toDouble();

        // Initialize maxPriceFilter if it's 0 or exceeds the new maxPrice
        if (maxPriceFilter.value == 0 ||
            maxPriceFilter.value > maxPrice.value) {
          maxPriceFilter.value = maxPrice.value > 0 ? maxPrice.value : 1000.0;
        }

        // Update pagination state
        hasMorePages.value = response.data!.nextPage != -1;

        print('✅ Loaded ${expenses.length} expenses');
      } else {
        expenses.clear();
        print('❌ Failed to load expenses: ${response.message}');
      }
    } catch (e) {
      print('⚠️ Error loading expenses: $e');
      expenses.clear();
    } finally {
      isLoading.value = false;
    }
  }

  /// Load more expenses (pagination)
  Future<void> loadMoreExpenses() async {
    if (isLoadingMore.value || !hasMorePages.value) return;

    isLoadingMore.value = true;
    currentPage.value++;

    try {
      final response = await _expenseRepository.getExpenses(
        page: currentPage.value,
        pageSize: 10,
        filterName: searchQuery.value.isNotEmpty ? searchQuery.value : null,
        sortBy: 'date_of_purchase',
        sortOrder: 'desc',
      );

      if (response.success && response.data != null) {
        expenses.addAll(response.data!.expenseDetails);

        // Update pagination state
        hasMorePages.value = response.data!.nextPage != -1;

        print('✅ Loaded more expenses. Total: ${expenses.length}');
      } else {
        currentPage.value--; // Revert page increment on failure
        print('❌ Failed to load more expenses: ${response.message}');
      }
    } catch (e) {
      currentPage.value--; // Revert page increment on error
      print('⚠️ Error loading more expenses: $e');
    } finally {
      isLoadingMore.value = false;
    }
  }

  /// Refresh expenses (pull to refresh)
  Future<void> refreshExpenses() async {
    isRefreshing.value = true;
    currentPage.value = 1;
    hasMorePages.value = true;

    try {
      final response = await _expenseRepository.getExpenses(
        page: currentPage.value,
        pageSize: 10,
        filterName: searchQuery.value.isNotEmpty ? searchQuery.value : null,
        sortBy: 'date_of_purchase',
        sortOrder: 'desc',
      );

      if (response.success && response.data != null) {
        expenses.value = response.data!.expenseDetails;
        totalExpenses.value = response.data!.total;
        maxPrice.value = response.data!.maxPrice.toDouble();

        // Update maxPriceFilter if it exceeds the new maxPrice
        if (maxPriceFilter.value > maxPrice.value) {
          maxPriceFilter.value = maxPrice.value > 0 ? maxPrice.value : 1000.0;
        }

        // Update pagination state
        hasMorePages.value = response.data!.nextPage != -1;

        print('✅ Refreshed expenses');
      }
    } catch (e) {
      print('⚠️ Error refreshing expenses: $e');
    } finally {
      isRefreshing.value = false;
    }
  }

  /// Search expenses by name
  void searchExpenses(String query) {
    searchQuery.value = query;
    loadExpenses(); // Reload with new search query
  }

  /// Change month filter
  void changeMonth(String value) {
    selectedMonth.value = value;
    // TODO: Implement month-based filtering if API supports date range
    loadExpenses();
  }

  /// Load clients for filter dropdown
  Future<void> loadClients() async {
    if (isLoadingClients.value) return;

    isLoadingClients.value = true;

    try {
      final response = await _clientsRepository.getClients(
        page: 1,
        pageSize: 100, // Load all clients for dropdown
      );

      if (response.success && response.data != null) {
        clients.value = response.data!.clientsDetails;
        print('✅ Loaded ${clients.length} clients for filter');
      } else {
        print('❌ Failed to load clients: ${response.message}');
      }
    } catch (e) {
      print('⚠️ Error loading clients: $e');
    } finally {
      isLoadingClients.value = false;
    }
  }

  /// Load suppliers for filter dropdown
  Future<void> loadSuppliers() async {
    if (isLoadingSuppliers.value) return;

    isLoadingSuppliers.value = true;

    try {
      final response = await _suppliersRepository.getSuppliers(
        page: 1,
        pageSize: 100, // Load all suppliers for dropdown
      );

      if (response.success && response.data != null) {
        suppliers.value = response.data!.suppliersDetails;
        print('✅ Loaded ${suppliers.length} suppliers for filter');
      } else {
        print('❌ Failed to load suppliers: ${response.message}');
      }
    } catch (e) {
      print('⚠️ Error loading suppliers: $e');
    } finally {
      isLoadingSuppliers.value = false;
    }
  }

  /// Reset all filters
  void resetFilter() {
    selectedMonth.value = 'This Month';
    minPrice.value = 0;
    maxPriceFilter.value = maxPrice.value > 0 ? maxPrice.value : 1000;
    paidByCash.value = false;
    selectedClientId.value = null;
    selectedSupplierId.value = null;
    selectedCategory.value = '';
    searchQuery.value = '';
    loadExpenses();
  }

  /// Apply filters
  void applyFilter() {
    // Reload with current filter settings
    loadExpenses();
    Get.back(); // Close filter bottom sheet
  }
}
