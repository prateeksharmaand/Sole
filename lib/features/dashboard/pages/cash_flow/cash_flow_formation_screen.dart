import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sole/utils/constants/images.dart';
import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';

class CashFlowFormationScreen extends StatelessWidget {
  const CashFlowFormationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UColors.bg,
      appBar: UAppBar(
        centerTitle: true,
        showBackArrow: true,
        showDivider: false,
        backgroundColor: UColors.bg,
        title: Text(
          "Cashflow Information",
          style: GoogleFonts.plusJakartaSans(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: UColors.textPrimary,
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(USizes.defaultSpace20),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: UColors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            /// Email
            Row(
              children: [
                SvgPicture.asset(UImages.expensesIcon),
                SizedBox(width: USizes.sm * 1.5),
                Text(
                  "21/09/2025",
                  style: GoogleFonts.plusJakartaSans(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: UColors.black,
                  ),
                ),
              ],
            ),

            Divider(height: 20, color: UColors.borderBtn),
            _buildRow(title: "Transaction Type", value: "Expense"),
            _buildRow(title: "Subcategory", value: "Cash"),
            _buildRow(title: "Debit", value: "\$0.00"),
            _buildRow(title: "Credit", value: "\$111.00"),
            _buildRow(title: "Cash Flow Type", value: "Outflow"),
            _buildRow(title: "Net Movement", value: "-\$111.00"),
          ],
        ),
      ),
    );
  }

  /// Common row widget
  Widget _buildRow({required String title, required String value}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14,
              color: UColors.textSecondary,
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: UColors.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
