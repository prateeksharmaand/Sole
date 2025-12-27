import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sole/utils/constants/colors.dart';
import 'package:sole/utils/constants/images.dart';
import 'package:sole/utils/constants/sizes.dart';
import 'package:sole/utils/helpers/helper_functions.dart';
import 'package:sole/routes/routes.dart';
import 'quotes_controller.dart';
import 'models/quote_model.dart';
import 'package:sole/common/widgets/textfields/app_text_fields.dart';

class QuotesScreen extends StatelessWidget {
  const QuotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(QuotesController());
    final dark = UHelperFunctions.isDarkMode(context);

    return Scaffold(
      backgroundColor: dark ? UColors.black : UColors.bg,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back, color: UColors.text1828),
        ),
        title: const Text(
          'Quotes',
          style: TextStyle(
            color: UColors.text1828,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: USizes.defaultSpace20,
          ),
          child: Column(
            children: [
              const SizedBox(height: 12),

              /// 1. Summary Card
              _buildSummaryCard(context, controller, dark),

              const SizedBox(height: 24),

              /// 2. Search and Action Bar
              _buildSearchBar(context, controller, dark),

              const SizedBox(height: 20),

              /// 3. Quotes List
              Obx(() {
                if (controller.quotes.isEmpty) {
                  return _buildEmptyState(context);
                }
                return ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.quotes.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    return _buildQuoteCard(
                      context,
                      controller.quotes[index],
                      dark,
                    );
                  },
                );
              }),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(URoutes.createQuote),
        backgroundColor: UColors.blue373D,
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildSummaryCard(
    BuildContext context,
    QuotesController controller,
    bool dark,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(USizes.md),
      decoration: BoxDecoration(
        color: dark ? UColors.dark : UColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: UColors.borderPrimary.withValues(alpha: 0.5)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          /// Dropdown
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              border: Border.all(color: UColors.borderPrimary),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Obx(
              () => Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    controller.selectedTimeRange.value,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: UColors.textSecondary,
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Icon(
                    Icons.keyboard_arrow_down,
                    size: 16,
                    color: UColors.textSecondary,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            "Total Quotes",
            style: TextStyle(
              color: UColors.textSecondary,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Obx(
            () => Text(
              "\$${controller.totalQuotesAmount.value}",
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w700,
                color: UColors.text1828,
              ),
            ),
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: UColors.greenFBF5,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Obx(
                  () => Row(
                    children: [
                      const Icon(
                        Icons.arrow_upward,
                        size: 12,
                        color: UColors.green7F67,
                      ),
                      const SizedBox(width: 2),
                      Text(
                        controller.vsLastMonth.value.replaceAll(" ", ""),
                        style: const TextStyle(
                          color: UColors.green7F67,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                "vs last month",
                style: TextStyle(
                  color: UColors.textSecondary,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Divider(height: 1, color: Colors.grey.withValues(alpha: 0.1)),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatSubItem(
                "Converted",
                controller.convertedAmount.value,
                UColors.blue373D,
              ),
              _buildVerticalDivider(),
              _buildStatSubItem(
                "Pending",
                controller.pendingAmount.value,
                UColors.warning,
              ),
              _buildVerticalDivider(),
              _buildStatSubItem(
                "Overdue",
                controller.overdueAmount.value,
                UColors.red4954,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatSubItem(String label, String amount, Color color) {
    IconData icon;
    if (label == "Converted")
      icon = Iconsax.dollar_circle;
    else if (label == "Pending")
      icon = Iconsax.clock;
    else
      icon = Iconsax.info_circle;

    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 14, color: color),
            const SizedBox(width: 4),
            Text(
              label,
              style: const TextStyle(
                color: UColors.textSecondary,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          "\$$amount",
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: UColors.text1828,
          ),
        ),
      ],
    );
  }

  Widget _buildVerticalDivider() {
    return Container(
      width: 1,
      height: 32,
      color: UColors.disableD0D5.withValues(alpha: 0.3),
    );
  }

  Widget _buildSearchBar(
    BuildContext context,
    QuotesController controller,
    bool dark,
  ) {
    return Row(
      children: [
        Expanded(
          child: UTextField(
            hintText: "Search quotes...",
            onchanged: (v) => controller.filterQuotes(v),
            borderRadius: 12,
            borderColor: UColors.disableD0D5,
            fillColor: Colors.white,
            prefixWidget: const Padding(
              padding: EdgeInsets.only(left: 12.0),
              child: Icon(Icons.search, color: UColors.text8C98, size: 22),
            ),
          ),
        ),
        const SizedBox(width: 10),
        _buildActionIcon(UImages.filter3LineIcon),
        const SizedBox(width: 10),
        _buildActionIcon(UImages.downloadIcon),
      ],
    );
  }

  Widget _buildActionIcon(String iconPath) {
    return Container(
      height: 50,
      width: 50,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: UColors.disableD0D5),
      ),
      child: SvgPicture.asset(
        iconPath,
        colorFilter: const ColorFilter.mode(UColors.text8C98, BlendMode.srcIn),
      ),
    );
  }

  Widget _buildQuoteCard(BuildContext context, QuoteModel quote, bool dark) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.withValues(alpha: 0.1)),
      ),
      child: Row(
        children: [
          Container(
            height: 48,
            width: 48,
            decoration: BoxDecoration(
              color: const Color(0xFFF5F5FF),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: SvgPicture.asset(
                UImages.documentIcon2,
                height: 22,
                width: 22,
                colorFilter: const ColorFilter.mode(
                  UColors.blue373D,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  quote.customerName,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: UColors.text1828,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      quote.quoteId,
                      style: const TextStyle(
                        color: UColors.text8C98,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(width: 6),
                    const Icon(
                      Icons.circle,
                      size: 4,
                      color: UColors.disableD0D5,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      quote.date,
                      style: const TextStyle(
                        color: UColors.text8C98,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "\$${quote.amount.toStringAsFixed(0)}",
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: UColors.text1828,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: quote.status.backgroundColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  quote.status.name,
                  style: TextStyle(
                    color: quote.status.color,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const SizedBox(height: 80),
          Container(
            height: 80,
            width: 80,
            decoration: const BoxDecoration(
              color: UColors.whiteF9F9,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: SvgPicture.asset(
                UImages.documentIcon,
                height: 32,
                colorFilter: const ColorFilter.mode(
                  UColors.iconA2B3,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            "No quotes yet",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: UColors.text1828,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            "Create and send your first quote to\nstart winning clients.",
            textAlign: TextAlign.center,
            style: TextStyle(color: UColors.text8C98, fontSize: 13),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: 180,
            child: ElevatedButton(
              onPressed: () => Get.toNamed(URoutes.createQuote),
              style: ElevatedButton.styleFrom(
                backgroundColor: UColors.blue373D,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add, color: Colors.white, size: 18),
                  SizedBox(width: 8),
                  Text(
                    "Create Quote",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
