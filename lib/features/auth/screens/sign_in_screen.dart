import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rent_house/core/color/app_colors.dart';
import 'package:rent_house/core/gen/assets.gen.dart';
import 'package:rent_house/core/widgets/app_buton.dart';
import 'package:rent_house/core/widgets/auth_input_widgets.dart';
import 'package:rent_house/features/auth/cubit/auth_cubit.dart';
import 'package:rent_house/features/auth/cubit/auth_state.dart';
import 'package:rent_house/features/auth/screens/forget_password_screen.dart';
import 'package:rent_house/features/auth/screens/sign_up_screen.dart';
import 'package:rent_house/features/auth/widgets/social_widget.dart';
import 'package:rent_house/features/mainscreen/screens/main_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool rememberMe = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          print("Xolat o`zgardi $state");
          if (state is AuthLoadingState) {
            isButoonPressed.value = true;
          } else if (state is AuthGoogleErrorState) {
            isButoonPressed.value = false;
          }
          if (state is AuthSuccessState) {
            _emailController.clear();
            _passwordController.clear();

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.green,
                content: Text("This information is correct"),
              ),
            );
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => Mainscreen()),
              (_) => false,
            );
          } else if (state is AuthErrorState) {
            _emailController.clear();
            _passwordController.clear();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.red,
                content: Text(state.errorText ?? "Error occured"),
              ),
            );
          }
        },
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 72),
                Text(
                  "Welcome Back !",
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    color: AppColors.secondaryblack,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "Sign in with your email and password or social media to continue",
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: AppColors.grey,
                  ),
                ),
                SizedBox(height: 32),
                BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, state) {
                    String? errorMessage;
                    String? errorNumber;
                    if (state is AuthEmailError) {
                      errorMessage = state.message;
                    }
                    if (state is AuthPasswordError) {
                      errorNumber = state.message;
                    }
                    return Column(
                      children: [
                        AuthInputWidget(
                          controller: _emailController,
                          errorMessage: errorMessage,
                          title: 'Email',
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (value) {
                            context.read<AuthCubit>().validateEmail(value);
                          },
                        ),
                        SizedBox(height: 16),
                        AuthInputWidget(
                          // suffixIcon: SvgPicture.asset(Assets.icons.hide, height: 15.77, width: 18.5),
                          errorMessage: errorNumber,
                          controller: _passwordController,
                          title: 'Password',
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            context.read<AuthCubit>().validatePassword(value);
                          },
                        ),
                        SizedBox(height: 16),
                        Row(
                          children: [
                            Checkbox(
                              value: rememberMe,
                              onChanged: (value) {
                                setState(() {});
                                rememberMe = true;
                              },
                              activeColor: AppColors.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                            SizedBox(width: 2.33),
                            Text(
                              "Remember me ",
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: AppColors.secondaryblack,
                              ),
                            ),
                            Spacer(),
                            TextButton(
                              onPressed: () {
                                context.read<AuthCubit>().resetPassword(
                                  email: _emailController.text,
                                );
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ForgetPasswordScreen(),
                                  ),
                                );
                              },
                              child: Text(
                                "Forgot password ?",
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 32),
                        BlocBuilder<AuthCubit, AuthState>(
                          builder: (context, state) {
                            return AppButonWidget(
                              onTap: () {
                                context.read<AuthCubit>().signIn(
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                );
                              },
                              text: 'Sign In',
                            );
                          },
                        ),
                        SizedBox(height: 24),
                        Text(
                          "Or",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: 24),
                        ValueListenableBuilder(
                          valueListenable: isButoonPressed,
                          builder: (context, value, child) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SocialWidget(
                                  path: Assets.icons.facebook,
                                  onTap: () {},
                                ),
                                SizedBox(width: 16),
                                SocialWidget(
                                    path: Assets.icons.google,
                                    onTap: () {
                                    context.read<AuthCubit>().signInWithGoogle();

                                    },
                                  )
                              ],
                            );
                          }
                        ),
                        SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don’t have account ?",
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: AppColors.secondaryblack,
                              ),
                            ),
                            SizedBox(width: 6),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SignUpScreen(),
                                  ),
                                );
                              },
                              child: Text(
                                "Sign Up",
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
