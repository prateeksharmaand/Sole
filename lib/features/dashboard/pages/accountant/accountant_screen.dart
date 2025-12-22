import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sole/common/widgets/appbar/appbar.dart';
import 'package:sole/features/dashboard/pages/accountant/widgets/account_sharing_tab.dart';
import 'package:sole/features/dashboard/pages/accountant/widgets/accountant_bookkerper_tab.dart';
import 'package:sole/utils/constants/colors.dart';
import 'package:sole/utils/constants/sizes.dart';

class AccountantScreen extends StatelessWidget {
  const AccountantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: UAppBar(
          title: Text("Accountant"),
          showBackArrow: true,
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text(
                "SAVE & UPDATE",
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: UColors.primary,
                ),
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            SizedBox(height: USizes.md),
            TabBar(
              dividerColor: UColors.divider,
              indicatorColor: UColors.primary,
              labelStyle: GoogleFonts.plusJakartaSans(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: UColors.primary,
              ),
              unselectedLabelStyle: GoogleFonts.plusJakartaSans(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: UColors.textSecondary,
              ),
              tabs: [
                Tab(text: "Accountant & Bookkeeper"),
                Tab(text: "Account Sharing"),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [AccountantBookkeeperTab(), AccountSharingTab()],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
