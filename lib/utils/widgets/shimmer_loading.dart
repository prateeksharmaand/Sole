import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../constants/colors.dart';

/// Shimmer loading widgets for various screens
class UShimmer {
  /// Dashboard shimmer loading
  static Widget dashboardLoading(BuildContext context, {required bool dark}) {
    return SingleChildScrollView(
      child: Stack(
        children: [
          /// 1. Purple Header Background
          Container(
            height: 280,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 60),
            color: UColors.primary,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Logo shimmer
                _buildShimmerBox(
                  50,
                  50,
                  BorderRadius.circular(12),
                  forHeader: true,
                ),
                Row(
                  children: [
                    // Notification icon shimmer
                    _buildShimmerBox(
                      40,
                      40,
                      BorderRadius.circular(20),
                      forHeader: true,
                    ),
                    const SizedBox(width: 12),
                    // Profile icon shimmer
                    _buildShimmerBox(
                      40,
                      40,
                      BorderRadius.circular(20),
                      forHeader: true,
                    ),
                  ],
                ),
              ],
            ),
          ),

          /// 2. Overlapping Balance Card with Actions
          Padding(
            padding: const EdgeInsets.only(top: 110, left: 16, right: 16),
            child: Column(
              children: [
                // Balance Card
                _buildCardShimmer(
                  dark,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Balance Header Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildShimmerBox(14, 120, BorderRadius.circular(4)),
                          _buildShimmerBox(28, 60, BorderRadius.circular(8)),
                        ],
                      ),
                      const SizedBox(height: 8),
                      // Balance Amount
                      _buildShimmerBox(28, 150, BorderRadius.circular(4)),
                      const SizedBox(height: 20),
                      // Action Grid (3x2)
                      GridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: 3,
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                        childAspectRatio: 1.0,
                        children: List.generate(
                          6,
                          (_) => Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _buildShimmerBox(
                                56,
                                56,
                                BorderRadius.circular(28),
                              ),
                              const SizedBox(height: 8),
                              _buildShimmerBox(
                                10,
                                50,
                                BorderRadius.circular(4),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Financial Stats Section (Revenue, Expenses, Profit, Tax)
                _buildCardShimmer(
                  dark,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: List.generate(
                      4,
                      (_) => Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Column(
                            children: [
                              _buildShimmerBox(
                                12,
                                double.infinity,
                                BorderRadius.circular(4),
                              ),
                              const SizedBox(height: 8),
                              _buildShimmerBox(
                                20,
                                double.infinity,
                                BorderRadius.circular(4),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Transactions Section
                _buildCardShimmer(
                  dark,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildShimmerBox(18, 100, BorderRadius.circular(4)),
                          _buildShimmerBox(14, 60, BorderRadius.circular(4)),
                        ],
                      ),
                      const SizedBox(height: 16),
                      // Transaction items
                      ...List.generate(
                        3,
                        (_) => Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: _buildTransactionItemShimmer(),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Invoice Stats Section
                _buildCardShimmer(
                  dark,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildShimmerBox(18, 100, BorderRadius.circular(4)),
                      const SizedBox(height: 16),
                      // 2x2 Grid for invoice stats
                      GridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: 2,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 16,
                        childAspectRatio: 2.5,
                        children: List.generate(
                          4,
                          (_) => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildShimmerBox(
                                12,
                                80,
                                BorderRadius.circular(4),
                              ),
                              const SizedBox(height: 8),
                              _buildShimmerBox(
                                20,
                                100,
                                BorderRadius.circular(4),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 100), // Space for FAB
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Transaction list shimmer loading
  static Widget transactionListLoading(
    BuildContext context, {
    required bool dark,
  }) {
    return Column(
      children: [
        const SizedBox(height: 16),
        // Bank account cards shimmer
        SizedBox(
          height: 180,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: 2,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (_, __) =>
                _buildCardShimmer(dark, width: 300, height: 180),
          ),
        ),
        const SizedBox(height: 20),
        // Search bar shimmer
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Expanded(
                child: _buildShimmerBox(
                  50,
                  double.infinity,
                  BorderRadius.circular(12),
                ),
              ),
              const SizedBox(width: 12),
              _buildShimmerBox(50, 50, BorderRadius.circular(12)),
            ],
          ),
        ),
        const SizedBox(height: 16),
        // Tabs shimmer
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              _buildShimmerBox(28, 100, BorderRadius.circular(30)),
              const SizedBox(width: 12),
              _buildShimmerBox(28, 100, BorderRadius.circular(30)),
            ],
          ),
        ),
        const SizedBox(height: 20),
        // Transaction items shimmer
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: _buildCardShimmer(
              dark,
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 5,
                separatorBuilder: (_, __) => const Divider(height: 32),
                itemBuilder: (_, __) => _buildTransactionItemShimmer(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// Assets list shimmer loading
  static Widget assetsListLoading(BuildContext context, {required bool dark}) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          // Search bar shimmer
          Row(
            children: [
              Expanded(
                child: _buildShimmerBox(
                  50,
                  double.infinity,
                  BorderRadius.circular(12),
                ),
              ),
              const SizedBox(width: 12),
              _buildShimmerBox(50, 50, BorderRadius.circular(12)),
            ],
          ),
          const SizedBox(height: 16),
          // Tabs shimmer
          Row(
            children: [
              _buildShimmerBox(28, 60, BorderRadius.circular(30)),
              const SizedBox(width: 12),
              _buildShimmerBox(28, 60, BorderRadius.circular(30)),
            ],
          ),
          const SizedBox(height: 20),
          // Asset items shimmer
          Expanded(
            child: ListView.separated(
              itemCount: 6,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (_, __) => _buildCardShimmer(
                dark,
                height: 100,
                child: Row(
                  children: [
                    _buildShimmerBox(60, 60, BorderRadius.circular(12)),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildShimmerBox(16, 150, BorderRadius.circular(4)),
                          const SizedBox(height: 8),
                          _buildShimmerBox(14, 100, BorderRadius.circular(4)),
                          const SizedBox(height: 8),
                          _buildShimmerBox(14, 80, BorderRadius.circular(4)),
                        ],
                      ),
                    ),
                    _buildShimmerBox(20, 60, BorderRadius.circular(4)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Helper: Build shimmer box
  static Widget _buildShimmerBox(
    double height,
    double width,
    BorderRadius borderRadius, {
    bool forHeader = false,
  }) {
    return Shimmer.fromColors(
      baseColor: forHeader ? Colors.white.withOpacity(0.2) : Colors.grey[300]!,
      highlightColor: forHeader
          ? Colors.white.withOpacity(0.4)
          : Colors.grey[100]!,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: forHeader ? Colors.white.withOpacity(0.3) : Colors.white,
          borderRadius: borderRadius,
        ),
      ),
    );
  }

  /// Helper: Build card shimmer
  static Widget _buildCardShimmer(
    bool dark, {
    double? height,
    double? width,
    Widget? child,
  }) {
    return Shimmer.fromColors(
      baseColor: dark ? Colors.grey[800]! : Colors.grey[300]!,
      highlightColor: dark ? Colors.grey[700]! : Colors.grey[100]!,
      child: Container(
        height: height,
        width: width,
        padding: child != null ? const EdgeInsets.all(16) : null,
        decoration: BoxDecoration(
          color: dark ? Colors.grey[850] : Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: child,
      ),
    );
  }

  /// Helper: Build transaction item shimmer
  static Widget _buildTransactionItemShimmer() {
    return Row(
      children: [
        _buildShimmerBox(40, 40, BorderRadius.circular(8)),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildShimmerBox(16, double.infinity, BorderRadius.circular(4)),
              const SizedBox(height: 8),
              _buildShimmerBox(12, 120, BorderRadius.circular(4)),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            _buildShimmerBox(16, 80, BorderRadius.circular(4)),
            const SizedBox(height: 8),
            _buildShimmerBox(20, 60, BorderRadius.circular(12)),
          ],
        ),
      ],
    );
  }
}
