import 'package:flutter/material.dart';
import 'package:flutter_dotted_border/flutter_dotted_border.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sole/common/widgets/app_btn/app_btn.dart';
import 'package:sole/common/widgets/textfields/app_text_fields.dart';
import 'package:sole/utils/constants/sizes.dart';
import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/switch_btn/switch_btn.dart';
import '../../../../utils/constants/colors.dart';
import '../communication_preferences/communication_preferences_screen.dart';

class InvoiceQuoteBrandingScreen extends StatelessWidget {
  const InvoiceQuoteBrandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 8,
      child: Scaffold(
        backgroundColor: UColors.white,
        appBar: UAppBar(
          showBackArrow: true,
          showDivider: false,
          title: Text(
            "Invoices Branding",
            style: GoogleFonts.plusJakartaSans(
              fontWeight: FontWeight.w600,
              fontSize: 18,
              color: UColors.textPrimary,
            ),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Tabs
             TabBar(
              labelColor: UColors.primary,
              unselectedLabelColor: UColors.textSecondary,
              indicatorColor: UColors.primary,
              tabAlignment: TabAlignment.start,
              unselectedLabelStyle: GoogleFonts.plusJakartaSans(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: UColors.textSecondary
              ),
              isScrollable: true,
              labelStyle: GoogleFonts.plusJakartaSans(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: UColors.primary
              ),
              indicatorWeight: 2,
              tabs: [
                Tab(text: "Sequence Settings"),
                Tab(text: "Logo & Colors"),
                Tab(text: "Footer & Social"),
                Tab(text: "Invoice Customisation"),
                Tab(text: "Quote Customisation"),
                Tab(text: "Invoice Styling"),
                Tab(text: "Quote Styling"),
                Tab(text: "Communication Preferences"),
              ],
            ),

            /// Content
            Expanded(
              child: TabBarView(
                children: [
                  SequenceSettingsTab(),
                  LogoAndColorTab(),
                  FooterAndSocialTab(),
                  InvoiceCustomisationTab(),
                  QuoteCustomisationTab(),
                  InvoiceStylingTab(),
                  QuoteStylingTab(),
                  CommunicationPreferencesTab()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LogoAndColorTab extends StatelessWidget {
  const LogoAndColorTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: USizes.lg,horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonTitleSubTitle(title: "Logo & colours Branding", subTitle: 'Upload your business logo and customise colour themes'),
            SizedBox(height: USizes.lg),
            Text("Business Logo",style: GoogleFonts.plusJakartaSans(
                fontSize:  14,
                fontWeight: FontWeight.w500,
                color: UColors.textSecondary
            )),
            SizedBox(height: USizes.md),
            Row(
              children: [
                // dotted Border Container
                DottedBorder(
                  borderType: RoundedRectDottedBorder(
                    color: UColors.borderB3FF,
                    dashGap: 4,
                    dashWidth: 4,
                    strokeWidth: 2,
                    radius: Radius.circular(4),
                  ),
                  child: Container(
                    height: 104,
                    width: 104,
                    decoration: BoxDecoration(
                      color: UColors.bg,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Center(
                      child: Text("Upload your\nlogo",
                          textAlign: TextAlign.center
                          ,style: GoogleFonts.plusJakartaSans(
                              fontWeight: FontWeight.w400,fontSize: 12,color: UColors.textA4A6)),
                    ),
                  ),
                ),
                SizedBox(width: USizes.lg),
                Expanded(
                  child: Text(
                      "Best size: 500 x 500 pixels\nUsed on all invoices",
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: UColors.textSecondary,
                      )),
                )
              ],
            ),
            SizedBox(height: USizes.lg),
            CommonTitleSubTitle(title: "Brand colour",
                titleSize: 14,
                titleFontWeight: FontWeight.w500,
                subTitle: 'Primary Brand colour for headers and accents'),
            SizedBox(height: USizes.md),
            UTextField(hintText: "# 4d4dff",),
            SizedBox(height: USizes.lg),
            CommonTitleSubTitle(title: "Content colour",
                titleSize: 14,
                titleFontWeight: FontWeight.w500,
                subTitle: 'Primary Brand colour for headers and accents'),
            SizedBox(height: USizes.md),
            UTextField(hintText: "# 000000",),
            SizedBox(height: USizes.lg),
            SizedBox(
              width: 170,
              child: UButton(
                  onPressed: (){},
                  label: "Save & Update"
              ),
            )

          ],
        ),
      ),
    );
  }
}

class InvoiceStylingTab extends StatefulWidget {
  const InvoiceStylingTab({
    super.key,
  });

  @override
  State<InvoiceStylingTab> createState() => _InvoiceStylingTabState();
}

class _InvoiceStylingTabState extends State<InvoiceStylingTab> {
  int selectedIndex = 0;
  int selectedIndex1 = 0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: USizes.lg,horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonTitleSubTitle(title: "Invoice Style", subTitle: 'Choose styles for your invoices'),
            SizedBox(height: USizes.lg),
            Text("General Style",style: GoogleFonts.plusJakartaSans(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: UColors.textPrimary
            )),
            SizedBox(height: USizes.sm * 1.5),
            SizedBox(
              height: 170,
              child: ListView.builder(
                itemCount: 5,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final isSelected = selectedIndex == index;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  child: Container(
                    width: 125,
                    margin: EdgeInsets.only(right: USizes.md),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isSelected
                            ? Colors.blue
                            : Colors.grey.shade200,
                        width: isSelected ? 2 : 1,
                      ),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                            color: Colors.grey.shade50,
                            width: 10
                        ),
                      ),
                      child: const SizedBox(),
                    ),
                  ),
                );
              },),
            ),
            SizedBox(height: USizes.md),
            Text("Classic Style",style: GoogleFonts.plusJakartaSans(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: UColors.textPrimary
            )),
            SizedBox(height: USizes.sm * 1.5),
            SizedBox(
              height: 170,
              child: ListView.builder(
                itemCount: 5,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final isSelected = selectedIndex1 == index;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex1 = index;
                    });
                  },
                  child: Container(
                    width: 125,
                    margin: EdgeInsets.only(right: USizes.md),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isSelected
                            ? Colors.blue
                            : Colors.grey.shade200,
                        width: isSelected ? 2 : 1,
                      ),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                            color: Colors.grey.shade50,
                            width: 10
                        ),
                      ),
                      child: const SizedBox(),
                    ),
                  ),
                );
              },),
            ),
            SizedBox(height: USizes.lg),
            Row(
              children: [
                Expanded(
                  child: UButton(
                    onPressed: (){},
                    bgColor: UColors.white,
                    borderColor: UColors.borderBtn,
                    label: "Reset Default",
                    textColor: UColors.textSecondary,
                  ),
                ),
                SizedBox(width: USizes.sm * 1.5),
                Expanded(
                  child: UButton(
                      onPressed: (){},
                      label: "Save"
                  ),
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}

class QuoteStylingTab extends StatefulWidget {
  const QuoteStylingTab({
    super.key,
  });

  @override
  State<QuoteStylingTab> createState() => _QuoteStylingTabState();
}

class _QuoteStylingTabState extends State<QuoteStylingTab> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: USizes.lg,horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonTitleSubTitle(title: "Quote Style", subTitle: 'Choose styles for your quotes'),
            SizedBox(height: USizes.lg),

            GridView.builder(
              itemCount: 9,
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.75,
              ),
              itemBuilder: (context, index) {
                final isSelected = selectedIndex == index;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isSelected
                            ? Colors.blue
                            : Colors.grey.shade200,
                        width: isSelected ? 2 : 1,
                      ),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: Colors.grey.shade50,
                          width: 10
                        ),
                      ),
                      child: const SizedBox(),
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: USizes.lg),
            Row(
              children: [
                Expanded(
                  child: UButton(
                    onPressed: (){},
                    bgColor: UColors.white,
                    borderColor: UColors.borderBtn,
                    label: "Reset Default",
                    textColor: UColors.textSecondary,
                  ),
                ),
                SizedBox(width: USizes.sm * 1.5),
                Expanded(
                  child: UButton(
                      onPressed: (){},
                      label: "Save"
                  ),
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}

class CommunicationPreferencesTab extends StatelessWidget {
  const CommunicationPreferencesTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: USizes.lg,horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonTitleSubTitle(title: "Communication Preferences", subTitle: 'Customise your communication settings.'),
            SizedBox(height: USizes.lg),
            Divider(color: UColors.divider),
            SizedBox(height: USizes.xl),
            CommonTitleSubTitle(title: "Text Message Settings", subTitle: 'Enable text messages for invoices and quotes (don’t worry, your customer will get an email as well).'),
            SizedBox(height: USizes.lg),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Enable Text Messages",style: GoogleFonts.plusJakartaSans(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: UColors.textPrimary
                )),
                USwitch(value: true, onChanged: (value){}),
              ],
            ),
            SizedBox(height: USizes.lg),
            Divider(color: UColors.divider),
            SizedBox(height: USizes.xl),
            CommonTitleSubTitle(title: "Notifications", subTitle: 'Customise the type of notification you want to receive when Sole sends invoices and quotes to customers'),
            SizedBox(height: USizes.lg),
            CommonTextSubTextAndSwitch(
              text: 'Invoice',
              subText:
              "Would you like to receive a BCC email when Sole sends any invoice related emails to customers?",
              value: false, onChanged: (bool value) {  },
            ),
            SizedBox(height: USizes.md),
            CommonTextSubTextAndSwitch(
              text: 'Quote',
              subText:
              "Would you like to receive a BCC email when Sole sends any quote related emails to customers?",
              value: false, onChanged: (bool value) {  },
            ),
            SizedBox(height: USizes.lg),

            Divider(color: UColors.divider),
            SizedBox(height: USizes.xl),
            CommonTitleSubTitle(title: "Customer Reminders", subTitle: 'Set your preferences for the types of reminders you would like to send to your customers'),
            SizedBox(height: USizes.xl),
            CommonTextSubTextAndSwitch(
              text: 'Invoice Due Reminder',
              subText:
              "Would you like Sole to automatically send your customers a reminder when an invoice is approaching it's due date?",
              value: false, onChanged: (bool value) {  },
            ),
           // SizedBox(height: USizes.md),
            titleAndTextFieldBtn(title: "Days before due date"),
            SizedBox(height: USizes.md),
            CommonTextSubTextAndSwitch(
              text: 'Invoice Overdue Reminder',
              subText:
              "Would you like Sole to automatically send your customers a reminder when an invoice is overdue?",
              value: false, onChanged: (bool value) {  },
            ),
            SizedBox(height: USizes.md),
            titleAndTextFieldBtn(title: 'Days after due date'),
            SizedBox(height: USizes.md),
            CommonTextSubTextAndSwitch(
              text: 'Quote Expiry Reminder',
              subText:
              'Would you like Sole to automatically send your customers a reminder when a quote is approaching expiry?',
              value: false, onChanged: (bool value) {  },
            ),

            SizedBox(height: USizes.lg),
            Row(
              children: [
                Expanded(
                  child: UButton(
                    onPressed: (){},
                    bgColor: UColors.white,
                    borderColor: UColors.borderBtn,
                    label: "Reset Default",
                    textColor: UColors.textSecondary,
                  ),
                ),
                SizedBox(width: USizes.sm * 1.5),
                Expanded(
                  child: UButton(
                      onPressed: (){},
                      label: "Save"
                  ),
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }

  Container titleAndTextFieldBtn({required String title}) {
    return Container(
            padding: EdgeInsets.all(USizes.md),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: UColors.bg
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,style: GoogleFonts.plusJakartaSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: UColors.textPrimary
                )),
                SizedBox(height: USizes.xs),
                Row(
                  children: [
                    Expanded(child: UTextField()),
                    SizedBox(width: USizes.sm),
                    SizedBox(
                      width: 75,
                      height: 45,
                      child: UButton(
                          onPressed: (){},
                          label: "Save"
                      ),
                    )
                  ],
                )
              ],
            ),
          );
  }
}

