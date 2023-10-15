import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

AppBar buildAppBar() {
  return AppBar(
    iconTheme: const IconThemeData(color: Colors.blue),
    backgroundColor: Colors.white,
    title: Container(
      padding: const EdgeInsets.only(right: 60),
      alignment: Alignment.center,
      child: Text(
        'Profile',
        style: GoogleFonts.poppins(
            color: Colors.blue, fontWeight: FontWeight.w600),
      ),
    ),
  );
}