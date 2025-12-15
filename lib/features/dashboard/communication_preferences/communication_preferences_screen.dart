import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sole/common/widgets/appbar/appbar.dart';
import 'package:sole/common/widgets/switch_btn/switch_btn.dart';
import 'package:sole/utils/constants/colors.dart';
import 'package:sole/utils/constants/sizes.dart';

class CommunicationPreferencesScreen extends StatelessWidget {
  const CommunicationPreferencesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UAppBar(
        title: Text("Communication Preferences"),
        showBackArrow: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(USizes.defaultSpace20),
        child: Column(
          children: [
            CommonTextSubTextAndSwitch(
              text: 'Invoice',
              subText:
                  'Would you like to receive a BCC email when Sole sends any invoice related emails to customers?',
              value: true,
              onChanged: (bool value) {},
            ),
            CommonTextSubTextAndSwitch(
              text: 'Quote',
              subText:
                  'Would you like to receive a BCC email when Sole sends any quote related emails to customers?',
              value: true,
              onChanged: (bool value) {},
            ),
            Divider(color: UColors.divider),
            SizedBox(height: USizes.md),
            CommonTextSubTextAndSwitch(
              text: 'Invoice Due Reminder',
              subText:
                  "Would you like Sole to automatically send your customers a reminder when an invoice is approaching it's due date?",
              value: true,
              onChanged: (bool value) {},
            ),
            CommonTextSubTextAndSwitch(
              text: 'Invoice Overdue Reminder',
              subText:
                  'Would you like Sole to automatically send your customers a reminder when an invoice is overdue?',
              value: true,
              onChanged: (bool value) {},
            ),
            CommonTextSubTextAndSwitch(
              text: 'Quote Expiry Reminder',
              subText:
                  'Would you like Sole to automatically send your customers a reminder when a quote is approaching expiry?',
              value: true,
              onChanged: (bool value) {},
            ),
          ],
        ),
      ),
    );
  }
}

class CommonTextSubTextAndSwitch extends StatelessWidget {
  final String text;
  final String subText;
  final bool value;
  final ValueChanged<bool> onChanged;
  const CommonTextSubTextAndSwitch({
    super.key,
    required this.text,
    required this.subText,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: USizes.xl),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  text,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: UColors.textPrimary,
                  ),
                ),
                SizedBox(height: USizes.sm),
                Text(
                  subText,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: UColors.textA4A6,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: USizes.sm),
          USwitch(value: value, onChanged: onChanged),
        ],
      ),
    );
  }
}
