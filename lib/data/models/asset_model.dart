class AssetResponse {
  final bool success;
  final String message;
  final AssetData? data;

  AssetResponse({required this.success, required this.message, this.data});

  factory AssetResponse.fromJson(Map<String, dynamic> json) {
    return AssetResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null ? AssetData.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {'success': success, 'message': message, 'data': data?.toJson()};
  }
}

class AssetData {
  final List<AssetDetails> assetDetails;
  final int nextPage;
  final int total;
  final int totalPages;
  final String? maxPrice;
  final num? assetsTotal;

  AssetData({
    required this.assetDetails,
    required this.nextPage,
    required this.total,
    required this.totalPages,
    this.maxPrice,
    this.assetsTotal,
  });

  factory AssetData.fromJson(Map<String, dynamic> json) {
    return AssetData(
      assetDetails:
          (json['asset_details'] as List<dynamic>?)
              ?.map((e) => AssetDetails.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      nextPage: json['next_page'] ?? -1,
      total: json['total'] ?? 0,
      totalPages: json['total_pages'] ?? 0,
      maxPrice: json['max_price']?.toString(),
      assetsTotal: json['assets_total'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'asset_details': assetDetails.map((e) => e.toJson()).toList(),
      'next_page': nextPage,
      'total': total,
      'total_pages': totalPages,
      'max_price': maxPrice,
      'assets_total': assetsTotal,
    };
  }
}

class AssetDetails {
  final String type;
  final int assetId;
  final int userId;
  final int clientId;
  final int? bankTransactionId;
  final int accountSubcategoryId;
  final String assetNo;
  final String name;
  final int gst;
  final num totalGst;
  final num subTotal;
  final String price;
  final String assetPic;
  final String imageType;
  final String dateOfPurchase;
  final int paidWithCash;
  final int fromBankMatch;
  final int isReconciled;
  final int possibleMatch;
  final int bulkUpload;
  final AssetClient? client;
  final AccountSubcategory? accountSubcategory;
  final num? remainingAmount;

  AssetDetails({
    required this.type,
    required this.assetId,
    required this.userId,
    required this.clientId,
    this.bankTransactionId,
    required this.accountSubcategoryId,
    required this.assetNo,
    required this.name,
    required this.gst,
    required this.totalGst,
    required this.subTotal,
    required this.price,
    required this.assetPic,
    required this.imageType,
    required this.dateOfPurchase,
    required this.paidWithCash,
    required this.fromBankMatch,
    required this.isReconciled,
    required this.possibleMatch,
    required this.bulkUpload,
    this.client,
    this.accountSubcategory,
    this.remainingAmount,
  });

  factory AssetDetails.fromJson(Map<String, dynamic> json) {
    return AssetDetails(
      type: json['type'] ?? '',
      assetId: json['asset_id'] ?? 0,
      userId: json['user_id'] ?? 0,
      clientId: json['client_id'] ?? 0,
      bankTransactionId: json['bank_transaction_id'],
      accountSubcategoryId: json['account_subcategory_id'] ?? 0,
      assetNo: json['asset_no'] ?? '',
      name: json['name'] ?? '',
      gst: json['gst'] ?? 0,
      totalGst: json['total_gst'] ?? 0,
      subTotal: json['sub_total'] ?? 0,
      price: json['price']?.toString() ?? '0',
      assetPic: json['asset_pic'] ?? '',
      imageType: json['image_type'] ?? '',
      dateOfPurchase: json['date_of_purchase'] ?? '',
      paidWithCash: json['paid_with_cash'] ?? 0,
      fromBankMatch: json['from_bank_match'] ?? 0,
      isReconciled: json['is_reconciled'] ?? 0,
      possibleMatch: json['possible_match'] ?? 0,
      bulkUpload: json['bulk_upload'] ?? 0,
      client: json['client'] != null
          ? AssetClient.fromJson(json['client'])
          : null,
      accountSubcategory: json['account_subcategory'] != null
          ? AccountSubcategory.fromJson(json['account_subcategory'])
          : null,
      remainingAmount: json['remainingAmount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'asset_id': assetId,
      'user_id': userId,
      'client_id': clientId,
      'bank_transaction_id': bankTransactionId,
      'account_subcategory_id': accountSubcategoryId,
      'asset_no': assetNo,
      'name': name,
      'gst': gst,
      'total_gst': totalGst,
      'sub_total': subTotal,
      'price': price,
      'asset_pic': assetPic,
      'image_type': imageType,
      'date_of_purchase': dateOfPurchase,
      'paid_with_cash': paidWithCash,
      'from_bank_match': fromBankMatch,
      'is_reconciled': isReconciled,
      'possible_match': possibleMatch,
      'bulk_upload': bulkUpload,
      'client': client?.toJson(),
      'account_subcategory': accountSubcategory?.toJson(),
      'remainingAmount': remainingAmount,
    };
  }
}

class AssetClient {
  final int clientId;
  final String name;
  final String email;
  final String? clientPic;
  final String? website;
  final String abn;
  final String businessName;
  final int type;
  final int fromBankMatch;

  AssetClient({
    required this.clientId,
    required this.name,
    required this.email,
    this.clientPic,
    this.website,
    required this.abn,
    required this.businessName,
    required this.type,
    required this.fromBankMatch,
  });

  factory AssetClient.fromJson(Map<String, dynamic> json) {
    return AssetClient(
      clientId: json['client_id'] ?? 0,
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      clientPic: json['client_pic'],
      website: json['website'],
      abn: json['ABN'] ?? '',
      businessName: json['business_name'] ?? '',
      type: json['type'] ?? 0,
      fromBankMatch: json['from_bank_match'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'client_id': clientId,
      'name': name,
      'email': email,
      'client_pic': clientPic,
      'website': website,
      'ABN': abn,
      'business_name': businessName,
      'type': type,
      'from_bank_match': fromBankMatch,
    };
  }
}

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

// Simple response for create/edit operations
class SimpleAssetResponse {
  final bool success;
  final String message;
  final Map<String, dynamic>? data;

  SimpleAssetResponse({
    required this.success,
    required this.message,
    this.data,
  });

  factory SimpleAssetResponse.fromJson(Map<String, dynamic> json) {
    return SimpleAssetResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] as Map<String, dynamic>?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'success': success, 'message': message, 'data': data};
  }
}
