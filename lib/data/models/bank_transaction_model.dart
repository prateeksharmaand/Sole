/// Bank transaction data models for bank-transactions API
class BankTransactionResponse {
  final bool success;
  final String message;
  final BankTransactionData? data;

  BankTransactionResponse({
    required this.success,
    required this.message,
    this.data,
  });

  factory BankTransactionResponse.fromJson(Map<String, dynamic> json) {
    return BankTransactionResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null
          ? BankTransactionData.fromJson(json['data'])
          : null,
    );
  }
}

class BankTransactionData {
  final int reconcilePending;
  final List<dynamic> matchUnmatch;
  final BankTransactions bankTransactions;

  BankTransactionData({
    required this.reconcilePending,
    required this.matchUnmatch,
    required this.bankTransactions,
  });

  factory BankTransactionData.fromJson(Map<String, dynamic> json) {
    return BankTransactionData(
      reconcilePending: json['reconcile_pending'] ?? 0,
      matchUnmatch: json['match_unmatch'] ?? [],
      bankTransactions: BankTransactions.fromJson(
        json['bank_transactions'] ?? {},
      ),
    );
  }
}

class BankTransactions {
  final List<BankTransactionDetail> bankTransactionDetails;
  final String maxPrice;
  final int nextPage;
  final int total;
  final int totalPages;

  BankTransactions({
    required this.bankTransactionDetails,
    required this.maxPrice,
    required this.nextPage,
    required this.total,
    required this.totalPages,
  });

  factory BankTransactions.fromJson(Map<String, dynamic> json) {
    return BankTransactions(
      bankTransactionDetails:
          (json['bank_transaction_details'] as List?)
              ?.map(
                (e) =>
                    BankTransactionDetail.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          [],
      maxPrice: json['max_price'] ?? '0.00',
      nextPage: json['next_page'] ?? -1,
      total: json['total'] ?? 0,
      totalPages: json['total_pages'] ?? 0,
    );
  }
}

class BankTransactionDetail {
  final String type;
  final int bankTransactonId;
  final int userId;
  final int transactionId;
  final String bankAccountId;
  final String bankName;
  final String source;
  final String amount;
  final String description;
  final String userDescription;
  final String direction;
  final String status;
  final String transactionDate;
  final num availableAmount;
  final int possibleMatch;
  final int possibleCashMatch;
  final int possibleMatchExpense;
  final int possibleCashMatchExpense;
  final int possibleMatchAsset;
  final int possibleCashMatchAsset;
  final dynamic gstExclude;
  final int isManual;
  final dynamic invoiceNo;
  final Map<String, dynamic> client;
  final List<dynamic> accountSubcategory;

  BankTransactionDetail({
    required this.type,
    required this.bankTransactonId,
    required this.userId,
    required this.transactionId,
    required this.bankAccountId,
    required this.bankName,
    required this.source,
    required this.amount,
    required this.description,
    required this.userDescription,
    required this.direction,
    required this.status,
    required this.transactionDate,
    required this.availableAmount,
    required this.possibleMatch,
    required this.possibleCashMatch,
    required this.possibleMatchExpense,
    required this.possibleCashMatchExpense,
    required this.possibleMatchAsset,
    required this.possibleCashMatchAsset,
    required this.gstExclude,
    required this.isManual,
    required this.invoiceNo,
    required this.client,
    required this.accountSubcategory,
  });

  factory BankTransactionDetail.fromJson(Map<String, dynamic> json) {
    return BankTransactionDetail(
      type: json['type'] ?? '',
      bankTransactonId: json['bank_transacton_id'] ?? 0,
      userId: json['user_id'] ?? 0,
      transactionId: json['transaction_id'] ?? 0,
      bankAccountId: json['bank_account_id'] ?? '',
      bankName: json['bank_name'] ?? '',
      source: json['source'] ?? '',
      amount: json['amount'] ?? '0.00',
      description: json['description'] ?? '',
      userDescription: json['user_description'] ?? '',
      direction: json['direction'] ?? '',
      status: json['status'] ?? '',
      transactionDate: json['transaction_date'] ?? '',
      availableAmount: json['available_amount'] ?? 0,
      possibleMatch: json['possible_match'] ?? 0,
      possibleCashMatch: json['possible_cash_match'] ?? 0,
      possibleMatchExpense: json['possible_match_expense'] ?? 0,
      possibleCashMatchExpense: json['possible_cash_match_expense'] ?? 0,
      possibleMatchAsset: json['possible_match_asset'] ?? 0,
      possibleCashMatchAsset: json['possible_cash_match_asset'] ?? 0,
      gstExclude: json['gst_exclude'],
      isManual: json['is_manual'] ?? 0,
      invoiceNo: json['invoice_no'],
      client: json['client'] ?? {},
      accountSubcategory: json['account_subcategory'] ?? [],
    );
  }

  /// Helper getter to determine if this is a credit or debit
  bool get isCredit => direction.toLowerCase() == 'credit';

  /// Helper getter to get amount as double
  double get amountValue => double.tryParse(amount) ?? 0.0;

  /// Helper to check if transaction has possible matches
  bool get hasPossibleMatches =>
      possibleMatch > 0 ||
      possibleCashMatch > 0 ||
      possibleMatchExpense > 0 ||
      possibleCashMatchExpense > 0 ||
      possibleMatchAsset > 0 ||
      possibleCashMatchAsset > 0;
}
