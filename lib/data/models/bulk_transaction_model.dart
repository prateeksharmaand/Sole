/// Bulk upload transaction response model
class BulkTransactionUploadResponse {
  final bool success;
  final String message;
  final BulkTransactionData? data;

  BulkTransactionUploadResponse({
    required this.success,
    required this.message,
    this.data,
  });

  factory BulkTransactionUploadResponse.fromJson(Map<String, dynamic> json) {
    return BulkTransactionUploadResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null
          ? BulkTransactionData.fromJson(json['data'])
          : null,
    );
  }
}

class BulkTransactionData {
  final List<List<dynamic>> columns;
  final int fileId;

  BulkTransactionData({required this.columns, required this.fileId});

  factory BulkTransactionData.fromJson(Map<String, dynamic> json) {
    return BulkTransactionData(
      columns: (json['columns'] as List?)?.map((e) => e as List).toList() ?? [],
      fileId: json['file_id'] ?? 0,
    );
  }

  /// Get transaction count from columns
  int get transactionCount {
    if (columns.isEmpty) return 0;
    final firstColumn = columns.first;
    if (firstColumn.length < 2) return 0;
    return (firstColumn[1] as List?)?.length ?? 0;
  }
}
