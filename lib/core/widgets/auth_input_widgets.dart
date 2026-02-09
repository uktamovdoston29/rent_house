import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rent_house/core/color/app_colors.dart';

class AuthInputWidget extends StatelessWidget {
  const AuthInputWidget({
    super.key,
    this.errorMessage,
    required this.title,
    this.keyboardType,
    this.onChanged,
    this.errorNumber,
    this.suffixIcon,
    this.prefixIcon, this.controller,
  });

  final String? errorMessage;
  final String title;
  final TextInputType? keyboardType;
  final void Function(String)? onChanged;
  final String? errorNumber;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.secondaryblack,
          ),
        ),
        SizedBox(height: 4),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColors.white),
            ),
            errorText: errorMessage,
            focusColor: AppColors.primary,
          ),

          onChanged: onChanged,
        ),
      ],
    );
  }
}
