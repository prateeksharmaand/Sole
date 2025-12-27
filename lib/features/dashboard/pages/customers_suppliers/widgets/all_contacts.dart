import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sole/utils/constants/colors.dart';

import '../contact_information_screen.dart';

class AllContactsScreen extends StatefulWidget {
  const AllContactsScreen({super.key});

  @override
  State<AllContactsScreen> createState() => _AllContactsScreenState();
}

class _AllContactsScreenState extends State<AllContactsScreen> {
  final List<ContactModel> contacts = [
    ContactModel(
      name: "John Doe",
      email: "johnsmith@gmail.com",
      type: "Client",
    ),
    ContactModel(
      name: "Gisselle Yewanda",
      email: "gisselle.axle@gmail.com",
      type: "Supplier",
    ),
    ContactModel(
      name: "John Doe",
      email: "johnsmith@gmail.com",
      type: "Client",
    ),
    ContactModel(
      name: "John Doe",
      email: "johnsmith@gmail.com",
      type: "Client",
    ),
    ContactModel(
      name: "John Doe",
      email: "johnsmith@gmail.com",
      type: "Client",
    ),
    ContactModel(
      name: "Gisselle Yewanda",
      email: "gisselle.axle@gmail.com",
      type: "Supplier",
    ),
    ContactModel(
      name: "Gisselle Yewanda",
      email: "gisselle.axle@gmail.com",
      type: "Supplier",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: ListView.separated(
          itemCount: contacts.length,
          separatorBuilder: (_, __) => const SizedBox(height: 18),
          itemBuilder: (context, index) {
            final item = contacts[index];
            final isClient = item.type == "Client";

            return GestureDetector(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ContactInformationScreen(
                      name: item.name,
                      email: item.email,
                      type: item.type,
                      phone: "+1983 948 3998",
                      website: "davidthandean.com",
                      abn: "12345678",
                      businessName: "Qwerty",
                      address:
                      "Ardessie Sanctuary, Albany Highway, East Victoria Park WA, Australia, East Victoria Park, Western Australia, Western Australia, 6101, Australia",
                    ),
                  ),
                );
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Avatar
                  contactAvatar(item.name, isClient),

                  const SizedBox(width: 12),

                  /// Name + email
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.name,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: UColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          item.email,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 11,
                            color: UColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),

                  /// Chip
                  typeChip(item.type),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget typeChip(String type) {
    final isClient = type == "Client";

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isClient ? const Color(0xffE8F8EF) : const Color(0xffEEF2FF),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        type,
        style: GoogleFonts.plusJakartaSans(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          color: isClient ? const Color(0xff1A7F4A) : const Color(0xff4A5DFF),
        ),
      ),
    );
  }

  Widget contactAvatar(String name, bool isClient) {
    String initials = name.trim().split(" ").map((e) => e[0]).take(2).join();

    return Container(
      height: 42,
      width: 42,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isClient ? const Color(0xffE2F3EA) : const Color(0xffE9EEFF),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        initials,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: UColors.textPrimary,
        ),
      ),
    );
  }
}

class ContactModel {
  final String name;
  final String email;
  final String type; // Client or Supplier

  ContactModel({required this.name, required this.email, required this.type});
}
