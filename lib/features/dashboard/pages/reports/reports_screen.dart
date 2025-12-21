import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sole/utils/constants/colors.dart';
import 'package:sole/utils/constants/sizes.dart';
import 'package:sole/utils/helpers/device_helpers.dart';
import '../../controllers/reports_controller.dart';

class ReportsScreen extends GetView<ReportsController> {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UColors.bg,
      body: Padding(
        padding:  EdgeInsets.only(
            top: UDeviceHelper.getAppBarHeight(),
            left: USizes.defaultSpace20,right: USizes.defaultSpace20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Reporting",style: GoogleFonts.plusJakartaSans(
              fontSize: 28,fontWeight: FontWeight.w600,color: UColors.textPrimary
            )),
            SizedBox(height: USizes.md),
            GridView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemCount: controller.reportList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                crossAxisSpacing: USizes.sm * 1.5,
                  mainAxisSpacing: USizes.md,
                  mainAxisExtent: 120
                ),
              itemBuilder: (BuildContext context, int index) { 
                return GestureDetector(
                  onTap: (){
                    controller.onReportTap(index);
                  },
                  child: Container(
                    padding: EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12)
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                       SvgPicture.asset(controller.reportList[index]['icon']),
                        Text(controller.reportList[index]['text'],style: GoogleFonts.plusJakartaSans(
                            fontSize: 14,fontWeight: FontWeight.w500,color: UColors.textPrimary
                        )),
                      ],
                    ),
                  ),
                );
              },)
          ],
        ),
      ),
    );
  }
}
