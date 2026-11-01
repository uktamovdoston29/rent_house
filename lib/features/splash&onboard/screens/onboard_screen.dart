import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rent_house/core/color/app_colors.dart';
import 'package:rent_house/features/auth/screens/sign_in_screen.dart';
import 'package:rent_house/features/splash&onboard/cubit/onboard_cubit.dart';
import 'package:rent_house/features/splash&onboard/cubit/onboard_state.dart';

class OnboardScreen extends StatefulWidget {
  const OnboardScreen({super.key});

  @override
  State<OnboardScreen> createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<OnboardScreen> {
  final PageController _pageController = PageController();
  double _page = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _page = _pageController.page ?? 0;
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goToSignIn() {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => const SignInScreen(),
        transitionsBuilder: (_, animation, __, child) {
          return FadeTransition(opacity: animation, child: child);
        },
        transitionDuration: const Duration(milliseconds: 420),
      ),
    );
  }

  void _next(int currentIndex, int lastIndex) {
    if (currentIndex < lastIndex) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 520),
        curve: Curves.easeOutCubic,
      );
    } else {
      _goToSignIn();
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      backgroundColor: AppColors.white,
      body: BlocBuilder<OnboardCubit, OnboardState>(
        builder: (context, state) {
          if (state is! OnboardSuccessState) {
            return const SizedBox.shrink();
          }
          final currentIndex = state.currentindex;
          final data = OnboardSuccessState.source;
          final isLast = currentIndex == data.length - 1;

          return Stack(
            children: [
              Positioned(
                top: -size.width * 0.28,
                left: -size.width * 0.18,
                child: Container(
                  height: size.width * 0.9,
                  width: size.width * 0.9,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primary.withValues(alpha: 0.08),
                  ),
                ),
              ),
              Positioned(
                top: size.height * 0.12,
                right: -size.width * 0.3,
                child: Container(
                  height: size.width * 0.62,
                  width: size.width * 0.62,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primary.withValues(alpha: 0.05),
                  ),
                ),
              ),
              SafeArea(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: AnimatedOpacity(
                          duration: const Duration(milliseconds: 250),
                          opacity: isLast ? 0 : 1,
                          child: TextButton(
                            onPressed: isLast ? null : _goToSignIn,
                            child: Text(
                              "O‘tkazib yuborish",
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: AppColors.grey,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 6,
                      child: PageView.builder(
                        controller: _pageController,
                        physics: const BouncingScrollPhysics(),
                        itemCount: data.length,
                        onPageChanged: (value) {
                          context.read<OnboardCubit>().changeIndex(value);
                        },
                        itemBuilder: (context, index) {
                          final item = data[index];
                          final delta = (_page - index).abs();
                          final scale = (1 - delta * 0.18).clamp(0.82, 1.0);
                          final opacity = (1 - delta * 0.85).clamp(0.0, 1.0);
                          final translateY = delta * 36;

                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 28),
                            child: Opacity(
                              opacity: opacity,
                              child: Transform.translate(
                                offset: Offset(0, translateY),
                                child: Transform.scale(
                                  scale: scale,
                                  child: Image.asset(
                                    item["image"].path,
                                    fit: BoxFit.contain,
                                    width: double.infinity,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(24, 8, 24, 20),
                        child: Column(
                          children: [
                            AnimatedSwitcher(
                              duration: const Duration(milliseconds: 380),
                              switchInCurve: Curves.easeOutCubic,
                              switchOutCurve: Curves.easeInCubic,
                              transitionBuilder: (child, animation) {
                                return FadeTransition(
                                  opacity: animation,
                                  child: SlideTransition(
                                    position: Tween<Offset>(
                                      begin: const Offset(0, 0.12),
                                      end: Offset.zero,
                                    ).animate(animation),
                                    child: child,
                                  ),
                                );
                              },
                              child: Column(
                                key: ValueKey(currentIndex),
                                children: [
                                  Text(
                                    data[currentIndex]["title"],
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.inter(
                                      color: AppColors.secondaryblack,
                                      fontSize: 26,
                                      height: 1.25,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    data[currentIndex]["description"],
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.inter(
                                      color: AppColors.grey,
                                      fontSize: 15,
                                      height: 1.5,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Spacer(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(data.length, (i) {
                                final selected = currentIndex == i;
                                return AnimatedContainer(
                                  duration: const Duration(milliseconds: 320),
                                  curve: Curves.easeOutCubic,
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 4,
                                  ),
                                  width: selected ? 28 : 8,
                                  height: 8,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: selected
                                        ? AppColors.primary
                                        : AppColors.secondarygrey,
                                  ),
                                );
                              }),
                            ),
                            const SizedBox(height: 24),
                            SizedBox(
                              width: double.infinity,
                              height: 56,
                              child: ElevatedButton(
                                onPressed: () =>
                                    _next(currentIndex, data.length - 1),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primary,
                                  foregroundColor: AppColors.white,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                child: AnimatedSwitcher(
                                  duration: const Duration(milliseconds: 250),
                                  child: Row(
                                    key: ValueKey(isLast),
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        isLast ? "Boshlash" : "Keyingisi",
                                        style: GoogleFonts.inter(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Icon(
                                        isLast
                                            ? Icons.check_rounded
                                            : Icons.arrow_forward_rounded,
                                        size: 20,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
