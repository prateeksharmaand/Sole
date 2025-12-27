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
      backgroundColor: UColors.bg,
      appBar: UAppBar(
        centerTitle: true,
        showBackArrow: true,
        showDivider: false,
        backgroundColor: UColors.bg,
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
                Text(
                  "21/09/2025",
                  style: GoogleFonts.plusJakartaSans(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: UColors.black,
                  ),
                ),
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
          ],
        ),
      ),
    );
  }
}
