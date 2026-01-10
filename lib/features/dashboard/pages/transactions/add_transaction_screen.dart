import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sole/data/models/client_model.dart';
import 'package:sole/utils/constants/colors.dart';
import 'package:sole/utils/constants/sizes.dart';
import 'package:sole/utils/helpers/helper_functions.dart';
import 'add_transaction_controller.dart';

class AddTransactionScreen extends StatelessWidget {
  const AddTransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = UHelperFunctions.isDarkMode(context);
    final controller = Get.put(AddTransactionController());

    return Scaffold(
      backgroundColor: dark ? UColors.black : UColors.bg,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text(
          'Add Transaction',
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: dark ? UColors.white : UColors.black,
      ),
      body: Form(
        key: controller.formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(USizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Transaction Type (TextField as per requirement)
              _buildLabel(context, 'Transaction Type'),
              const SizedBox(height: 8),
              TextFormField(
                controller: controller.transactionTypeController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: '1',
                  hintStyle: TextStyle(
                    color: UColors.textSecondary.withValues(alpha: 0.5),
                  ),
                  fillColor: Colors.transparent,
                  filled: true,
                  border: const UnderlineInputBorder(
                    borderSide: BorderSide(color: UColors.borderPrimary),
                  ),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: UColors.borderPrimary),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: UColors.primary),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter transaction type';
                  }
                  return null;
                },
              ),
              const SizedBox(height: USizes.spaceBtwInputFields),

              /// Choose Account
              _buildLabel(context, 'Choose Account'),
              const SizedBox(height: 8),
              _buildDropdown(
                context,
                hint: 'Select account',
                items: ['Full-time Employee Acc', 'Savings Account'],
                onChanged: (val) =>
                    controller.selectedAccount.value = val ?? '',
              ),
              const SizedBox(height: USizes.spaceBtwInputFields),

              /// Amount
              _buildLabel(context, 'Amount'),
              const SizedBox(height: 8),
              TextFormField(
                controller: controller.amountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  prefixText: '\$ ',
                  hintText: '0.00',
                  hintStyle: TextStyle(
                    color: UColors.textSecondary.withValues(alpha: 0.5),
                  ),
                  fillColor: Colors.transparent,
                  filled: true,
                  border: const UnderlineInputBorder(
                    borderSide: BorderSide(color: UColors.borderPrimary),
                  ),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: UColors.borderPrimary),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: UColors.primary),
                  ),
                ),
              ),
              const SizedBox(height: USizes.spaceBtwInputFields),

              /// Transaction Date
              _buildLabel(context, 'Transaction Date'),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () => _selectDate(context, controller),
                child: AbsorbPointer(
                  child: TextFormField(
                    controller: controller.dateController,
                    decoration: InputDecoration(
                      hintText: 'Select date',
                      prefixIcon: const Icon(
                        Icons.calendar_today_outlined,
                        size: 20,
                      ),
                      hintStyle: TextStyle(
                        color: UColors.textSecondary.withValues(alpha: 0.5),
                      ),
                      fillColor: Colors.transparent,
                      filled: true,
                      border: const UnderlineInputBorder(
                        borderSide: BorderSide(color: UColors.borderPrimary),
                      ),
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: UColors.borderPrimary),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: USizes.spaceBtwInputFields),

              /// Name of Client (from API)
              _buildLabel(context, 'Name of Client'),
              const SizedBox(height: 8),
              Obx(
                () => controller.isLoading.value
                    ? const Center(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      )
                    : DropdownButtonFormField<ClientDetails>(
                        decoration: const InputDecoration(
                          fillColor: Colors.transparent,
                          filled: true,
                          contentPadding: EdgeInsets.zero,
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: UColors.borderPrimary,
                            ),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: UColors.borderPrimary,
                            ),
                          ),
                        ),
                        hint: Text(
                          'Select Client',
                          style: TextStyle(
                            color: UColors.textSecondary.withValues(alpha: 0.5),
                          ),
                        ),
                        value: controller.selectedClient.value,
                        items: controller.clientsList
                            .map(
                              (client) => DropdownMenuItem<ClientDetails>(
                                value: client,
                                child: Text(client.name),
                              ),
                            )
                            .toList(),
                        onChanged: (client) {
                          controller.selectedClient.value = client;
                        },
                        icon: const Icon(
                          Icons.keyboard_arrow_down,
                          color: UColors.textSecondary,
                        ),
                      ),
              ),
              const SizedBox(height: USizes.spaceBtwInputFields),

              /// Description
              _buildLabel(context, 'Description'),
              const SizedBox(height: 8),
              TextFormField(
                controller: controller.descriptionController,
                decoration: InputDecoration(
                  hintText: 'Type description',
                  hintStyle: TextStyle(
                    color: UColors.textSecondary.withValues(alpha: 0.5),
                  ),
                  fillColor: Colors.transparent,
                  filled: true,
                  border: const UnderlineInputBorder(
                    borderSide: BorderSide(color: UColors.borderPrimary),
                  ),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: UColors.borderPrimary),
                  ),
                ),
              ),
              const SizedBox(height: USizes.spaceBtwInputFields),

              /// Include GST Switch
              Row(
                children: [
                  Obx(
                    () => CupertinoSwitch(
                      value: controller.includeGST.value,
                      onChanged: (val) => controller.includeGST.value = val,
                      activeColor: UColors.primary,
                      trackColor: dark ? Colors.grey[800] : Colors.grey[300],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Include GST (10%)',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: USizes.spaceBtwSections),

              /// Match this manual transaction section
              Container(
                padding: const EdgeInsets.all(USizes.md),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: UColors.borderPrimary.withValues(alpha: 0.5),
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(
                      () => Checkbox(
                        value: controller.matchTransaction.value,
                        onChanged: (val) =>
                            controller.matchTransaction.value = val ?? false,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Match this manual transaction',
                            style: Theme.of(context).textTheme.titleSmall
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'When enabled, you can match this entry to existing invoices, expenses or assets. Selecting rows below will auto-fill amount, date and description for you.',
                            style: Theme.of(context).textTheme.labelMedium
                                ?.copyWith(
                                  color: UColors.textSecondary,
                                  height: 1.4,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: USizes.spaceBtwSections),

              /// Save Button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: Obx(
                  () => ElevatedButton(
                    onPressed: controller.isSaving.value
                        ? null
                        : () => controller.saveTransaction(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: UColors.primary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: controller.isSaving.value
                        ? const SizedBox(
                            height: 24,
                            width: 24,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Text(
                            'Save',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),
              ),
              const SizedBox(height: USizes.spaceBtwSections),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(BuildContext context, String text) {
    return Text(
      text,
      style: Theme.of(context).textTheme.titleSmall?.copyWith(
        color: UColors.textSecondary,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _buildDropdown(
    BuildContext context, {
    required String hint,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return DropdownButtonFormField<String>(
      decoration: const InputDecoration(
        fillColor: Colors.transparent,
        filled: true,
        contentPadding: EdgeInsets.zero,
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: UColors.borderPrimary),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: UColors.borderPrimary),
        ),
      ),
      hint: Text(
        hint,
        style: TextStyle(color: UColors.textSecondary.withValues(alpha: 0.5)),
      ),
      items: items
          .map((e) => DropdownMenuItem(value: e, child: Text(e)))
          .toList(),
      onChanged: onChanged,
      icon: const Icon(Icons.keyboard_arrow_down, color: UColors.textSecondary),
    );
  }

  Future<void> _selectDate(
    BuildContext context,
    AddTransactionController controller,
  ) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      controller.dateController.text = UHelperFunctions.getFormattedDate(
        picked,
        format: 'dd MMM, yyyy',
      );
    }
  }
}

// Controller moved to add_transaction_controller.dart
