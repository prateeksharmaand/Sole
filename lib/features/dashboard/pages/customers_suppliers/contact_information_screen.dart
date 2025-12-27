import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sole/utils/constants/colors.dart';
import '../../../../common/widgets/appbar/appbar.dart';

class ContactInformationScreen extends StatelessWidget {
  final String name;
  final String email;
  final String type; // Client / Supplier
  final String phone;
  final String website;
  final String abn;
  final String businessName;
  final String address;

  const ContactInformationScreen({
    super.key,
    required this.name,
    required this.email,
    required this.type,
    required this.phone,
    required this.website,
    required this.abn,
    required this.businessName,
    required this.address,
  });

  @override
  Widget build(BuildContext context) {
    final bool isClient = type == "Client";

    return Scaffold(
      backgroundColor: UColors.bg,

      appBar: UAppBar(
        centerTitle: true,
        showBackArrow: true,
        showDivider: false,
        backgroundColor: UColors.bg,
        title: Text(
          "Contact Information",
          style: GoogleFonts.plusJakartaSans(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: UColors.textPrimary,
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.shade300),
          ),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [

              /// ===== HEADER =====
              Row(
                children: [
                  contactAvatar(name, isClient),

                  const SizedBox(width: 12),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: UColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          email,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 14,
                            color: UColors.textA4A6,
                          ),
                        ),
                      ],
                    ),
                  ),

                  typeChip(type),
                ],
              ),

              const SizedBox(height: 18),

              /// ===== DETAILS =====
              detailTile("Phone Number", phone),
              detailTile("Contact Website", website),
              detailTile("Contact ABN", abn),
              detailTile("Contact BusinessName", businessName),

              const SizedBox(height: 6),
              Divider(color: UColors.divider),
              const SizedBox(height: 6),

              Text(
                "Address",
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: UColors.textSecondary,
                ),
              ),

              const SizedBox(height: 6),

              Text(
                address,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 14,
                  color: UColors.textPrimary,
                  fontWeight: FontWeight.w500,
                  height: 1.2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// ---------- Widgets ----------

  Widget detailTile(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14,
              color: UColors.textSecondary,
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                value,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: UColors.textPrimary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget typeChip(String type) {
    final isClient = type == "Client";

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isClient ? const Color(0xffE8F8EF) : const Color(0xffEEF2FF),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        type,
        style: GoogleFonts.plusJakartaSans(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: isClient ? const Color(0xff1A7F4A) : const Color(0xff4A5DFF),
        ),
      ),
    );
  }

  Widget contactAvatar(String name, bool isClient) {
    final initials = name.trim().split(" ").map((e) => e[0]).take(2).join();

    return Container(
      height: 42,
      width: 42,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isClient ? const Color(0xffE2F3EA) : const Color(0xffE9EEFF),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        initials,
        style: GoogleFonts.plusJakartaSans(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: UColors.textPrimary,
        ),
      ),
    );
  }
}

