import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sole/common/widgets/appbar/appbar.dart';
import 'package:sole/features/dashboard/pages/cash_flow/cash_flow_screen.dart';
import 'package:sole/features/dashboard/pages/chart_of_accounts/chart_of_accounts_screen.dart';
import 'package:sole/features/dashboard/pages/perks/perks_screen.dart';
import 'package:sole/features/dashboard/pages/refer_earn/refer_earn_screen.dart';
import 'package:sole/features/dashboard/pages/trial_balance/trial_balance_screen.dart';
import 'package:sole/routes/routes.dart';
import 'package:sole/utils/constants/colors.dart';

class InvoicesScreen extends StatelessWidget {
  const InvoicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UAppBar(
        title: Text("Invoice Page Comming soon ......."),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextButton(onPressed: (){
              Get.to(()=> ReferEarnScreen());
            }, child: Text("1.  Refer & Earn Screen",style: TextStyle(
              fontSize: 21,color: UColors.textPrimary
            ))),


            TextButton(onPressed: (){
              Get.to(()=>PerksScreen());
            }, child: Text("2.  Perks Screen",style: TextStyle(
                fontSize: 21,color: UColors.textPrimary
            ))),


            TextButton(onPressed: (){
              Get.toNamed(URoutes.basReportsScreen);
            }, child: Text("3. BasReports Screen",style: TextStyle(
                fontSize: 21,color: UColors.textPrimary
            ))),


            TextButton(onPressed: (){
              Get.to(()=> CashFlowScreen());
            }, child: Text("4.  Cashflow",style: TextStyle(
                fontSize: 21,color: UColors.textPrimary
            ))),
            TextButton(onPressed: (){
              Get.to(()=> ChartOfAccountsScreen());
            }, child: Text("5. Chart of Accounts",style: TextStyle(
                fontSize: 21,color: UColors.textPrimary
            ))),

            TextButton(onPressed: (){
              Get.to(()=> TrialBalanceScreen());
            }, child: Text("6. Trial balance",style: TextStyle(
                fontSize: 21,color: UColors.textPrimary
            ))),

            TextButton(onPressed: (){
              Get.toNamed(URoutes.invoiceQuoteBrandingScreen);
            }, child: Text("7. Invoice Quote Branding Screen",style: TextStyle(
                fontSize: 21,color: UColors.textPrimary
            ))),
          ],
        ),
      ),
    );
  }
}
