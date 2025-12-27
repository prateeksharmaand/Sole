import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sole/common/widgets/appbar/appbar.dart';
import 'package:sole/utils/constants/colors.dart';
import 'package:sole/utils/constants/sizes.dart';

class ProfitLossBreakdownScreen extends StatelessWidget {
  const ProfitLossBreakdownScreen({
    super.key,
    required this.title,
    required this.data,
  });

  final String title;
  final List<Map<String, dynamic>> data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UAppBar(
        title: Text(title, style: Theme.of(context).textTheme.headlineMedium),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(USizes.defaultSpace),
        child: Container(
          decoration: BoxDecoration(
            color: UColors.white,
            borderRadius: BorderRadius.circular(USizes.cardRadiusMd),
            border: Border.all(color: UColors.borderEEF1),
          ),
          child: Column(
            children: data.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;
              final isLast = index == data.length - 1;

              return Container(
                decoration: BoxDecoration(
                  border: isLast
                      ? null
                      : const Border(
                          bottom: BorderSide(color: UColors.borderEEF1),
                        ),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: USizes.md,
                  vertical: USizes.md,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      item['period'],
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: UColors.textSecondary,
                      ),
                    ),
                    Text(
                      '\$${(item['amount'] as double).toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
