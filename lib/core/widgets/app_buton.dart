import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rent_house/core/color/app_colors.dart';

class AppButonWidget extends StatelessWidget {
  const AppButonWidget({super.key, required this.text, this.onTap});

  @override
  final String text;
  final VoidCallback? onTap;

  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        minimumSize: Size(double.infinity, 52),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        elevation: 12,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Text(
        text,
        style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w400),
      ),
    );
  }
}
