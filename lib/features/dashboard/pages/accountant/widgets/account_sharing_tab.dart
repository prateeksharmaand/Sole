import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sole/common/widgets/app_btn/app_btn.dart';
import 'package:sole/features/dashboard/pages/taxes_bankings/taxes_banking_screen.dart';
import 'package:sole/utils/constants/colors.dart';
import 'package:sole/utils/constants/sizes.dart';

class AccountSharingTab extends StatelessWidget {
  const AccountSharingTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: USizes.defaultSpace20,
        vertical: USizes.md,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              DotContainer(),
              Text(
                "Accounting Information",
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: UColors.textPrimary,
                ),
              ),
            ],
          ),
          SizedBox(height: USizes.xl),
          Container(
            padding: EdgeInsets.all(14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: UColors.whiteF9F9,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Access Details",
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: UColors.textPrimary,
                  ),
                ),
                SizedBox(height: USizes.sm),
                Text(
                  "Invite others (e.g., your accountant or bookkeeper) to access your Sole account. You can choose which modules (invoices, expenses, etc.) they see, and set whether they can view, edit, or delete. Access can be changed or revoked anytime.",
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: UColors.textSecondary,
                  ),
                ),
                SizedBox(height: USizes.defaultSpace20),
                SizedBox(
                  width: 200,
                  height: 40,
                  child: UButton(
                    onPressed: () {},
                    label: "Sole Support Access",
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: USizes.lg),
          ListView.builder(
            itemCount: 2,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.only(bottom: USizes.md),
                padding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: UColors.borderEEF1),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "David Tandean",
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: UColors.textPrimary,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.green.withOpacity(
                              0.12,
                            ), // light green bg
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            "Active",
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.green.shade700, // dark green text
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: USizes.xs),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "davidtandean@gmail.com",
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: UColors.textSecondary,
                              ),
                            ),
                            SizedBox(height: USizes.xs),
                            Text(
                              "03/05/2024 - 09/05/2024",
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: UColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: Icon(CupertinoIcons.delete, size: 21),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.edit, size: 21),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}