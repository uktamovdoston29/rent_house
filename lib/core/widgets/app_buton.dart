import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rent_house/core/color/app_colors.dart';

class AppButonWidget extends StatelessWidget {
  const AppButonWidget({
    super.key,
    required this.text,
    this.onTap,
    this.isLoading = false,
  });

  final String text;
  final VoidCallback? onTap;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onTap,
      style: ElevatedButton.styleFrom(
        minimumSize: Size(double.infinity, 52),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        disabledBackgroundColor: AppColors.primary,
        disabledForegroundColor: AppColors.white,
        elevation: 12,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: isLoading
          ? const SizedBox(
              height: 22,
              width: 22,
              child: CircularProgressIndicator(
                strokeWidth: 2.5,
                color: Colors.white,
              ),
            )
          : Text(
              text,
              style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w400),
            ),
    );
  }
}
