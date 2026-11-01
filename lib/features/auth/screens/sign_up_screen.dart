import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rent_house/core/color/app_colors.dart';
import 'package:rent_house/core/gen/assets.gen.dart';
import 'package:rent_house/core/widgets/app_buton.dart';
import 'package:rent_house/core/widgets/auth_input_widgets.dart';
import 'package:rent_house/features/auth/cubit/auth_cubit.dart';
import 'package:rent_house/features/auth/cubit/auth_state.dart';
import 'package:rent_house/features/auth/widgets/social_widget.dart';
import 'package:rent_house/features/mainscreen/screens/main_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool agree = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.chevron_left),
        ),
      ),
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          print("Xolat o`zgardi $state");
          if (state is AuthLoadingState) {
            isButoonPressed.value = true;
          }
          if (state is AuthSuccessState) {
            isButoonPressed.value = false;
            _emailController.clear();
            _passwordController.clear();
            _firstNameController.clear();
            _lastNameController.clear();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.green,
                content: Text("You successfuly finished"),
              ),
            );
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => Mainscreen()),
              (_) => false,
            );
          } else if (state is AuthErrorState || state is AuthGoogleErrorState) {
            isButoonPressed.value = false;
            _emailController.clear();
            _passwordController.clear();
            _firstNameController.clear();
            _lastNameController.clear();
            final errorText = state is AuthErrorState
                ? state.errorText
                : (state as AuthGoogleErrorState).errorText;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.red,
                content: Text(errorText ?? "Something went wrong"),
              ),
            );
          }
        },
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Register Account",
                style: GoogleFonts.inter(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 8),
              Text(
                "Sign in with your email and password or social media to continue",
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 32),
              BlocBuilder<AuthCubit, AuthState>(
                builder: (context, State) {
                  String? errorMessage;
                  String? errorNumber;
                  if (State is AuthEmailError) {
                    errorMessage = State.message;
                  }
                  if (State is AuthPasswordError) {
                    errorNumber = State.message;
                  }
                  return Column(
                    children: [
                      AuthInputWidget(
                        controller: _firstNameController,
                        title: "Ism",
                        keyboardType: TextInputType.name,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: AuthInputWidget(
                          controller: _lastNameController,
                          title: "Familya",
                          keyboardType: TextInputType.name,
                        ),
                      ),
                      AuthInputWidget(
                        controller: _emailController,
                        errorMessage: errorMessage,
                        title: "Email",
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) {
                          context.read<AuthCubit>().validateEmail(value);
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16, bottom: 16),
                        child: AuthInputWidget(
                          controller: _passwordController,
                          title: "Password",
                          keyboardType: TextInputType.numberWithOptions(),
                          errorMessage: errorNumber,
                          onChanged: (value) {
                            context.read<AuthCubit>().validatePassword(value);
                          },
                        ),
                      ),
                      Row(
                        children: [
                          Checkbox(
                            value: agree,
                            onChanged: (value) {
                              setState(() {});
                              agree = true;
                            },
                            activeColor: AppColors.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                          SizedBox(width: 2.33),
                          Text(
                            "Agree with terms and privacy",
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: AppColors.secondaryblack,
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
              SizedBox(height: 32),
              BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  return AppButonWidget(
                    isLoading: state is AuthLoadingState,
                    onTap: () {
                      context.read<AuthCubit>().signUp(
                        email: _emailController.text,
                        password: _passwordController.text,
                        firstName: _firstNameController.text,
                        lastName: _lastNameController.text,
                      );
                    },
                    text: 'Sign Up',
                  );
                },
              ),
              SizedBox(height: 24),
              Center(
                child: Text(
                  "Or",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              SizedBox(height: 46),
              ValueListenableBuilder(
                valueListenable: isButoonPressed,
                builder: (context, value, child) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SocialWidget(path: Assets.icons.facebook, onTap: () {}),
                      SizedBox(width: 16),
                      SocialWidget(
                        path: Assets.icons.google,
                        onTap: () {
                          context.read<AuthCubit>().signInWithGoogle();
                        },
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
