import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rent_house/core/color/app_colors.dart';
import 'package:rent_house/core/gen/assets.gen.dart';
import 'package:rent_house/features/splash&onboard/screens/onboard_screen.dart';

class SpalshScreen extends StatefulWidget {
  const SpalshScreen({super.key});

  @override
  State<SpalshScreen> createState() => _SpalshScreenState();
}

class _SpalshScreenState extends State<SpalshScreen> {
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => OnboardScreen()),
      );
    });
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 158,
              width: 137,
              child: Assets.images.mainLogo.image(),
            ),
            const SizedBox(height: 24),
            Text(
              "House Rent",
              style: GoogleFonts.inter(
                fontSize: 28,
                fontWeight: FontWeight.w700,
                color: AppColors.secondaryblack,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Uy ijarasi platformasi",
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppColors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
