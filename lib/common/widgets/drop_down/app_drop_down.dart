import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sole/utils/constants/colors.dart';

class UDropdownField extends StatefulWidget {
  final String? hintText;
  final List<String> items;
  final String? value;
  final Widget? prefixWidget;
  final ValueChanged<String?>? onChanged;

  const UDropdownField({
    super.key,
    this.hintText,
    required this.items,
    this.value,
    this.prefixWidget,
    this.onChanged,
  });

  @override
  State<UDropdownField> createState() => _UDropdownFieldState();
}

class _UDropdownFieldState extends State<UDropdownField> {
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: _focusNode.hasFocus
            ? [
          BoxShadow(
            color: UColors.primary.withOpacity(0.35),
            blurRadius: 12,
            spreadRadius: 1,
          ),
        ]
            : [],
      ),
      child: DropdownButtonFormField<String>(
        focusNode: _focusNode,
        value: widget.value,
        decoration: InputDecoration(
          filled: true,
          fillColor: UColors.white,
          contentPadding:
          const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          hintText: widget.hintText,
          hintStyle: GoogleFonts.plusJakartaSans(
            fontSize: 13,
            color: UColors.textSecondary,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: UColors.borderBtn),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: UColors.borderBtn,
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: UColors.primary,
              width: 2, // 👈 image jaisa
            ),
          ),
          prefixIcon: widget.prefixWidget,
        ),
        icon: Icon(
          Icons.keyboard_arrow_down_rounded,
          color: UColors.iconA2B3,
        ),
        items: widget.items
            .map(
              (item) => DropdownMenuItem<String>(
            value: item,
            child: Text(
              item,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 14,
                color: UColors.textPrimary,
              ),
            ),
          ),
        )
            .toList(),
        onChanged: widget.onChanged,
      ),
    );
  }
}


// class UDropdownField extends StatelessWidget {
//   final String? hintText;
//   final List<String> items;
//   final String? value;
//   final Widget? prefixWidget;
//   final ValueChanged<String?>? onChanged;
//
//   const UDropdownField({
//     super.key,
//     this.hintText,
//     required this.items,
//     this.value,
//     this.prefixWidget,
//     this.onChanged,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return DropdownButtonFormField<String>(
//       value: value,
//       decoration: InputDecoration(
//         filled: true,
//         fillColor: UColors.white,
//         contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
//         hintText: hintText,
//         hintStyle: GoogleFonts.plusJakartaSans(
//           fontSize: 13,
//           color: UColors.textSecondary,
//         ),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10),
//           borderSide: BorderSide(color: UColors.borderBtn),
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10),
//           borderSide: BorderSide(color: UColors.borderBtn),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10),
//           borderSide: BorderSide(color: UColors.primary, width: 1.5),
//         ),
//         prefixIcon: prefixWidget,
//       ),
//       icon: Icon(
//         Icons.keyboard_arrow_down_rounded,
//         color: UColors.iconA2B3,
//       ),
//       items: items
//           .map(
//             (item) => DropdownMenuItem<String>(
//           value: item,
//           child: Text(
//             item,
//             style: GoogleFonts.plusJakartaSans(
//               fontSize: 14,
//               color: UColors.textPrimary,
//             ),
//           ),
//         ),
//       )
//           .toList(),
//       onChanged: onChanged,
//     );
//   }
// }
