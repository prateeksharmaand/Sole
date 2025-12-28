import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';

class CashScreen extends StatelessWidget {
  const CashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UAppBar(
        centerTitle: true,
        showBackArrow: true,
        showDivider: false,
        title: Text(
          "Cash",
          style: GoogleFonts.plusJakartaSans(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: UColors.textPrimary,
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(USizes.defaultSpace20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: UColors.white,
          border: Border.all(
            color: UColors.borderBtn,width: 1
          )
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _yearAmountRow("2022", "\$200.00"),
            Divider(color: UColors.borderBtn),

            _yearAmountRow("2023", "\$200.00"),
            Divider(color: UColors.borderBtn),

            _yearAmountRow("2024", "\$250.00"),
            Divider(color: UColors.borderBtn),

            _yearAmountRow("2025", "\$300.00"),
          ],
        ),
      ),

    );
  }
  Widget _yearAmountRow(String year, String amount) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14,horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            year,
            style: GoogleFonts.plusJakartaSans(
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: UColors.textPrimary,
            ),
          ),
          Text(
            amount,
            style: GoogleFonts.plusJakartaSans(
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: UColors.textPrimary
            ),
          ),
        ],
      ),
    );
  }

}
