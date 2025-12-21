import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sole/common/widgets/app_btn/app_btn.dart';
import 'package:sole/common/widgets/appbar/appbar.dart';
import 'package:sole/utils/constants/colors.dart';
import 'package:sole/utils/constants/sizes.dart';

class SubscriptionsScreen extends StatelessWidget {
  const SubscriptionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UAppBar(title: Text("Subscription Details"), showBackArrow: true),
      body: IntrinsicHeight(
        child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: USizes.defaultSpace20,
            vertical: USizes.md,
          ),
          padding: EdgeInsets.symmetric(
            vertical: USizes.defaultSpace20,
            horizontal: USizes.md,
          ),
          decoration: BoxDecoration(
            color: UColors.whiteF9F9,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonTextSubText(
                text: 'Status',
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.12), // light green bg
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
              ),
              CommonTextSubText(text: 'Subscription', subText: "Free Trial"),
              CommonTextSubText(text: 'Subscription period', subText: "-"),
              CommonTextSubText(text: 'Next Payment Amount', subText: "-"),
              CommonTextSubText(text: 'Payment frequency', subText: "Monthly"),
              Divider(color: UColors.divider),
              SizedBox(height: USizes.lg),
              SizedBox(
                width: 160,
                child: UButton(onPressed: () {}, label: "Upgrade Plan"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CommonTextSubText extends StatelessWidget {
  final String text;
  final String? subText;
  final Widget? child;

  const CommonTextSubText({
    super.key,
    required this.text,
    this.subText,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: USizes.md - 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /// Left Text
          Text(
            text,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: UColors.textSecondary,
            ),
          ),

          /// Right Side (Text OR Widget)
          if (subText != null && subText!.isNotEmpty)
            Text(
              subText!,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: UColors.textPrimary,
              ),
            )
          else if (child != null)
            child!
          else
            const SizedBox.shrink(),
        ],
      ),
    );
  }
}
