import 'package:get/get.dart';
import 'models/quote_model.dart';

class QuotesController extends GetxController {
  static QuotesController get instance => Get.find();

  final RxList<QuoteModel> quotes = <QuoteModel>[].obs;
  final RxString searchText = ''.obs;
  final RxString selectedTimeRange = 'This Month'.obs;

  // Summary statistics
  final RxString totalQuotesAmount = '104.50'.obs;
  final RxString vsLastMonth = '+2.5%'.obs;
  final RxString convertedAmount = '512.00'.obs;
  final RxString pendingAmount = '512.00'.obs;
  final RxString overdueAmount = '512.00'.obs;

  @override
  void onInit() {
    super.onInit();
    loadSampleQuotes();
  }

  void loadSampleQuotes() {
    quotes.assignAll([
      QuoteModel(
        id: '1',
        customerName: 'John Doe',
        quoteId: 'Hey-0086',
        date: '05-07-2025',
        amount: 1250.00,
        status: QuoteStatus.sent,
      ),
      QuoteModel(
        id: '2',
        customerName: 'Sarah Johnson',
        quoteId: 'Hey-0086',
        date: '05-07-2025',
        amount: 55.00,
        status: QuoteStatus.sent,
      ),
      QuoteModel(
        id: '3',
        customerName: 'Bright Studio',
        quoteId: 'Hey-0086',
        date: '05-07-2025',
        amount: 55.00,
        status: QuoteStatus.draft,
      ),
      QuoteModel(
        id: '4',
        customerName: 'Emma Brown',
        quoteId: 'Hey-0086',
        date: '05-07-2025',
        amount: 55.00,
        status: QuoteStatus.draft,
      ),
      QuoteModel(
        id: '5',
        customerName: 'John Doe',
        quoteId: 'Hey-0086',
        date: '05-07-2025',
        amount: 55.00,
        status: QuoteStatus.sent,
      ),
      QuoteModel(
        id: '6',
        customerName: 'John Doe',
        quoteId: 'Hey-0086',
        date: '05-07-2025',
        amount: 55.00,
        status: QuoteStatus.sent,
      ),
    ]);
  }

  void filterQuotes(String query) {
    searchText.value = query;
    // Logic to filter list if needed
  }
}
