import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../assets/assets_screen.dart';
import '../audit_trail/audit_trail_screen.dart';

class ChartOfAccountsScreen extends StatelessWidget {
  const ChartOfAccountsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UAppBar(
        centerTitle: true,
        showBackArrow: true,
        showDivider: false,
        title: Text("Chart Of Accounts",style: GoogleFonts.plusJakartaSans(
            fontSize: 18,fontWeight: FontWeight.w600,color: UColors.textPrimary
        )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(USizes.defaultSpace20),
        child: Column(
          children: [
            /// Info Box
            CommonInfoContainer(
              text: 'A report showing a breakdown of your Sole transactions grouped according to your contacts (customers and suppliers).',
            ),

            SizedBox(height: USizes.lg),

            /// Search
            Row(children: [UCommonSearch(hint: "Search  contacts")]),

            SizedBox(height: USizes.md),

            /// List Area
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.zero,
                itemCount: 4,
                separatorBuilder: (context, index) =>
                    SizedBox(height: USizes.md),

                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: UColors.borderBtn, width: 1),
                      color: Colors.white,
                    ),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Cost Incurred on a Job (COGS",
                          style: GoogleFonts.plusJakartaSans(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: UColors.black,
                          ),
                        ),

                       SizedBox(height: 13),

                        /// Category
                        _buildRow(
                          title: "Category ID",
                          value: "#123456",
                        ),

                        SizedBox(height: 10),

                        /// Category Name
                        _buildRow(
                          title: "Category Name",
                          value: "Expenses",
                        ),

                        SizedBox(height: 10),

                        /// Subcategory ID
                        _buildRow(
                          title: "Subcategory ID",
                          value:
                          "#09234",
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
  /// Common row widget
  Widget _buildRow({required String title, required String value}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 14,
            color: UColors.text5866,
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
    );
  }
}
