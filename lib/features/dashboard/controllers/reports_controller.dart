import 'package:get/get.dart';
import 'package:sole/features/dashboard/pages/consolidated_report/consolidated_report_screen.dart';
import 'package:sole/features/dashboard/pages/vat_listing/vat_listing_screen.dart';
import 'package:sole/routes/routes.dart';

import '../../../utils/constants/images.dart';

class ReportsController extends GetxController {
  List reportList = [
    {"icon": UImages.balanceSheetIcon, "text": "Balance Sheet"},
    {"icon": UImages.transactionListingIcon, "text": "Transaction Listing"},
    {"icon": UImages.gSTExtractIcon, "text": "VAT Listing"},
    {"icon": UImages.assetListingIcon, "text": "Asset Listing"},
    {"icon": UImages.profitLossIcon, "text": "Profit & Loss"},
    {"icon": UImages.customerSupplierIcon, "text": "Customer / Supplier"},
    {"icon": UImages.consolidatedReportIcon, "text": "Consolidated Report"},
    {"icon": UImages.auditTrailIcon, "text": "Audit Trail"},
  ];

  /// 🔹 Index based navigation
  void onReportTap(int index) {
    switch (index) {
      case 0:
        Get.toNamed(URoutes.balanceSheetScreen);
        break;

      case 1:
        Get.toNamed(URoutes.transactionListingScreen);
        break;

      case 2:
        Get.to(()=>VatListingScreen());
        break;

      case 3:
        Get.toNamed(URoutes.assetsListingScreen);
        break;

      case 4:
        Get.toNamed(URoutes.profitLoss);
        break;

      case 5:
        Get.toNamed(URoutes.customersSuppliersScreen);
        break;

      case 6:
        Get.to(()=>ConsolidatedReportScreen());
        break;

      case 7:
        Get.toNamed(URoutes.auditTrailScreen);
        break;

      default:
        Get.snackbar("Error", "Invalid report selected");
    }
  }
}
