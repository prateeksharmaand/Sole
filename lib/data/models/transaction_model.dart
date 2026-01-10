/// Transaction data models for sole-saved-transactions API
class SoleTransactionResponse {
  final List<SoleTransactionDetail> soleTransactionDetails;
  final int nextPage;
  final int total;
  final int totalPages;
  final String maxPrice;

  SoleTransactionResponse({
    required this.soleTransactionDetails,
    required this.nextPage,
    required this.total,
    required this.totalPages,
    required this.maxPrice,
  });

  factory SoleTransactionResponse.fromJson(Map<String, dynamic> json) {
    return SoleTransactionResponse(
      soleTransactionDetails:
          (json['sole_transaction_details'] as List?)
              ?.map(
                (e) =>
                    SoleTransactionDetail.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          [],
      nextPage: json['next_page'] ?? -1,
      total: json['total'] ?? 0,
      totalPages: json['total_pages'] ?? 0,
      maxPrice: json['max_price'] ?? '0.00',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sole_transaction_details': soleTransactionDetails
          .map((e) => e.toJson())
          .toList(),
      'next_page': nextPage,
      'total': total,
      'total_pages': totalPages,
      'max_price': maxPrice,
    };
  }
}

class SoleTransactionDetail {
  final int id;
  final String transactionDate;
  final String amount;
  final String direction; // 'debit' or 'credit'
  final String description;
  final bool autoMatch;
  final List<TransactionDataEntry> data;

  SoleTransactionDetail({
    required this.id,
    required this.transactionDate,
    required this.amount,
    required this.direction,
    required this.description,
    required this.autoMatch,
    required this.data,
  });

  factory SoleTransactionDetail.fromJson(Map<String, dynamic> json) {
    return SoleTransactionDetail(
      id: json['id'] ?? 0,
      transactionDate: json['transaction_date'] ?? '',
      amount: json['amount'] ?? '0.00',
      direction: json['direction'] ?? 'debit',
      description: json['description'] ?? '',
      autoMatch: json['auto_match'] ?? false,
      data:
          (json['data'] as List?)
              ?.map(
                (e) => TransactionDataEntry.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'transaction_date': transactionDate,
      'amount': amount,
      'direction': direction,
      'description': description,
      'auto_match': autoMatch,
      'data': data.map((e) => e.toJson()).toList(),
    };
  }

  /// Helper getter to determine if this is a credit or debit
  bool get isCredit => direction.toLowerCase() == 'credit';

  /// Helper getter to get amount as double
  double get amountValue => double.tryParse(amount) ?? 0.0;
}

class TransactionDataEntry {
  final int entryId;
  final String itemCode;
  final String amount;
  final int accountSubcategoryId;
  final String name;
  final String referenceType;
  final int clientId;
  final String clientName;

  TransactionDataEntry({
    required this.entryId,
    required this.itemCode,
    required this.amount,
    required this.accountSubcategoryId,
    required this.name,
    required this.referenceType,
    required this.clientId,
    required this.clientName,
  });

  factory TransactionDataEntry.fromJson(Map<String, dynamic> json) {
    return TransactionDataEntry(
      entryId: json['entry_id'] ?? 0,
      itemCode: json['item_code'] ?? '',
      amount: json['amount'] ?? '0.00',
      accountSubcategoryId: json['account_subcategory_id'] ?? 0,
      name: json['name'] ?? '',
      referenceType: json['reference_type'] ?? '',
      clientId: json['client_id'] ?? 0,
      clientName: json['client_name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'entry_id': entryId,
      'item_code': itemCode,
      'amount': amount,
      'account_subcategory_id': accountSubcategoryId,
      'name': name,
      'reference_type': referenceType,
      'client_id': clientId,
      'client_name': clientName,
    };
  }

  /// Helper getter to get amount as double
  double get amountValue => double.tryParse(amount) ?? 0.0;
}
