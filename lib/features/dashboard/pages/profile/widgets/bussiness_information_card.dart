import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sole/utils/constants/colors.dart';
import 'package:sole/utils/constants/images.dart';

class BusinessInformationCard extends StatelessWidget {
  const BusinessInformationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// ---------------- Header ----------------
          Row(
            children: [
              Container(
                height: 44,
                width: 44,
                decoration: BoxDecoration(
                  color: const Color(0xFFEFF3FF),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    UImages.buildingsIcon, // replace
                    height: 22,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                "Business Informations",
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: UColors.textPrimary,
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          /// ---------------- Two Fields Row ----------------
          Row(
            children: [
              Expanded(
                child: _infoBox(
                  label: "Business Name",
                  value: "Test .Inc",
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _infoBox(
                  label: "Industry",
                  value: "Finance",
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          /// ---------------- ABN Input ----------------
          Row(
            children: [
              Expanded(
                child: _infoBox(
                  label: "ABN Number",
                  value: "12345678",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// ---------------- Info Box ----------------
  Widget _infoBox({
    required String label,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: UColors.whiteF9F9,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 12,
              color: UColors.textSecondary,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: UColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
