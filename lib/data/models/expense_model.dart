/// Expense Model - Represents an expense entity
class ExpenseModel {
  final String type;
  final int expenseId;
  final int userId;
  final int? accountSubcategoryId;
  final int clientId;
  final String name;
  final int? bankTransactionId;
  final int gst;
  final num totalGst;
  final num subTotal;
  final num price;
  final String? image;
  final String imageType;
  final String date;
  final String description;
  final int paidWithCash;
  final int fromBankMatch;
  final int isReconciled;
  final List<ExpenseClassification> classifications;
  final String createdAt;
  final int possibleMatch;
  final int bulkUpload;
  final AccountSubcategory? accountSubcategory;
  final ExpenseClient client;
  final num remainingAmount;
  final int? creditNoteId;
  final String? creditNoteNo;

  ExpenseModel({
    required this.type,
    required this.expenseId,
    required this.userId,
    this.accountSubcategoryId,
    required this.clientId,
    required this.name,
    this.bankTransactionId,
    required this.gst,
    required this.totalGst,
    required this.subTotal,
    required this.price,
    this.image,
    required this.imageType,
    required this.date,
    required this.description,
    required this.paidWithCash,
    required this.fromBankMatch,
    required this.isReconciled,
    required this.classifications,
    required this.createdAt,
    required this.possibleMatch,
    required this.bulkUpload,
    this.accountSubcategory,
    required this.client,
    required this.remainingAmount,
    this.creditNoteId,
    this.creditNoteNo,
  });

  factory ExpenseModel.fromJson(Map<String, dynamic> json) {
    return ExpenseModel(
      type: json['type'] ?? 'expense',
      expenseId: json['expense_id'] ?? 0,
      userId: json['user_id'] ?? 0,
      accountSubcategoryId: json['account_subcategory_id'],
      clientId: json['client_id'] ?? 0,
      name: json['name'] ?? '',
      bankTransactionId: json['bank_transaction_id'],
      gst: json['gst'] ?? 0,
      totalGst: json['total_gst'] ?? 0,
      subTotal: json['sub_total'] ?? 0,
      price: json['price'] ?? 0,
      image: json['image'],
      imageType: json['image_type'] ?? '',
      date: json['date'] ?? '',
      description: json['description'] ?? '',
      paidWithCash: json['paid_with_cash'] ?? 0,
      fromBankMatch: json['from_bank_match'] ?? 0,
      isReconciled: json['is_reconciled'] ?? 0,
      classifications:
          (json['classifications'] as List<dynamic>?)
              ?.map((e) => ExpenseClassification.fromJson(e))
              .toList() ??
          [],
      createdAt: json['created_at'] ?? '',
      possibleMatch: json['possible_match'] ?? 0,
      bulkUpload: json['bulk_upload'] ?? 0,
      accountSubcategory: json['account_subcategory'] != null
          ? AccountSubcategory.fromJson(json['account_subcategory'])
          : null,
      client: ExpenseClient.fromJson(json['client'] ?? {}),
      remainingAmount: json['remainingAmount'] ?? 0,
      creditNoteId: json['credit_note_id'],
      creditNoteNo: json['credit_note_no'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'expense_id': expenseId,
      'user_id': userId,
      'account_subcategory_id': accountSubcategoryId,
      'client_id': clientId,
      'name': name,
      'bank_transaction_id': bankTransactionId,
      'gst': gst,
      'total_gst': totalGst,
      'sub_total': subTotal,
      'price': price,
      'image': image,
      'image_type': imageType,
      'date': date,
      'description': description,
      'paid_with_cash': paidWithCash,
      'from_bank_match': fromBankMatch,
      'is_reconciled': isReconciled,
      'classifications': classifications.map((e) => e.toJson()).toList(),
      'created_at': createdAt,
      'possible_match': possibleMatch,
      'bulk_upload': bulkUpload,
      'account_subcategory': accountSubcategory?.toJson(),
      'client': client.toJson(),
      'remainingAmount': remainingAmount,
      'credit_note_id': creditNoteId,
      'credit_note_no': creditNoteNo,
    };
  }
}

/// Expense Client Model
class ExpenseClient {
  final int clientId;
  final String name;
  final int type;
  final String currency;

  ExpenseClient({
    required this.clientId,
    required this.name,
    required this.type,
    required this.currency,
  });

