import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sole/utils/constants/colors.dart';
import 'package:sole/utils/constants/sizes.dart';
import 'package:sole/utils/helpers/helper_functions.dart';
import 'create_quote_controller.dart';

class CreateQuotesScreen extends StatelessWidget {
  const CreateQuotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CreateQuoteController());
    final dark = UHelperFunctions.isDarkMode(context);

    return Scaffold(
      backgroundColor: dark ? UColors.black : UColors.bg,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: dark ? UColors.dark : UColors.white,
        elevation: 0,
        title: Row(
          children: [
            IconButton(
              onPressed: () => Get.back(),
              icon: const Icon(Icons.arrow_back, color: UColors.textPrimary),
            ),
            const Expanded(
              child: Center(
                child: Text(
                  'Create Quotes',
                  style: TextStyle(
                    color: UColors.textPrimary,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            TextButton(
              onPressed: () {},
              child: const Text(
                'PREVIEW',
                style: TextStyle(
                  color: Color(0xFF373DFF),
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 1. Client Information
            _buildSectionHeader("Client Information"),
            _buildCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(USizes.md),
                    decoration: BoxDecoration(
                      color: dark ? UColors.black : const Color(0xFFF9FAFB),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "From",
                          style: TextStyle(
                            color: UColors.textSecondary,
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(height: 6),
                        Text(
                          "123456789AB 220 Spencer St 3000 Australia",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: UColors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Obx(
                    () => _buildUnderlineField(
                      label: "To Client",
                      value: controller.selectedClient.value,
                      dark: dark,
                      onTap: () {
                        _showSelectionDialog(
                          context: context,
                          title: "Select Client",
                          options: ["Sarah Emily", "John Doe", "Jane Smith"],
                          onSelect: (val) =>
                              controller.selectedClient.value = val,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            /// 2. Invoice Details
            _buildSectionHeader("Invoice Details"),
            _buildCard(
              child: Column(
                children: [
                  Obx(
                    () => _buildUnderlineField(
                      label: "Quote Number",
                      value: controller.quoteNumber.value,
                      dark: dark,
                      onTap: () {
                        _showSelectionDialog(
                          context: context,
                          title: "Select Quote Number",
                          options: ["QUO-000134", "QUO-000135", "QUO-000136"],
                          onSelect: (val) => controller.quoteNumber.value = val,
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  Obx(
                    () => _buildUnderlineField(
                      label: "Quote Date",
                      value: controller.quoteDate.value,
                      icon: Iconsax.calendar_1,
                      dark: dark,
                      onTap: () =>
                          controller.selectDate(context, controller.quoteDate),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Obx(
                    () => _buildUnderlineField(
                      label: "Quote Expiry Date",
                      value: controller.quoteExpiryDate.value,
                      icon: Iconsax.calendar_1,
                      dark: dark,
                      onTap: () => controller.selectDate(
                        context,
                        controller.quoteExpiryDate,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Obx(
                    () => _buildUnderlineField(
                      label: "Project Code",
                      value: controller.projectCode.value,
                      dark: dark,
                      onTap: () {
                        _showSelectionDialog(
                          context: context,
                          title: "Select Project Code",
                          options: ["PRJ-2025-09-001", "PRJ-2025-09-002"],
                          onSelect: (val) => controller.projectCode.value = val,
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  Obx(
                    () => _buildUnderlineField(
                      label: "Job Code",
                      value: controller.jobCode.value,
                      dark: dark,
                      onTap: () {
                        _showSelectionDialog(
                          context: context,
                          title: "Select Job Code",
                          options: ["JOB-3421", "JOB-3422", "JOB-3423"],
                          onSelect: (val) => controller.jobCode.value = val,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            /// 3. Item / Service List
            _buildSectionHeader("Item / Service List"),
            _buildCard(
              child: Column(
                children: [
                  Obx(
                    () => ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.items.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final item = controller.items[index];
                        return _buildQuoteItemRow(
                          item,
                          () => controller.removeItem(index),
                          dark,
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  OutlinedButton(
                    onPressed: () => controller.addItem(),
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 48),
                      side: const BorderSide(color: Color(0xFF373DFF)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add, size: 18, color: Color(0xFF373DFF)),
                        SizedBox(width: 8),
                        Text(
                          "Add Item",
                          style: TextStyle(
                            color: Color(0xFF373DFF),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Divider(color: UColors.borderPrimary),
                  const SizedBox(height: 16),
                  Obx(
                    () => Column(
                      children: [
                        _buildSummaryRow(
                          "Subtotal",
                          "\$${controller.subtotal.toStringAsFixed(2)}",
                        ),
                        _buildSummaryRow(
                          "Discount",
                          "\$${controller.discount.toStringAsFixed(2)}",
                        ),
                        _buildSummaryRow(
                          "GST",
                          "\$${controller.gst.toStringAsFixed(2)}",
                        ),
                        const SizedBox(height: 12),
                        const Divider(color: UColors.borderPrimary),
                        const SizedBox(height: 12),
                        _buildSummaryRow(
                          "Total",
                          "\$${controller.total.toStringAsFixed(2)}",
                          isTotal: true,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            /// 4. Payment Details
            _buildSectionHeader("Payment Details"),
            _buildCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(USizes.md),
                    decoration: BoxDecoration(
                      color: dark ? UColors.black : const Color(0xFFF9FAFB),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Please make payments via direct deposit to",
                          style: TextStyle(
                            color: UColors.textSecondary,
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(height: 12),
                        _buildPaymentRow("Acc Name:", "Dummy"),
                        const SizedBox(height: 6),
                        _buildPaymentRow("BSB:", "XXXX3434"),
                        const SizedBox(height: 6),
                        _buildPaymentRow("Acc No:", "XXXX3434"),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: UColors.borderPrimary.withValues(alpha: 0.8),
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Text(
                            "worldpay",
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: Text(
                            "Accept card payment via Worldpay",
                            style: TextStyle(
                              fontSize: 14,
                              color: UColors.textPrimary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            /// 5. Notes & Switches
            _buildSwitchSection(
              title: "Quote notes",
              value: controller.showQuoteNotes,
              textController: controller.quoteNotesController,
              dark: dark,
            ),
            _buildSwitchSection(
              title: "Display Custom Note?",
              value: controller.showCustomNote,
              textController: controller.customNoteController,
              dark: dark,
            ),

            const SizedBox(height: 120), // Bottom padding for sticky buttons
          ],
        ),
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.fromLTRB(
          USizes.defaultSpace,
          12,
          USizes.defaultSpace,
          24,
        ),
        decoration: BoxDecoration(
          color: dark ? UColors.dark : UColors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () => controller.saveAsDraft(),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 54),
                  side: const BorderSide(color: UColors.borderPrimary),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Save ad Draft",
                  style: TextStyle(
                    color: UColors.textSecondary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ElevatedButton(
                onPressed: () => controller.saveAndSend(),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 54),
                  backgroundColor: const Color(0xFF373DFF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Save & Send",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        USizes.defaultSpace,
        28,
        USizes.defaultSpace,
        12,
      ),
      child: Row(
        children: [
          const Icon(Icons.circle, size: 8, color: Color(0xFF373DFF)),
          const SizedBox(width: 12),
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: UColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard({required Widget child}) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(
        horizontal: USizes.defaultSpace,
        vertical: 4,
      ),
      padding: const EdgeInsets.all(USizes.md),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: UColors.borderPrimary.withValues(alpha: 0.3)),
      ),
      child: child,
    );
  }

  Widget _buildUnderlineField({
    required String label,
    required String value,
    IconData? icon,
    VoidCallback? onTap,
    bool dark = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.only(bottom: 8),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: UColors.borderPrimary, width: 0.8),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                color: UColors.textSecondary,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                if (icon != null) ...[
                  Icon(icon, size: 18, color: UColors.textSecondary),
                  const SizedBox(width: 10),
                ],
                Expanded(
                  child: Text(
                    value,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: UColors.textPrimary,
                    ),
                  ),
                ),
                const Icon(
                  Icons.keyboard_arrow_down,
                  color: UColors.textSecondary,
                  size: 20,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuoteItemRow(QuoteItem item, VoidCallback onDelete, bool dark) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            border: Border.all(
              color: UColors.borderPrimary.withValues(alpha: 0.8),
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFFF0F0FF),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Iconsax.document_text,
                  color: Color(0xFF373DFF),
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: UColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "${item.quantity} x \$${item.price.toStringAsFixed(0)}",
                      style: const TextStyle(
                        color: UColors.textSecondary,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                "\$${item.total.toStringAsFixed(0)}",
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: UColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: -6,
          right: -6,
          child: GestureDetector(
            onTap: onDelete,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.close, size: 10, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: isTotal ? UColors.textPrimary : UColors.textSecondary,
              fontSize: isTotal ? 16 : 14,
              fontWeight: isTotal ? FontWeight.w700 : FontWeight.w500,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: UColors.textPrimary,
              fontSize: isTotal ? 16 : 14,
              fontWeight: isTotal ? FontWeight.w800 : FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentRow(String label, String value) {
    return Row(
      children: [
        SizedBox(
          width: 85,
          child: Text(
            label,
            style: const TextStyle(
              color: UColors.textSecondary,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: UColors.textPrimary,
          ),
        ),
      ],
    );
  }

  Widget _buildSwitchSection({
    required String title,
    required RxBool value,
    required TextEditingController textController,
    required bool dark,
  }) {
    return _buildCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: UColors.textPrimary,
                ),
              ),
              Obx(
                () => Switch(
                  value: value.value,
                  onChanged: (v) => value.value = v,
                  activeColor: const Color(0xFF373DFF),
                ),
              ),
            ],
          ),
          Obx(
            () => value.value
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),
                      TextField(
                        controller: textController,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: UColors.textPrimary,
                        ),
                        maxLines: null,
                        decoration: const InputDecoration(
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
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF373DFF)),
                          ),
                          hintText: "Type notes...",
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(vertical: 8),
                        ),
                      ),
                    ],
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  void _showSelectionDialog({
    required BuildContext context,
    required String title,
    required List<String> options,
    required Function(String) onSelect,
  }) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: UColors.textPrimary,
                ),
              ),
              const SizedBox(height: 24),
              Flexible(
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: options.length,
                  separatorBuilder: (_, __) => const Divider(height: 1),
                  itemBuilder: (context, index) => ListTile(
                    title: Text(
                      options[index],
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    onTap: () {
                      onSelect(options[index]);
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }
}
