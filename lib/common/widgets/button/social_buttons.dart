import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sole/utils/constants/colors.dart';
import 'package:sole/utils/constants/images.dart';
import 'package:sole/utils/constants/sizes.dart';

class SocialAccountBtn extends StatelessWidget {
  const SocialAccountBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        _SocialBtn(icon: UImages.googleIcon),
        SizedBox(width: USizes.sm * 1.5),
        _SocialBtn(icon: UImages.facebookIcon),
        SizedBox(width: USizes.sm * 1.5),
        _SocialBtn(icon: UImages.appleIcon),
      ],
    );
  }
}

class _SocialBtn extends StatelessWidget {
  final String icon;
  final VoidCallback? onTap;

  const _SocialBtn({
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: USizes.sm * 1.5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: UColors.borderECF0,
              width: 1,
            ),
          ),
          child: Center(
            child: SvgPicture.asset(
              icon,
              height: 22,
            ),
          ),
        ),
      ),
    );
  }
}
