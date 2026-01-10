class DashboardResponse {
  final bool success;
  final String message;
  final DashboardData? data;

  DashboardResponse({required this.success, required this.message, this.data});

  factory DashboardResponse.fromJson(Map<String, dynamic> json) {
    return DashboardResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null ? DashboardData.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {'success': success, 'message': message, 'data': data?.toJson()};
  }
}

class DashboardData {
  final InvoiceTotal invoiceTotal;
  final num assetsTotal;
  final List<dynamic> bankAccounts;
  final num bankBalance;
  final num reconcilePending;
  final Map<String, dynamic> snapshot;
  final AppUpdate appUpdate;
  final num estimatedTax;
  final String estimatedTaxCalcDate;
  final bool isInstantpayEnable;

  DashboardData({
    required this.invoiceTotal,
    required this.assetsTotal,
    required this.bankAccounts,
    required this.bankBalance,
    required this.reconcilePending,
    required this.snapshot,
    required this.appUpdate,
    required this.estimatedTax,
    required this.estimatedTaxCalcDate,
    required this.isInstantpayEnable,
  });

  factory DashboardData.fromJson(Map<String, dynamic> json) {
    return DashboardData(
      invoiceTotal: InvoiceTotal.fromJson(json['invoice_total'] ?? {}),
      assetsTotal: json['assets_total'] ?? 0,
      bankAccounts: json['bank_accounts'] ?? [],
      bankBalance: json['bank_balance'] ?? 0,
      reconcilePending: json['reconcile_pending'] ?? 0,
      snapshot: json['snapshot'] ?? {},
      appUpdate: AppUpdate.fromJson(json['app_update'] ?? {}),
      estimatedTax: json['estimated_tax'] ?? 0,
      estimatedTaxCalcDate: json['estimated_tax_calc_date'] ?? '',
      isInstantpayEnable: json['is_instantpay_enable'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'invoice_total': invoiceTotal.toJson(),
      'assets_total': assetsTotal,
      'bank_accounts': bankAccounts,
      'bank_balance': bankBalance,
      'reconcile_pending': reconcilePending,
      'snapshot': snapshot,
      'app_update': appUpdate.toJson(),
      'estimated_tax': estimatedTax,
      'estimated_tax_calc_date': estimatedTaxCalcDate,
      'is_instantpay_enable': isInstantpayEnable,
    };
  }
}

class InvoiceTotal {
  final num paidAmount;
  final num draftAmount;
  final num dueAmount;
  final num overdueAmount;

  InvoiceTotal({
    required this.paidAmount,
    required this.draftAmount,
    required this.dueAmount,
    required this.overdueAmount,
  });

  factory InvoiceTotal.fromJson(Map<String, dynamic> json) {
    return InvoiceTotal(
      paidAmount: json['paid_amount'] ?? 0,
      draftAmount: json['draft_amount'] ?? 0,
      dueAmount: json['due_amount'] ?? 0,
      overdueAmount: json['overdue_amount'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'paid_amount': paidAmount,
      'draft_amount': draftAmount,
      'due_amount': dueAmount,
      'overdue_amount': overdueAmount,
    };
  }
}

class AppUpdate {
  final bool forceUpdate;
  final String appVersion;
  final String content;

  AppUpdate({
    required this.forceUpdate,
    required this.appVersion,
    required this.content,
  });

  factory AppUpdate.fromJson(Map<String, dynamic> json) {
    return AppUpdate(
      forceUpdate: json['force_update'] ?? false,
      appVersion: json['app_version'] ?? '',
      content: json['content'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'force_update': forceUpdate,
      'app_version': appVersion,
      'content': content,
    };
  }
}
