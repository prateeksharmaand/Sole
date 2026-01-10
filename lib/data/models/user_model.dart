class UserModel {
  final String userId;
  final String email;
  final String countryCode;
  final String mobileNumber;
  final int signupSource;
  final String fullName;
  final String firstName;
  final String lastName;
  final String? profilePic;
  final String gender;
  final String dob;
  final String companyName;
  final String abn;
  final String businessName;
  final int industryId;
  final String? ndisNo;
  final String accountingType;
  final String? entityType;
  final String couponCode;
  final String ccType;
  final bool openReferDialog;
  final String beneficiaryId;
  final List<dynamic> customFields;
  final String role;
  final int roleId;
  final int noReferral;
  final String specialPlan;
  final bool isFirstLogin;
  final bool isOnboardingSkipped;
  final bool isTransactionPresent;
  final bool isInvoicePresent;
  final bool isExpensePresent;
  final bool isAssetPresent;
  final bool isQuotePresent;
  final AddressModel address;
  final BankModel bank;
  final String token;
  final List<dynamic> basiqConnectionDetail;
  final SubscriptionModel subscription;
  final CanModel can;
  final bool isInstantpayEnable;
  final bool isAccountant;
  final bool isLoginAs;
  final bool hasManualAccount;

  UserModel({
    required this.userId,
    required this.email,
    required this.countryCode,
    required this.mobileNumber,
    required this.signupSource,
    required this.fullName,
    required this.firstName,
    required this.lastName,
    this.profilePic,
    required this.gender,
    required this.dob,
    required this.companyName,
    required this.abn,
    required this.businessName,
    required this.industryId,
    this.ndisNo,
    required this.accountingType,
    this.entityType,
    required this.couponCode,
    required this.ccType,
    required this.openReferDialog,
    required this.beneficiaryId,
    required this.customFields,
    required this.role,
    required this.roleId,
    required this.noReferral,
    required this.specialPlan,
    required this.isFirstLogin,
    required this.isOnboardingSkipped,
    required this.isTransactionPresent,
    required this.isInvoicePresent,
    required this.isExpensePresent,
    required this.isAssetPresent,
    required this.isQuotePresent,
    required this.address,
    required this.bank,
    required this.token,
    required this.basiqConnectionDetail,
    required this.subscription,
    required this.can,
    required this.isInstantpayEnable,
    required this.isAccountant,
    required this.isLoginAs,
    required this.hasManualAccount,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['user_id'].toString(),
      email: json['email'] ?? '',
      countryCode: json['country_code'] ?? '',
      mobileNumber: json['mobile_number'] ?? '',
      signupSource: json['signup_source'] ?? 0,
      fullName: json['full_name'] ?? '',
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      profilePic: json['profile_pic'],
      gender: json['gender'] ?? '',
      dob: json['dob'] ?? '',
      companyName: json['company_name'] ?? '',
      abn: json['abn'] ?? '',
      businessName: json['business_name'] ?? '',
      industryId: json['industry_id'] ?? 0,
      ndisNo: json['ndis_no'],
      accountingType: json['accounting_type'] ?? 'cash',
      entityType: json['entity_type'],
      couponCode: json['coupon_code'] ?? '',
      ccType: json['cc_type'] ?? '',
      openReferDialog: json['open_refer_dialog'] ?? false,
      beneficiaryId: json['beneficiary_id'] ?? '',
      customFields: json['custom_fields'] ?? [],
      role: json['role'] ?? 'app_user',
      roleId: json['role_id'] ?? 2,
      noReferral: json['no_referral'] ?? 0,
      specialPlan: json['special_plan'] ?? '',
      isFirstLogin: json['is_first_login'] ?? false,
      isOnboardingSkipped: json['is_onboarding_skipped'] ?? false,
      isTransactionPresent: json['is_transaction_present'] ?? false,
      isInvoicePresent: json['is_invoice_present'] ?? false,
      isExpensePresent: json['is_expense_present'] ?? false,
      isAssetPresent: json['is_asset_present'] ?? false,
      isQuotePresent: json['is_quote_present'] ?? false,
      address: AddressModel.fromJson(json['address'] ?? {}),
      bank: BankModel.fromJson(json['bank'] ?? {}),
      token: json['token'] ?? '',
      basiqConnectionDetail: json['basiq_connection_detail'] ?? [],
      subscription: SubscriptionModel.fromJson(json['subscription'] ?? {}),
      can: CanModel.fromJson(json['can'] ?? {}),
      isInstantpayEnable: json['is_instantpay_enable'] ?? false,
      isAccountant: json['isAccountant'] ?? false,
      isLoginAs: json['isLoginAs'] ?? false,
      hasManualAccount: json['hasManualAccount'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'email': email,
      'country_code': countryCode,
      'mobile_number': mobileNumber,
      'signup_source': signupSource,
      'full_name': fullName,
      'first_name': firstName,
      'last_name': lastName,
      'profile_pic': profilePic,
      'gender': gender,
      'dob': dob,
      'company_name': companyName,
      'abn': abn,
      'business_name': businessName,
      'industry_id': industryId,
      'ndis_no': ndisNo,
      'accounting_type': accountingType,
      'entity_type': entityType,
      'coupon_code': couponCode,
      'cc_type': ccType,
      'open_refer_dialog': openReferDialog,
      'beneficiary_id': beneficiaryId,
      'custom_fields': customFields,
      'role': role,
      'role_id': roleId,
      'no_referral': noReferral,
      'special_plan': specialPlan,
      'is_first_login': isFirstLogin,
      'is_onboarding_skipped': isOnboardingSkipped,
      'is_transaction_present': isTransactionPresent,
      'is_invoice_present': isInvoicePresent,
      'is_expense_present': isExpensePresent,
      'is_asset_present': isAssetPresent,
      'is_quote_present': isQuotePresent,
      'address': address.toJson(),
      'bank': bank.toJson(),
      'token': token,
      'basiq_connection_detail': basiqConnectionDetail,
      'subscription': subscription.toJson(),
      'can': can.toJson(),
      'is_instantpay_enable': isInstantpayEnable,
      'isAccountant': isAccountant,
      'isLoginAs': isLoginAs,
      'hasManualAccount': hasManualAccount,
    };
  }
}

class AddressModel {
  final String addressLine1;
  final String addressLine2;
  final String suburb;
  final String city;
  final String state;
  final String country;
  final String postcode;

  AddressModel({
    required this.addressLine1,
    required this.addressLine2,
    required this.suburb,
    required this.city,
    required this.state,
    required this.country,
    required this.postcode,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      addressLine1: json['address_line1'] ?? '',
      addressLine2: json['address_line2'] ?? '',
      suburb: json['suburb'] ?? '',
      city: json['city'] ?? '',
      state: json['state'] ?? '',
      country: json['country'] ?? '',
      postcode: json['postcode'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'address_line1': addressLine1,
      'address_line2': addressLine2,
      'suburb': suburb,
      'city': city,
      'state': state,
      'country': country,
      'postcode': postcode,
    };
  }
}

class BankModel {
  final String accountHolder;
  final String accountNumber;
  final String bankName;
  final String bsb;

  BankModel({
    required this.accountHolder,
    required this.accountNumber,
    required this.bankName,
    required this.bsb,
  });

  factory BankModel.fromJson(Map<String, dynamic> json) {
    return BankModel(
      accountHolder: json['account_holder'] ?? '',
      accountNumber: json['account_number'] ?? '',
      bankName: json['bank_name'] ?? '',
      bsb: json['bsb'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'account_holder': accountHolder,
      'account_number': accountNumber,
      'bank_name': bankName,
      'bsb': bsb,
    };
  }
}

class SubscriptionModel {
  final bool isFree;
  final int isCancelSubscription;
  final String subscriptionType;
  final bool subscriptionExpire;
  final String subscriptionExpiryDate;
  final String subscriptionDueDate;
  final String subscriptionPlanInfo;
  final int freeDay;
  final String? stripeCustomerId;
  final String? stripeSubscriptionId;
  final String? stripePlan;
  final String paymentInterval;
  final int noOfLicence;
  final String? subscriptionPlan;
  final int planId;
  final num nextAmount;

  SubscriptionModel({
    required this.isFree,
    required this.isCancelSubscription,
    required this.subscriptionType,
    required this.subscriptionExpire,
    required this.subscriptionExpiryDate,
    required this.subscriptionDueDate,
    required this.subscriptionPlanInfo,
    required this.freeDay,
    this.stripeCustomerId,
    this.stripeSubscriptionId,
    this.stripePlan,
    required this.paymentInterval,
    required this.noOfLicence,
    this.subscriptionPlan,
    required this.planId,
    required this.nextAmount,
  });

  factory SubscriptionModel.fromJson(Map<String, dynamic> json) {
    return SubscriptionModel(
      isFree: json['is_free'] ?? true,
      isCancelSubscription: json['is_cancel_subscription'] ?? 0,
      subscriptionType: json['subscription_type'] ?? '',
      subscriptionExpire: json['subscription_expire'] ?? false,
      subscriptionExpiryDate: json['subscription_expirty_date'] ?? '',
      subscriptionDueDate: json['subscription_due_date'] ?? '',
      subscriptionPlanInfo: json['subscription_plan_info'] ?? '',
      freeDay: json['free_day'] ?? 0,
      stripeCustomerId: json['stripe_customer_id'],
      stripeSubscriptionId: json['stripe_subscription_id'],
      stripePlan: json['stripe_plan'],
      paymentInterval: json['payment_interval'] ?? '',
      noOfLicence: json['no_of_licence'] ?? 1,
      subscriptionPlan: json['subscription_plan'],
      planId: json['plan_id'] ?? 1,
      nextAmount: json['next_amount'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'is_free': isFree,
      'is_cancel_subscription': isCancelSubscription,
      'subscription_type': subscriptionType,
      'subscription_expire': subscriptionExpire,
      'subscription_expirty_date': subscriptionExpiryDate,
      'subscription_due_date': subscriptionDueDate,
      'subscription_plan_info': subscriptionPlanInfo,
      'free_day': freeDay,
      'stripe_customer_id': stripeCustomerId,
      'stripe_subscription_id': stripeSubscriptionId,
      'stripe_plan': stripePlan,
      'payment_interval': paymentInterval,
      'no_of_licence': noOfLicence,
      'subscription_plan': subscriptionPlan,
      'plan_id': planId,
      'next_amount': nextAmount,
    };
  }
}

class CanModel {
  final bool addQuote;
  final int quotes;
  final int maxQuotes;
  final bool addInvoice;
  final int invoices;
  final int maxInvoices;
  final bool addExpense;
  final int expenses;
  final int maxExpenses;
  final bool addAsset;
  final int assets;
  final int maxAssets;
  final bool addContacts;
  final int contacts;
  final int maxContacts;
  final bool addManualBankFetch;
  final int manualBankFetch;
  final int maxManualBankFetch;
  final String limitReset;
  final bool displayLimitSec;

  CanModel({
    required this.addQuote,
    required this.quotes,
    required this.maxQuotes,
    required this.addInvoice,
    required this.invoices,
    required this.maxInvoices,
    required this.addExpense,
    required this.expenses,
    required this.maxExpenses,
    required this.addAsset,
    required this.assets,
    required this.maxAssets,
    required this.addContacts,
    required this.contacts,
    required this.maxContacts,
    required this.addManualBankFetch,
    required this.manualBankFetch,
    required this.maxManualBankFetch,
    required this.limitReset,
    required this.displayLimitSec,
  });

  factory CanModel.fromJson(Map<String, dynamic> json) {
    return CanModel(
      addQuote: json['add_quote'] ?? false,
      quotes: json['quotes'] ?? 0,
      maxQuotes: json['max_quotes'] ?? 0,
      addInvoice: json['add_invoice'] ?? false,
      invoices: json['invoices'] ?? 0,
      maxInvoices: json['max_invoices'] ?? 0,
      addExpense: json['add_expense'] ?? false,
      expenses: json['expenses'] ?? 0,
      maxExpenses: json['max_expenses'] ?? 0,
      addAsset: json['add_asset'] ?? false,
      assets: json['assets'] ?? 0,
      maxAssets: json['max_assets'] ?? 0,
      addContacts: json['add_contacts'] ?? false,
      contacts: json['contacts'] ?? 0,
      maxContacts: json['max_contacts'] ?? 0,
      addManualBankFetch: json['add_manual_bank_fetch'] ?? false,
      manualBankFetch: json['manual_bank_fetch'] ?? 0,
      maxManualBankFetch: json['max_manual_bank_fetch'] ?? 0,
      limitReset: json['limit_reset'] ?? '',
      displayLimitSec: json['display_limit_sec'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'add_quote': addQuote,
      'quotes': quotes,
      'max_quotes': maxQuotes,
      'add_invoice': addInvoice,
      'invoices': invoices,
      'max_invoices': maxInvoices,
      'add_expense': addExpense,
      'expenses': expenses,
      'max_expenses': maxExpenses,
      'add_asset': addAsset,
      'assets': assets,
      'max_assets': maxAssets,
      'add_contacts': addContacts,
      'contacts': contacts,
      'max_contacts': maxContacts,
      'add_manual_bank_fetch': addManualBankFetch,
      'manual_bank_fetch': manualBankFetch,
      'max_manual_bank_fetch': maxManualBankFetch,
      'limit_reset': limitReset,
      'display_limit_sec': displayLimitSec,
    };
  }
}

class LoginResponse {
  final bool success;
  final String message;
  final UserModel? user;

  LoginResponse({required this.success, required this.message, this.user});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      user: json['data'] != null && json['data']['user'] != null
          ? UserModel.fromJson(json['data']['user'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': user != null ? {'user': user!.toJson()} : {},
    };
  }
}
