class ClientResponse {
  final bool success;
  final String message;
  final ClientData? data;

  ClientResponse({required this.success, required this.message, this.data});

  factory ClientResponse.fromJson(Map<String, dynamic> json) {
    return ClientResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null ? ClientData.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {'success': success, 'message': message, 'data': data?.toJson()};
  }
}

class ClientData {
  final List<ClientDetails> clientsDetails;
  final int nextPage;
  final int total;
  final int totalPages;

  ClientData({
    required this.clientsDetails,
    required this.nextPage,
    required this.total,
    required this.totalPages,
  });

  factory ClientData.fromJson(Map<String, dynamic> json) {
    return ClientData(
      clientsDetails:
          (json['clients_details'] as List<dynamic>?)
              ?.map((e) => ClientDetails.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      nextPage: json['next_page'] ?? -1,
      total: json['total'] ?? 0,
      totalPages: json['total_pages'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'clients_details': clientsDetails.map((e) => e.toJson()).toList(),
      'next_page': nextPage,
      'total': total,
      'total_pages': totalPages,
    };
  }
}

class ClientDetails {
  final int clientId;
  final String name;
  final String email;
  final String? clientPic;
  final String? website;
  final String mobileNo;
  final String abn;
  final String businessName;
  final String currency;
  final String? ndisNo;
  final String? accountHolder;
  final String? accountNumber;
  final String? bankName;
  final String? bsb;
  final String? planManagerName;
  final String? planManagerNdis;
  final int type;
  final int fromBankMatch;
  final String createdAt;
  final Address address;

  ClientDetails({
    required this.clientId,
    required this.name,
    required this.email,
    this.clientPic,
    this.website,
    required this.mobileNo,
    required this.abn,
    required this.businessName,
    required this.currency,
    this.ndisNo,
    this.accountHolder,
    this.accountNumber,
    this.bankName,
    this.bsb,
    this.planManagerName,
    this.planManagerNdis,
    required this.type,
    required this.fromBankMatch,
    required this.createdAt,
    required this.address,
  });

  factory ClientDetails.fromJson(Map<String, dynamic> json) {
    return ClientDetails(
      clientId: json['client_id'] ?? 0,
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      clientPic: json['client_pic'],
      website: json['website'],
      mobileNo: json['mobile_no'] ?? '',
      abn: json['ABN'] ?? '',
      businessName: json['business_name'] ?? '',
      currency: json['currency'] ?? '',
      ndisNo: json['ndis_no'],
      accountHolder: json['account_holder'],
      accountNumber: json['account_number'],
      bankName: json['bank_name'],
      bsb: json['bsb'],
      planManagerName: json['plan_manager_name'],
      planManagerNdis: json['plan_manager_ndis'],
      type: json['type'] ?? 0,
      fromBankMatch: json['from_bank_match'] ?? 0,
      createdAt: json['created_at'] ?? '',
      address: Address.fromJson(json['address'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'client_id': clientId,
      'name': name,
      'email': email,
      'client_pic': clientPic,
      'website': website,
      'mobile_no': mobileNo,
      'ABN': abn,
      'business_name': businessName,
      'currency': currency,
      'ndis_no': ndisNo,
      'account_holder': accountHolder,
      'account_number': accountNumber,
      'bank_name': bankName,
      'bsb': bsb,
      'plan_manager_name': planManagerName,
      'plan_manager_ndis': planManagerNdis,
      'type': type,
      'from_bank_match': fromBankMatch,
      'created_at': createdAt,
      'address': address.toJson(),
    };
  }
}

class Address {
  final String addressLine1;
  final String addressLine2;
  final String suburb;
  final String city;
  final String? state;
  final String? postcode;
  final String? country;

  Address({
    required this.addressLine1,
    required this.addressLine2,
    required this.suburb,
    required this.city,
    this.state,
    this.postcode,
    this.country,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      addressLine1: json['address_line1'] ?? '',
      addressLine2: json['address_line2'] ?? '',
      suburb: json['suburb'] ?? '',
      city: json['city'] ?? '',
      state: json['state'],
      postcode: json['postcode'],
      country: json['country'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'address_line1': addressLine1,
      'address_line2': addressLine2,
      'suburb': suburb,
      'city': city,
      'state': state,
      'postcode': postcode,
      'country': country,
    };
  }
}
