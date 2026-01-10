/// Branding settings model
class BrandingModel {
  final String brandColor;
  final String contentColor;

  // Invoice display settings
  final String invCustomerName;
  final String invCustomerBusinessName;
  final String invCustomerAddress;
  final String invCustomerAbn;
  final String invSoleUserName;
  final String invSoleBusinessName;
  final String invSoleBusinessAddress;
  final String invSoleBusinessAbn;
  final String invDisplayDesc;

  // Quote display settings
  final String quoCustomerName;
  final String quoCustomerBusinessName;
  final String quoCustomerAddress;
  final String quoCustomerAbn;
  final String quoSoleUserName;
  final String quoSoleBusinessName;
  final String quoSoleBusinessAddress;
  final String quoSoleBusinessAbn;

  // Social media toggles
  final String phoneEnabled;
  final String websiteEnabled;
  final String facebookUrlEnabled;
  final String instagramUrlEnabled;
  final String linkedinUrlEnabled;
  final String tiktokUrlEnabled;

  // Template selections
  final String invoiceTemplate;
  final String quoteTemplate;
  final String ndisTemplate;

  // Notes
  final String invoiceNote;
  final String quoteNote;

  // Receipt setting
  final String sendPaidInvoiceReceipt;

  BrandingModel({
    required this.brandColor,
    required this.contentColor,
    required this.invCustomerName,
    required this.invCustomerBusinessName,
    required this.invCustomerAddress,
    required this.invCustomerAbn,
    required this.invSoleUserName,
    required this.invSoleBusinessName,
    required this.invSoleBusinessAddress,
    required this.invSoleBusinessAbn,
    required this.invDisplayDesc,
    required this.quoCustomerName,
    required this.quoCustomerBusinessName,
    required this.quoCustomerAddress,
    required this.quoCustomerAbn,
    required this.quoSoleUserName,
    required this.quoSoleBusinessName,
    required this.quoSoleBusinessAddress,
    required this.quoSoleBusinessAbn,
    required this.phoneEnabled,
    required this.websiteEnabled,
    required this.facebookUrlEnabled,
    required this.instagramUrlEnabled,
    required this.linkedinUrlEnabled,
    required this.tiktokUrlEnabled,
    required this.invoiceTemplate,
    required this.quoteTemplate,
    required this.ndisTemplate,
    required this.invoiceNote,
    required this.quoteNote,
    required this.sendPaidInvoiceReceipt,
  });

  /// Create BrandingModel from API response
  factory BrandingModel.fromJson(Map<String, dynamic> json) {
    // Helper to convert bool to "1"/"0" string
    String boolToString(dynamic value) {
      if (value is bool) return value ? '1' : '0';
      if (value is String) return value;
      return '0';
    }

    return BrandingModel(
      brandColor: json['brand_color'] ?? '#4d4dff',
      contentColor: json['content_color'] ?? '#000000',
      invCustomerName: boolToString(json['inv_customer_name']),
      invCustomerBusinessName: boolToString(json['inv_customer_business_name']),
      invCustomerAddress: boolToString(json['inv_customer_address']),
      invCustomerAbn: boolToString(json['inv_customer_abn']),
      invSoleUserName: boolToString(json['inv_sole_user_name']),
      invSoleBusinessName: boolToString(json['inv_sole_business_name']),
      invSoleBusinessAddress: boolToString(json['inv_sole_business_address']),
      invSoleBusinessAbn: boolToString(json['inv_sole_business_abn']),
      invDisplayDesc: boolToString(json['inv_display_desc']),
      quoCustomerName: boolToString(json['quo_customer_name']),
      quoCustomerBusinessName: boolToString(json['quo_customer_business_name']),
      quoCustomerAddress: boolToString(json['quo_customer_address']),
      quoCustomerAbn: boolToString(json['quo_customer_abn']),
      quoSoleUserName: boolToString(json['quo_sole_user_name']),
      quoSoleBusinessName: boolToString(json['quo_sole_business_name']),
      quoSoleBusinessAddress: boolToString(json['quo_sole_business_address']),
      quoSoleBusinessAbn: boolToString(json['quo_sole_business_abn']),
      phoneEnabled: boolToString(json['phone_enabled']),
      websiteEnabled: boolToString(json['website_enabled']),
      facebookUrlEnabled: boolToString(json['facebook_url_enabled']),
      instagramUrlEnabled: boolToString(json['instagram_url_enabled']),
      linkedinUrlEnabled: boolToString(json['linkedin_url_enabled']),
      tiktokUrlEnabled: boolToString(json['tiktok_url_enabled']),
      invoiceTemplate: json['invoice_template']?.toString() ?? '1',
      quoteTemplate: json['quote_template']?.toString() ?? '13',
      ndisTemplate: json['ndis_template']?.toString() ?? '2',
      invoiceNote: json['invoice_note'] ?? '',
      quoteNote: json['quote_note'] ?? '',
      sendPaidInvoiceReceipt: boolToString(json['send_paid_invoice_receipt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'brand_color': brandColor,
      'content_color': contentColor,
      'inv_customer_name': invCustomerName,
      'inv_customer_business_name': invCustomerBusinessName,
      'inv_customer_address': invCustomerAddress,
      'inv_customer_abn': invCustomerAbn,
      'inv_sole_user_name': invSoleUserName,
      'inv_sole_business_name': invSoleBusinessName,
      'inv_sole_business_address': invSoleBusinessAddress,
      'inv_sole_business_abn': invSoleBusinessAbn,
      'inv_display_desc': invDisplayDesc,
      'quo_customer_name': quoCustomerName,
      'quo_customer_business_name': quoCustomerBusinessName,
      'quo_customer_address': quoCustomerAddress,
      'quo_customer_abn': quoCustomerAbn,
      'quo_sole_user_name': quoSoleUserName,
      'quo_sole_business_name': quoSoleBusinessName,
      'quo_sole_business_address': quoSoleBusinessAddress,
      'quo_sole_business_abn': quoSoleBusinessAbn,
      'phone_enabled': phoneEnabled,
      'website_enabled': websiteEnabled,
      'facebook_url_enabled': facebookUrlEnabled,
      'instagram_url_enabled': instagramUrlEnabled,
      'linkedin_url_enabled': linkedinUrlEnabled,
      'tiktok_url_enabled': tiktokUrlEnabled,
      'invoice_template': invoiceTemplate,
      'quote_template': quoteTemplate,
      'ndis_template': ndisTemplate,
      'invoice_note': invoiceNote,
      'quote_note': quoteNote,
      'send_paid_invoice_receipt': sendPaidInvoiceReceipt,
    };
  }
}

/// API response for save branding
class BrandingResponse {
  final bool success;
  final String message;
  final Map<String, dynamic> data;

  BrandingResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory BrandingResponse.fromJson(Map<String, dynamic> json) {
    return BrandingResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] ?? {},
    );
  }
}
