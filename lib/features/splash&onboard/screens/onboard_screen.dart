import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rent_house/core/color/app_colors.dart';
import 'package:rent_house/features/auth/screens/sign_in_screen.dart';
import 'package:rent_house/features/map/screens/location_permision_screen.dart';
import 'package:rent_house/features/splash&onboard/cubit/onboard_cubit.dart';
import 'package:rent_house/features/splash&onboard/cubit/onboard_state.dart';
import 'package:rent_house/utils/services/location_service.dart';

class OnboardScreen extends StatefulWidget {
  const OnboardScreen({super.key});

  @override
  State<OnboardScreen> createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<OnboardScreen> {
  final PageController _pageController = PageController();
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<OnboardCubit, OnboardState>(
        builder: (context, state) {
          if (state is! OnboardSuccessState) {
            return SizedBox();
          }
          final currentindex = state.currentindex;
          final data = OnboardSuccessState.source;
          return SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 70),
                Expanded(
                  child: PageView.builder(
                    onPageChanged: (value) {
                      context.read<OnboardCubit>().changeIndex(value);
                    },
                    controller: _pageController,
                    scrollDirection: Axis.horizontal,
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      final item = data[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 58),
                        child: Column(
                          children: [
                            Image.asset(
                              item["image"].path,
                              height: 298,
                              width: 231,
                            ),
                            SizedBox(height: 52),
                            Text(
                              item["title"],
                              textAlign: TextAlign.center,
                              style: GoogleFonts.inter(
                                color: AppColors.secondaryblack,
                                fontSize: 24,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(height: 16),
                            Text(
                              item["description"],
                              textAlign: TextAlign.center,
                              style: GoogleFonts.inter(
                                color: AppColors.grey,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 40),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(
                                data.length,
                                (i) => Container(
                                  margin: EdgeInsets.symmetric(horizontal: 8),
                                  width: currentindex == i ? 28 : 10,
                                  height: 10,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    color: currentindex == i
                                        ? AppColors.primary
                                        : AppColors.grey,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 30),
                            InkWell(
                              onTap: () {
                                if (currentindex < data.length - 1) {
                                  _pageController.nextPage(
                                    duration: Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                  );
                                  context.read<OnboardCubit>().nextPage();
                                } else {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return SignInScreen();
                                      },
                                    ),
                                  );
                                }
                              },

                              child: Container(
                                height: 62,
                                width: 327,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: AppColors.primary,
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  currentindex == data.length - 1
                                      ? "GET STARTED"
                                      : "NEXT",
                                  style: GoogleFonts.sen(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
