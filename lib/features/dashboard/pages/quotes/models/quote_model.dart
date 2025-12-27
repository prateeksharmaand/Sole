import 'package:flutter/material.dart';
import 'package:sole/utils/constants/colors.dart';

enum QuoteStatus {
  sent,
  draft,
  converted,
  pending,
  overdue;

  String get name {
    switch (this) {
      case QuoteStatus.sent:
        return 'Sent';
      case QuoteStatus.draft:
        return 'Draft';
      case QuoteStatus.converted:
        return 'Converted';
      case QuoteStatus.pending:
        return 'Pending';
      case QuoteStatus.overdue:
        return 'Overdue';
    }
  }

  Color get color {
    switch (this) {
      case QuoteStatus.sent:
        return UColors.success;
      case QuoteStatus.draft:
        return UColors.textSecondary;
      case QuoteStatus.converted:
        return UColors.primary;
      case QuoteStatus.pending:
        return UColors.warning;
      case QuoteStatus.overdue:
        return UColors.error;
    }
  }

  Color get backgroundColor {
    switch (this) {
      case QuoteStatus.sent:
        return UColors.success.withValues(alpha: 0.1);
      case QuoteStatus.draft:
        return UColors.bg;
      case QuoteStatus.converted:
        return UColors.primary.withValues(alpha: 0.1);
      case QuoteStatus.pending:
        return UColors.warning.withValues(alpha: 0.1);
      case QuoteStatus.overdue:
        return UColors.error.withValues(alpha: 0.1);
    }
  }
}

class QuoteModel {
  final String id;
  final String customerName;
  final String quoteId;
  final String date;
  final double amount;
  final QuoteStatus status;

  QuoteModel({
    required this.id,
    required this.customerName,
    required this.quoteId,
    required this.date,
    required this.amount,
    required this.status,
  });
}