class QuoteCustomisationTab extends StatelessWidget {
  const QuoteCustomisationTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: USizes.lg,horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonTitleSubTitle(title: "Quote Field Settings", subTitle: 'Configure which fields appear on your quotes'),
            SizedBox(height: USizes.lg),
            CommonTextSubTextAndSwitch(
              text: 'Customer Name',
              subText:
              "Display customer's full name",
              value: false, onChanged: (bool value) {  },
            ),
            SizedBox(height: USizes.md),
            CommonTextSubTextAndSwitch(
              text: 'Customer Business Name',
              subText:
              "Display customer's business name",
              value: false, onChanged: (bool value) {  },
            ),
            SizedBox(height: USizes.md),
            CommonTextSubTextAndSwitch(
              text: 'Customer Address',
              subText:
              "Display customer's address",
              value: false, onChanged: (bool value) {  },
            ),
            SizedBox(height: USizes.md),
            CommonTextSubTextAndSwitch(
              text: 'Customer ABN',
              subText:
              "Display customer's ABN number",
              value: false, onChanged: (bool value) {  },
            ),
            SizedBox(height: USizes.md),
            CommonTextSubTextAndSwitch(
              text: 'Your Business Name',
              subText:
              'Display your business name',
              value: false, onChanged: (bool value) {  },
            ),
            SizedBox(height: USizes.md),
            CommonTextSubTextAndSwitch(
              text: 'Your Business Address',
              subText:
              'Display your business address',
              value: false, onChanged: (bool value) {  },
            ),
            SizedBox(height: USizes.md),
            CommonTextSubTextAndSwitch(
              text: 'Your Business ABN',
              subText:
              'Display your business ABN number',
              value: false, onChanged: (bool value) {  },
            ),
            SizedBox(height: USizes.md),
            CommonTextSubTextAndSwitch(
              text: 'Your Name',
              subText:
              'Display your name on quotes',
              value: false, onChanged: (bool value) {  },
            ),
            SizedBox(height: USizes.md),
            CommonTextSubTextAndSwitch(
              text: 'Auto Paid Receipt',
              subText:
              'Automatically send receipt when invoice is marked as paid',
              value: false, onChanged: (bool value) {  },
            ),
            SizedBox(height: USizes.md),
            CommonTextSubTextAndSwitch(
              text: 'Your Business Name',
              subText:
              'Display your business name',
              value: false, onChanged: (bool value) {  },
            ),
            SizedBox(height: USizes.md),
            Divider(color: UColors.divider),
            SizedBox(height: USizes.md),
            CommonTitleSubTitle(title: "Custom Quote Notes", subTitle: "Add standard terms and conditions or notes to all quotes"),
            SizedBox(height: USizes.lg),
            UTextField(
              hintText: "Enter custom notes for quotes (e.g., terms and conditions, validity period",
              maxLines: 5,
            ),
            SizedBox(height: USizes.lg),
            SizedBox(
              width: 120,
              child: UButton(
                onPressed: (){},
                label: "Save"
              ),
            ),
            SizedBox(height: USizes.lg),
            UButton(
              onPressed: (){},
              bgColor: UColors.white,
              borderColor: UColors.borderBtn,
              label: "Reset Default",
              textColor: UColors.textSecondary,
            ),

          ],
        ),
      ),
    );
  }
}

