import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sole/common/widgets/appbar/appbar.dart';
import 'package:sole/common/widgets/switch_btn/switch_btn.dart';
import 'package:sole/features/dashboard/pages/reports/profit_loss/profit_loss_controller.dart';
import 'package:sole/utils/constants/colors.dart';
import 'package:sole/utils/constants/sizes.dart';

class SendReportScreen extends StatelessWidget {
  const SendReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProfitLossController>();

    return Scaffold(
      appBar: const UAppBar(title: Text('Send Report'), showBackArrow: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(USizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Send to', style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: USizes.sm),
            TextField(
              controller: controller.sendToController,
              decoration: const InputDecoration(
                hintText: 'eg., johndoe@example.com',
                prefixIcon: Icon(Iconsax.sms),
              ),
            ),
            const SizedBox(height: USizes.spaceBtwSections),

            // Accountant Section
            _buildRecipientSection(
              context,
              title: 'Send this report to your accountant?',
              toggle: controller.sendToAccountant,
              nameController: controller.selectedAccountant,
              emailController: controller.accountantEmailController,
              role: 'Accountant',
            ),
            const SizedBox(height: USizes.spaceBtwSections),

            // Bookkeeper Section
            _buildRecipientSection(
              context,
              title: 'Send this report to your bookkeeper?',
              toggle: controller.sendToBookkeeper,
              nameController: controller.selectedBookkeeper,
              emailController: controller.bookkeeperEmailController,
              role: 'Bookkeeper',
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(USizes.defaultSpace),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: controller.submitSendReport,
            child: const Text('Send'),
          ),
        ),
      ),
    );
  }

  Widget _buildRecipientSection(
    BuildContext context, {
    required String title,
    required RxBool toggle,
    required Rx<String?> nameController,
    required TextEditingController emailController,
    required String role,
  }) {
    return Obx(
      () => Container(
        padding: const EdgeInsets.all(USizes.md),
        decoration: BoxDecoration(
          color: UColors.grey.withOpacity(0.05),
          borderRadius: BorderRadius.circular(USizes.cardRadiusMd),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
                USwitch(
                  value: toggle.value,
                  onChanged: (val) => toggle.value = val,
                ),
              ],
            ),
            if (toggle.value) ...[
              const SizedBox(height: USizes.spaceBtwItems),
              Text('$role Name', style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: USizes.sm),
              Container(
                decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(color: UColors.borderEEF1)),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: nameController.value,
                    isExpanded: true,
                    hint: Text(
                      'Select $role',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: UColors.textSecondary,
                      ),
                    ),
                    items: ['Jane Doe', 'John Smith']
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                    onChanged: (val) {
                      nameController.value = val;
                    },
                    icon: const Icon(Iconsax.arrow_down_1, size: 18),
                  ),
                ),
              ),
              const SizedBox(height: USizes.spaceBtwItems),
              Text(
                '$role Email',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: USizes.sm),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  hintText: 'eg., ${role.toLowerCase()}@example.com',
                  border: const UnderlineInputBorder(
                    borderSide: BorderSide(color: UColors.borderEEF1),
                  ),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: UColors.borderEEF1),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: UColors.primary),
                  ),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
