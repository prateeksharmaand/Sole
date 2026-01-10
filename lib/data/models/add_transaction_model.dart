/// Add Transaction Request/Response models
class AddTransactionResponse {
  final bool success;
  final String message;
  final AddTransactionData? data;

  AddTransactionResponse({
    required this.success,
    required this.message,
    this.data,
  });

  factory AddTransactionResponse.fromJson(Map<String, dynamic> json) {
    return AddTransactionResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null
          ? AddTransactionData.fromJson(json['data'])
          : null,
    );
  }
}

class AddTransactionData {
  final Transaction transaction;

  AddTransactionData({required this.transaction});

  factory AddTransactionData.fromJson(Map<String, dynamic> json) {
    return AddTransactionData(
      transaction: Transaction.fromJson(json['transaction']),
    );
  }
}

class Transaction {
  final int id;
  final int userId;
  final int? contactId;
  final String source;
  final int? sourceId;
  final String? transactionId;
  final String transactionDate;
  final int? bankAccountId;
  final String description;
  final String? reference;
  final String amount;
  final String direction;
  final int? accountSubcategoryId;
  final int? bankTransactionId;
  final int isManual;
  final String createdAt;
  final String updatedAt;
  final String? deletedAt;

  Transaction({
    required this.id,
    required this.userId,
    this.contactId,
    required this.source,
    this.sourceId,
    this.transactionId,
    required this.transactionDate,
    this.bankAccountId,
    required this.description,
    this.reference,
    required this.amount,
    required this.direction,
    this.accountSubcategoryId,
    this.bankTransactionId,
    required this.isManual,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'] ?? 0,
      userId: json['user_id'] ?? 0,
      contactId: json['contact_id'],
      source: json['source'] ?? '',
      sourceId: json['source_id'],
      transactionId: json['transaction_id'],
      transactionDate: json['transaction_date'] ?? '',
      bankAccountId: json['bank_account_id'],
      description: json['description'] ?? '',
      reference: json['reference'],
      amount: json['amount']?.toString() ?? '0',
      direction: json['direction'] ?? '',
      accountSubcategoryId: json['account_subcategory_id'],
      bankTransactionId: json['bank_transaction_id'],
      isManual: json['is_manual'] ?? 1,
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      deletedAt: json['deleted_at'],
    );
  }
}
