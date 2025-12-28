import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../utils/constants/colors.dart';

class CommonYearDropdown extends StatelessWidget {
  final RxString selectedYear;
  final List<String> years;
  final Function(String value) onChanged;

  const CommonYearDropdown({
    super.key,
    required this.selectedYear,
    required this.years,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
          () => Container(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: UColors.borderBtn),
          color: Colors.white,
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            isExpanded: true,
            value: selectedYear.value,
            icon: const Icon(Icons.keyboard_arrow_down),
            style: GoogleFonts.plusJakartaSans(
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: UColors.textPrimary,
            ),
            items: years.map((e) {
              return DropdownMenuItem(
                value: e,
                child: Text(e),
              );
            }).toList(),
            onChanged: (val) {
              if (val != null) {
                selectedYear.value = val;
                onChanged(val);
              }
            },
          ),
        ),
      ),
    );
  }
}
