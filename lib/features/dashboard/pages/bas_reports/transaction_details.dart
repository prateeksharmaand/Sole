import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/images.dart';
import '../../../../utils/constants/sizes.dart';

class TransactionDetails extends StatelessWidget {
  const TransactionDetails({super.key});

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
          "Transaction Detail",
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
                SvgPicture.asset(UImages.basIcon),
                SizedBox(width: USizes.sm * 1.5),
                Text(
                  "INV-82",
                  style: GoogleFonts.plusJakartaSans(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: UColors.black,
                  ),
                ),
              ],
            ),

            Divider(height: 40, color: UColors.borderBtn),
            _buildRow(title: "Type", value: "Invoices"),
            _buildRow(title: "Category Name", value: "C1"),
            _buildRow(title: "Amount Ex GST", value: "10"),
            _buildRow(title: "GST Amount", value: "11"),
            _buildRow(title: "Date", value: "10/12/2025"),
            _buildRow(title: "Client/Supplier", value: "John Doe"),
            Divider(height: 20, color: UColors.borderBtn),
            _buildRow(title: "Description", value: "Cash receipt for Invoice\n#INV-13"),
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