class InvoiceCustomisationTab extends StatelessWidget {
  const InvoiceCustomisationTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: USizes.lg,horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonTitleSubTitle(title: "Invoice Field Settings", subTitle: 'Add contact information and social media links'),
            SizedBox(height: USizes.lg),
            CommonTextSubTextAndSwitch(
              text: 'Customer Name',
              subText:
              "Display customer's full name",
              value: false, onChanged: (bool value) {  },
            ),
            SizedBox(height: USizes.md),
            CommonTextSubTextAndSwitch(
              text: 'Customer Business Name',
              subText:
              "Display customer's business name",
              value: false, onChanged: (bool value) {  },
            ),
            SizedBox(height: USizes.md),
            CommonTextSubTextAndSwitch(
              text: 'Customer Address',
              subText:
              "Display customer's address",
              value: false, onChanged: (bool value) {  },
            ),
            SizedBox(height: USizes.md),
            CommonTextSubTextAndSwitch(
              text: 'Customer ABN',
              subText:
              "Display customer's ABN number",
              value: false, onChanged: (bool value) {  },
            ),
            SizedBox(height: USizes.md),
            CommonTextSubTextAndSwitch(
              text: 'Your Business Name',
              subText:
              'Display your business name',
              value: false, onChanged: (bool value) {  },
            ),
            SizedBox(height: USizes.md),
            CommonTextSubTextAndSwitch(
              text: 'Your Business Address',
              subText:
              'Display your business address',
              value: false, onChanged: (bool value) {  },
            ),
            SizedBox(height: USizes.md),
            CommonTextSubTextAndSwitch(
              text: 'Your Business ABN',
              subText:
              'Display your business ABN number',
              value: false, onChanged: (bool value) {  },
            ),
            SizedBox(height: USizes.md),
            CommonTextSubTextAndSwitch(
              text: 'Item Descriptions',
              subText:
              'Show detailed descriptions for invoice items',
              value: false, onChanged: (bool value) {  },
            ),
            SizedBox(height: USizes.md),
            CommonTextSubTextAndSwitch(
              text: 'Auto Paid Receipt',
              subText:
              'Automatically send receipt when invoice is marked as paid',
              value: false, onChanged: (bool value) {  },
            ),
            SizedBox(height: USizes.md),
            CommonTextSubTextAndSwitch(
              text: 'Your Business Name',
              subText:
              'Display your business name',
              value: false, onChanged: (bool value) {  },
            ),
            SizedBox(height: USizes.md),
            Divider(color: UColors.divider),
            SizedBox(height: USizes.md),
            CommonTitleSubTitle(title: "Custom Invoice Notes", subTitle: "Add standard terms and conditions or notes to all invoices"),
            SizedBox(height: USizes.lg),
            UTextField(
              hintText: "Enter custom notes for invoices (e.g., terms and conditions, payment instructions)",
              maxLines: 5,
            ),
            SizedBox(height: USizes.lg),
            SizedBox(
              width: 120,
              child: UButton(
                onPressed: (){},
                label: "Save"
              ),
            ),
            SizedBox(height: USizes.lg),
            UButton(
              onPressed: (){},
              bgColor: UColors.white,
              borderColor: UColors.borderBtn,
              label: "Reset Default",
              textColor: UColors.textSecondary,
            ),

          ],
        ),
      ),
    );
  }
}

