import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CardDataUserWidget extends StatelessWidget {
  const CardDataUserWidget({
    super.key,
    required this.tittle,
    required this.data,
  });

  final String tittle;
  final String data;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              tittle,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(data),
          ],
        ),
      ),
    );
  }
}
