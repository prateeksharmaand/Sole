import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../common/widgets/app_btn/app_btn.dart';
import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/device_helpers.dart';
import '../audit_trail/audit_trail_screen.dart';
import '../cash_flow/cash_flow_screen.dart';

class TrialBalanceScreen extends StatelessWidget {
  const TrialBalanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UAppBar(
        centerTitle: true,
        showBackArrow: true,
        showDivider: false,
        title: Text(
          "Trial balance",
          style: GoogleFonts.plusJakartaSans(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: UColors.textPrimary,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(USizes.defaultSpace20),
        child: Column(
          children: [
            /// Info Box
            CommonInfoContainer(
              text:
              'Tracks the movement of money in and out of your business, showing how cash is generated and spent during a specific period. It helps assess your company’s liquidity, operational efficiency, and overall financial health.',
            ),

            SizedBox(height: USizes.lg),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: UColors.borderBtn),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CommonHeadingValue(heading: 'Total Debit'),
                  Container(height: 50, width: 2, color: UColors.divider),
                  CommonHeadingValue(heading: 'Total Credit'),
                ],
              ),
            ),

            SizedBox(height: USizes.lg),



            SizedBox(height: USizes.md),

            /// List Area
          ],
        ),
      ),
      bottomSheet: Padding(
        padding: EdgeInsets.only(
          bottom: UDeviceHelper.getBottomNavigationBarHeight() / 2,
          left: USizes.defaultSpace20,
          right: USizes.defaultSpace20,
        ),
        child: Row(
          children: [
            Expanded(
              child: UButton(
                onPressed: () {},
                bgColor: UColors.white,
                borderColor: UColors.primary,
                label: "Download",
                textColor: UColors.primary,
              ),
            ),
            SizedBox(width: USizes.sm * 1.5),
            Expanded(
              child: UButton(onPressed: () {}, label: "Send Report"),
            ),
          ],
        ),
      ),
    );
  }
}
