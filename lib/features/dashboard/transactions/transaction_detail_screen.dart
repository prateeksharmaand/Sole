import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sole/utils/constants/colors.dart';
import 'package:sole/utils/constants/images.dart';
import 'package:sole/utils/constants/sizes.dart';
import 'package:sole/utils/helpers/helper_functions.dart';

class TransactionDetailScreen extends StatelessWidget {
  const TransactionDetailScreen({
    super.key,
    required this.transaction,
    required this.isMatched,
  });

  final Map<String, dynamic> transaction;
  final bool isMatched;

  @override
  Widget build(BuildContext context) {
    final dark = UHelperFunctions.isDarkMode(context);

    return Scaffold(
      backgroundColor: dark ? UColors.black : UColors.bg,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text(
          'Transaction Detal',
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: dark ? UColors.white : UColors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(USizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPrimaryCard(context, dark),
            if (isMatched) ...[
              const SizedBox(height: USizes.spaceBtwSections),
              Text(
                'Macthed Transactions',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: USizes.spaceBtwItems),
              _buildMatchedTransactionsList(context, dark),
            ],
            const SizedBox(height: 100), // Bottom padding
          ],
        ),
      ),
      bottomNavigationBar: !isMatched
          ? _buildUnmatchedActions(context, dark)
          : null,
    );
  }

  Widget _buildPrimaryCard(BuildContext context, bool dark) {
    return Container(
      padding: const EdgeInsets.all(USizes.md),
      decoration: BoxDecoration(
        color: dark ? UColors.dark : UColors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: UColors.borderPrimary.withValues(alpha: 0.5)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFFEDF2FF),
                  shape: BoxShape.circle,
                ),
                child: SvgPicture.asset(
                  UImages.dollarIcon,
                  height: 24,
                  width: 24,
                  colorFilter: const ColorFilter.mode(
                    UColors.primary,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      transaction['date'] ?? '16 December, 2025',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      transaction['id'] ?? '#1030319',
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: UColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              _buildTypeChip(),
            ],
          ),
          const SizedBox(height: USizes.spaceBtwSections),
          _buildDetailRow(
            context,
            isMatched ? 'Category' : 'Amount',
            isMatched ? 'Sales Revenue' : '\$36.00',
            isCategory: isMatched,
          ),
          const SizedBox(height: USizes.spaceBtwItems),
          _buildDetailRow(
            context,
            isMatched ? 'Txn Amount' : 'Balance Left',
            isMatched ? '\$158.40' : '\$36.00',
          ),
          const SizedBox(height: USizes.spaceBtwItems),
          _buildDetailRow(
            context,
            isMatched ? 'Matched Transaction' : 'Source',
            isMatched ? '\$158.40' : 'Bank Feed',
          ),
          const SizedBox(height: USizes.spaceBtwItems),
          _buildDetailRow(
            context,
            isMatched ? "" : 'Account',
            isMatched ? "" : 'Full-time Employee Account',
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: USizes.spaceBtwItems),
            child: Divider(color: UColors.bg),
          ),
          _buildDetailRow(
            context,
            'Description',
            isMatched
                ? 'Invoice paid in cash'
                : 'Fast Transfer From Goliath Pty Ltd',
          ),
        ],
      ),
    );
  }

  Widget _buildTypeChip() {
    if (isMatched) return const SizedBox.shrink();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F9F1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.arrow_outward, size: 12, color: Color(0xFF00B066)),
          const SizedBox(width: 4),
          const Text(
            'Credit',
            style: TextStyle(
              fontSize: 12,
              color: Color(0xFF00B066),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(
    BuildContext context,
    String? label,
    String value, {
    bool isCategory = false,
  }) {
    if (label == null) return const SizedBox.shrink();
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: UColors.textSecondary),
          ),
        ),
        Expanded(
          flex: 3,
          child: Align(
            alignment: Alignment.centerRight,
            child: isCategory
                ? Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8F9F1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      'Sales Revenue',
                      style: TextStyle(
                        fontSize: 10,
                        color: Color(0xFF00B066),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )
                : Text(
                    value,
                    textAlign: TextAlign.right,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
        ),
      ],
    );
  }

  Widget _buildUnmatchedActions(BuildContext context, bool dark) {
    return Padding(
      padding: const EdgeInsets.all(USizes.defaultSpace),
      child: Row(
        children: [
          _buildActionButton(context, 'Personal', () {}),
          const SizedBox(width: 12),
          _buildActionButton(context, 'Transfer', () {}),
          const SizedBox(width: 12),
          _buildActionButton(context, 'Match', () {}),
        ],
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context,
    String label,
    VoidCallback onTap,
  ) {
    return Expanded(
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: UColors.primary),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
        child: Text(
          label,
          style: const TextStyle(
            color: UColors.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildMatchedTransactionsList(BuildContext context, bool dark) {
    return Column(
      children: [
        _buildMatchedItem(context, dark, 'INV-79', '1032135', true),
        const SizedBox(height: 12),
        _buildMatchedItem(context, dark, 'INV-79', '1032135', false),
      ],
    );
  }

  Widget _buildMatchedItem(
    BuildContext context,
    bool dark,
    String title,
    String id,
    bool isExpanded,
  ) {
    return Container(
      padding: const EdgeInsets.all(USizes.md),
      decoration: BoxDecoration(
        color: dark ? UColors.dark : UColors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFFEDEEFF),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: SvgPicture.asset(
                  UImages.documentIcon,
                  height: 20,
                  width: 20,
                  colorFilter: const ColorFilter.mode(
                    UColors.primary,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      id,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: UColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.keyboard_arrow_down,
                color: UColors.textSecondary,
              ),
            ],
          ),
          if (isExpanded) ...[
            const SizedBox(height: USizes.spaceBtwItems),
            _buildDetailRow(context, 'Txn Date', '2025-12-16'),
            const SizedBox(height: 8),
            _buildDetailRow(context, 'Category', 'Sales Revenue'),
            const SizedBox(height: 8),
            _buildDetailRow(context, 'Preference Type', 'Invoice'),
            const SizedBox(height: 8),
            _buildDetailRow(context, 'Client Name', 'Aakruti Pandya'),
            const SizedBox(height: 8),
            _buildDetailRow(context, 'Amount', '\$144.00'),
          ],
        ],
      ),
    );
  }
}
