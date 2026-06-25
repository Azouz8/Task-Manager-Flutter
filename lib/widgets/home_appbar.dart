import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeAppbar extends StatelessWidget {
  const HomeAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFF131313),
      elevation: 0,
      leading: Container(
        margin: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xFF363636),
        ),
        child: const Icon(
          Icons.format_list_bulleted,
          color: Color(0xFFC1C1FF),
          size: 20,
        ),
      ),
      titleSpacing: 8,
      title: Text(
        "Master Ledger",
        style: GoogleFonts.inter(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: const Color(0xFFC1C1FF),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: IconButton(
            icon: const Icon(
              Icons.settings,
              color: Color(0xFFAFAFAF),
              size: 20,
            ),
            onPressed: () {},
          ),
        ),
      ],
    );
  }
}
