import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sole/utils/helpers/device_helpers.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../audit_trail/audit_trail_screen.dart';

class AssetsListingScreen extends StatelessWidget {
  const AssetsListingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UAppBar(
        centerTitle: true,
        showBackArrow: true,
        showDivider: false,
        title: Text(
          "Assets Listing",
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
              'Shows details of all your assets',
            ),
            SizedBox(
              height: UDeviceHelper.getScreenHeight(context) * .6,
              child: Center(
                child: CommonEmptyReporting(title: "No asset reports found",
                    subtitle: "There are no asset records available for this period."),
              ),
            )
          ],
        ),
      ),
    );
  }
}
