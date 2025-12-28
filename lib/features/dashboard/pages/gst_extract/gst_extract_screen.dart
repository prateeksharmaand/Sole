import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../utils/constants/colors.dart';

class VatListingScreen extends StatelessWidget {
  const VatListingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UAppBar(
        centerTitle: true,
        showBackArrow: true,
        showDivider: false,
        title: Text(
          "GST Extract",
          style: GoogleFonts.plusJakartaSans(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: UColors.textPrimary,
          ),
        ),
      ),
      body: Center(
        child: Text(
          "Coming soon ...",
          style: GoogleFonts.plusJakartaSans(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: UColors.textSecondary,
          ),
        ),
      ),
    );
  }
}