class FooterAndSocialTab extends StatelessWidget {
  const FooterAndSocialTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: USizes.lg,horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonTitleSubTitle(title: "Footer & Social Media", subTitle: 'Add contact information and social media links'),
            SizedBox(height: USizes.lg),
            CommonTextSubTextAndSwitch(
              text: 'Phone Number',
              subText:
              'Display phone number in footer',
              value: false, onChanged: (bool value) {  },
            ),
            SizedBox(height: USizes.md),
            CommonTextSubTextAndSwitch(
              text: 'Website',
              subText:
              'Display website URL in footer',
              value: false, onChanged: (bool value) {  },
            ),
            SizedBox(height: USizes.md),
            CommonTextSubTextAndSwitch(
              text: 'Facebook',
              subText:
              'Display Facebook link in footer',
              value: false, onChanged: (bool value) {  },
            ),
            SizedBox(height: USizes.md),
            CommonTextSubTextAndSwitch(
              text: 'Instagram',
              subText:
              'Display Instagram link in footer',
              value: false, onChanged: (bool value) {  },
            ),
            SizedBox(height: USizes.md),
            CommonTextSubTextAndSwitch(
              text: 'Linkedin',
              subText:
              'Display LinkedIn link in footer',
              value: false, onChanged: (bool value) {  },
            ),
            SizedBox(height: USizes.md),
            CommonTextSubTextAndSwitch(
              text: 'Tiktok',
              subText:
              'Display TikTok link in footer',
              value: false, onChanged: (bool value) {  },
            ),
            SizedBox(height: USizes.md),
            UButton(
              onPressed: (){},
              bgColor: UColors.white,
              borderColor: UColors.borderBtn,
              label: "Reset Default",
              textColor: UColors.textSecondary,
            ),

          ],
        ),
      ),
    );
  }
}

