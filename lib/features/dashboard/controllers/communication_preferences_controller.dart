import 'package:get/get.dart';

class CommunicationPreferencesController extends GetxController {
  RxBool invoice = true.obs;
  RxBool quote = true.obs;
  RxBool invoiceDueReminder = true.obs;
  RxBool invoiceOverdueReminder = true.obs;
  RxBool quoteExpiryReminder = true.obs;

  void toggleInvoice(bool value) => invoice.value = value;
  void toggleQuote(bool value) => quote.value = value;
  void toggleInvoiceDue(bool value) => invoiceDueReminder.value = value;
  void toggleInvoiceOverdue(bool value) => invoiceOverdueReminder.value = value;
  void toggleQuoteExpiry(bool value) => quoteExpiryReminder.value = value;
}