  factory ExpenseClient.fromJson(Map<String, dynamic> json) {
    return ExpenseClient(
      clientId: json['client_id'] ?? 0,
      name: json['name'] ?? '',
      type: json['type'] ?? 1,
      currency: json['currency'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'client_id': clientId,
      'name': name,
      'type': type,
      'currency': currency,
    };
  }
}

/// Expense Classification (Tags) Model
class ExpenseClassification {
  final int id;
  final int userId;
  final String name;
  final String createdAt;
  final String updatedAt;
  final ClassificationPivot? pivot;

  ExpenseClassification({
    required this.id,
    required this.userId,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    this.pivot,
  });

  factory ExpenseClassification.fromJson(Map<String, dynamic> json) {
    return ExpenseClassification(
      id: json['id'] ?? 0,
      userId: json['user_id'] ?? 0,
      name: json['name'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      pivot: json['pivot'] != null
          ? ClassificationPivot.fromJson(json['pivot'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'name': name,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'pivot': pivot?.toJson(),
    };
  }
}

/// Classification Pivot Model
class ClassificationPivot {
  final int expenseId;
  final int classificationId;

  ClassificationPivot({
    required this.expenseId,
    required this.classificationId,
  });

  factory ClassificationPivot.fromJson(Map<String, dynamic> json) {
    return ClassificationPivot(
      expenseId: json['expense_id'] ?? 0,
      classificationId: json['classification_id'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {'expense_id': expenseId, 'classification_id': classificationId};
  }
}

/// Account Subcategory Model
class AccountSubcategory {
  final int accountSubcategoryId;
  final int accountCategoryId;
  final String name;
  final String code;
  final String subcategoryIcon;

  AccountSubcategory({
    required this.accountSubcategoryId,
    required this.accountCategoryId,
    required this.name,
    required this.code,
    required this.subcategoryIcon,
  });

  factory AccountSubcategory.fromJson(Map<String, dynamic> json) {
    return AccountSubcategory(
      accountSubcategoryId: json['account_subcategory_id'] ?? 0,
      accountCategoryId: json['account_category_id'] ?? 0,
      name: json['name'] ?? '',
      code: json['code'] ?? '',
      subcategoryIcon: json['subcategory_icon'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'account_subcategory_id': accountSubcategoryId,
      'account_category_id': accountCategoryId,
      'name': name,
      'code': code,
      'subcategory_icon': subcategoryIcon,
    };
  }
}

/// Expense Data - Container for list of expenses with pagination
class ExpenseData {
  final List<ExpenseModel> expenseDetails;
  final int nextPage;
  final int total;
  final int totalPages;
  final num maxPrice;

  ExpenseData({
    required this.expenseDetails,
    required this.nextPage,
    required this.total,
    required this.totalPages,
    required this.maxPrice,
  });

  factory ExpenseData.fromJson(Map<String, dynamic> json) {
    return ExpenseData(
      expenseDetails:
          (json['expense_details'] as List<dynamic>?)
              ?.map((e) => ExpenseModel.fromJson(e))
              .toList() ??
          [],
      nextPage: json['next_page'] ?? -1,
      total: json['total'] ?? 0,
      totalPages: json['total_pages'] ?? 0,
      maxPrice: json['max_price'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'expense_details': expenseDetails.map((e) => e.toJson()).toList(),
      'next_page': nextPage,
      'total': total,
      'total_pages': totalPages,
      'max_price': maxPrice,
    };
  }
}

/// Expense Response - Main API response wrapper
class ExpenseResponse {
  final bool success;
  final String message;
  final ExpenseData? data;

  ExpenseResponse({required this.success, required this.message, this.data});

  factory ExpenseResponse.fromJson(Map<String, dynamic> json) {
    return ExpenseResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null ? ExpenseData.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {'success': success, 'message': message, 'data': data?.toJson()};
  }
}

/// Simple Expense Response - For create/update operations
class SimpleExpenseResponse {
  final bool success;
  final String message;
  final Map<String, dynamic>? data;

  SimpleExpenseResponse({
    required this.success,
    required this.message,
    this.data,
  });

  factory SimpleExpenseResponse.fromJson(Map<String, dynamic> json) {
    return SimpleExpenseResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] as Map<String, dynamic>?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'success': success, 'message': message, 'data': data};
  }
}