class SequenceSettingsTab extends StatelessWidget {
  const SequenceSettingsTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: USizes.lg,horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonTitleSubTitle(title: "Invoice & Quote Number", subTitle: 'Set how you want your invoice and quote reference numbers displayed and their starting number. New invoices and quotes will then auto-increment by 1'),
            SizedBox(height: USizes.lg),
            UTextField2(titleText: "Invoice Prefix",hintText: ""),
            SizedBox(height: USizes.lg),
            UTextField2(titleText: "Invoice Next Number",hintText: ""),
            SizedBox(height: USizes.lg),
            UTextField2(titleText: "Quote Prefix",hintText: ""),
            SizedBox(height: USizes.lg),
            UTextField2(titleText: "Quote Next Number",hintText: ""),
            SizedBox(height: USizes.lg),
            SizedBox(
              width: 150,
              child: UButton(
                onPressed: (){},
                label: "Save & Update",
              ),
            ),

          ],
        ),
      ),
    );
  }
}

class CommonTitleSubTitle extends StatelessWidget {
  final String title;
  final double? titleSize;
  final FontWeight? titleFontWeight;
  final String subTitle;
  final double? subTitleSize;
  final FontWeight? subTitleFontWeight;
  const CommonTitleSubTitle({
    super.key, required this.title, required this.subTitle, this.titleSize, this.subTitleSize, this.titleFontWeight, this.subTitleFontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,style: GoogleFonts.plusJakartaSans(
            fontSize: titleSize ?? 16,
            fontWeight: titleFontWeight ?? FontWeight.w600,
            color: UColors.textPrimary
        )),
        SizedBox(height: USizes.xs),
        Text(subTitle,style: GoogleFonts.plusJakartaSans(
            fontSize: subTitleSize ?? 14,
            fontWeight: subTitleFontWeight ?? FontWeight.w400,
            color: UColors.text5866
        )),
      ],
    );
  }
}
