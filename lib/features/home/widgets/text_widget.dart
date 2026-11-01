import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rent_house/core/color/app_colors.dart';

class TextsWidget extends StatelessWidget {
  const TextsWidget({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          text,
          style: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.black,
          ),
        ),
        Spacer(),
        TextButton(
          onPressed: () {},
          child: Text(
            'Barchasi',
            style: GoogleFonts.inter(color: AppColors.primary, fontSize: 12, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}