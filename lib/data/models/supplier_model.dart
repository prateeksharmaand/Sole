/// Supplier response model
class SupplierResponse {
  final bool success;
  final String message;
  final SupplierData? data;

  SupplierResponse({required this.success, required this.message, this.data});

  factory SupplierResponse.fromJson(Map<String, dynamic> json) {
    return SupplierResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null ? SupplierData.fromJson(json['data']) : null,
    );
  }
}

/// Supplier data with pagination
class SupplierData {
  final int total;
  final int currentPage;
  final int nextPage;
  final List<SupplierDetails> suppliersDetails;

  SupplierData({
    required this.total,
    required this.currentPage,
    required this.nextPage,
    required this.suppliersDetails,
  });

  factory SupplierData.fromJson(Map<String, dynamic> json) {
    return SupplierData(
      total: json['total'] ?? 0,
      currentPage: json['current_page'] ?? 1,
      nextPage: json['next_page'] ?? -1,
      suppliersDetails:
          (json['suppliers_details'] as List<dynamic>?)
              ?.map((e) => SupplierDetails.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}

/// Supplier details
class SupplierDetails {
  final int supplierId;
  final int userId;
  final String name;
  final String email;
  final String phone;
  final String? address;
  final String? image;
  final String createdAt;
  final String updatedAt;

  SupplierDetails({
    required this.supplierId,
    required this.userId,
    required this.name,
    required this.email,
    required this.phone,
    this.address,
    this.image,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SupplierDetails.fromJson(Map<String, dynamic> json) {
    return SupplierDetails(
      supplierId: json['supplier_id'] ?? 0,
      userId: json['user_id'] ?? 0,
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      address: json['address'],
      image: json['image'],
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'supplier_id': supplierId,
      'user_id': userId,
      'name': name,
      'email': email,
      'phone': phone,
      'address': address,
      'image': image,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
