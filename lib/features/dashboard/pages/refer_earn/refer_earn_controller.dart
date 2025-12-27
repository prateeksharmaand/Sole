import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'referral_model.dart';

class ReferEarnController extends GetxController {
  final inviteEmailController = TextEditingController();

  // Stats
  final totalEarnings = 120.0.obs;
  final totalInvited = 42.obs;
  final completedReferrals = 20.obs;
  final pendingReferrals = 192.obs;

  // Toggle for empty state demo
  final hasReferrals = true.obs;

  final referrals = <ReferralModel>[
    ReferralModel(
      email: 'johndoe@gmail.com',
      date: '23 Sep 2025 - 04:29 AM',
      status: 'Pending',
      statusMessage: 'Awaiting join',
    ),
    ReferralModel(
      email: 'johndoe@gmail.com',
      date: '23 Sep 2025 - 04:29 AM',
      status: 'Completed',
      statusMessage: '30 days left',
    ),
    ReferralModel(
      email: 'johndoe@gmail.com',
      date: '23 Sep 2025 - 04:29 AM',
      status: 'Active',
      statusMessage: 'Credited 05 Jan',
    ),
  ].obs;

  @override
  void onClose() {
    inviteEmailController.dispose();
    super.onClose();
  }

  void sendInvite() {
    if (inviteEmailController.text.isNotEmpty) {
      Get.snackbar('Success', 'Invite sent to ${inviteEmailController.text}');
      inviteEmailController.clear();
    }
  }

  void withdrawEarnings() {
    Get.snackbar('Withdraw', 'Withdrawal request initiated');
  }
}
