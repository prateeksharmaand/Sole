import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sole/utils/constants/colors.dart';

class UDropDown<T> extends StatelessWidget {
  final String? label; // ✅ nullable
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?> onChanged;
  final String? hint;
  final bool isExpanded;
  final EdgeInsetsGeometry? padding;

  const UDropDown({
    Key? key,
    this.label, // ✅ optional
    required this.items,
    required this.onChanged,
    this.value,
    this.hint,
    this.isExpanded = true,
    this.padding,
  }) : super(key: key);

  bool get _showLabel =>
      label != null && label!.trim().isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// 🔤 Label (only if not null or empty)
          if (_showLabel) ...[
            Text(
              label!,
              style: GoogleFonts.plusJakartaSans(
                color: UColors.textSecondary,
                fontWeight: FontWeight.w500,
                fontSize: 14
              ),
            ),
            const SizedBox(height: 12),
          ],

          /// 🔽 Dropdown with underline
          DropdownButtonFormField<T>(
            value: value,
            isExpanded: isExpanded,
            hint: hint != null ? Text(hint!) : null,
            items: items,
            onChanged: onChanged,

            style: GoogleFonts.plusJakartaSans(fontSize: 14,color: UColors.textPrimary),
            icon: Icon(Icons.keyboard_arrow_down_outlined),
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.zero,
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: UColors.primary, width: 1),
              ),
            ),
          ),
        ],
      ),
    );
  }
}