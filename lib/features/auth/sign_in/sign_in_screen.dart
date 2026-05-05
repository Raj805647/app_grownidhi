import 'package:app_grownidhi/features/auth/sign_in/sign_in_controller.dart';
import 'package:app_grownidhi/routes/route_names.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_icons.dart';
import '../../../core/constants/app_images.dart';
import '../../../widget/custom_textfield.dart';
import '../../../widget/help_widget.dart';
import '../../../widget/page_entry_animation.dart';
import '../../../widget/ui_design.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SignInProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          body: Stack(
            children: [
              AppGradientBackground(),

              SingleChildScrollView(
                child: Column(
                  children: [
                    PageEntryAnimation(
                      direction: SlideDirection.top,
                      child: _buildHeader(),
                    ),

                    spaceHeight(20),

                    PageEntryAnimation(
                      direction: SlideDirection.left,
                      child: _buildFeatures(),
                    ),

                    spaceHeight(30),

                    PageEntryAnimation(
                      direction: SlideDirection.bottom,
                      child: _buildCard(context, provider),
                    ),

                    spaceHeight(20),

                    PageEntryAnimation(
                      direction: SlideDirection.right,
                      child: _buildGoogleButton(),
                    ),

                    spaceHeight(20),

                    _buildTerms(),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // ---------------- HEADER ----------------

  Widget _buildHeader() {
    return Column(
      children: [
        Container(
          height: 170,
          width: 170,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 35,
                offset: const Offset(0, 18),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(AppImages.grownidhiLogo, fit: BoxFit.cover),
          ),
        ),
        const Text(
          "Welcome to Grownidhi",
          style: TextStyle(
            fontSize: 27,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0B1E2D),
          ),
        ),
        spaceHeight(10),
        const Text(
          "Your intelligent financial companion \nfor a secure future",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            color: Colors.black,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  // ---------------- FEATURES ----------------

  Widget _buildFeatures() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _featureItem(Icons.shield_outlined, "Bank-level Security"),
        _featureItem(Icons.trending_up, "Smart Insights"),
        _featureItem(Icons.auto_awesome, "AI-Powered"),
      ],
    );
  }

  Widget _featureItem(IconData icon, String text) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10),
            ],
          ),
          child: Icon(icon, color: Colors.green),
        ),
        spaceHeight(8),
        Text(
          text,
          style: TextStyle(
            fontSize: 12,
            color: Colors.black,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }


  Widget _buildCard(BuildContext context, SignInProvider provider) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 20),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Get Started",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

       spaceHeight(20),

          /// 🔹 EMAIL FIELD
          customTextField(
            hintText: "Email",
            controller: provider.emailController,
            prefixIcon: Icons.email,
            keyboardType: TextInputType.emailAddress,
          ),

       spaceHeight(15),

          /// 🔹 PASSWORD FIELD
          customTextField(
            hintText: "Password",
            controller: provider.passwordController,
            prefixIcon: Icons.lock,
            obscureText: true,
          ),

       spaceHeight(20),

          /// 🔹 SUBMIT BUTTON WITH LOADING
          InkWell(
            onTap: provider.isLoaded
                ? null
                : () {
              provider.loginWithEmail(context);
            },
            child: Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF1DBF73), Color(0xFF0E9F6E)],
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              alignment: Alignment.center,
              child: provider.isLoaded
                  ? const SizedBox(
                height: 22,
                width: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
                  : const Text(
                "Login",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

       spaceHeight(15),

          /// 🔹 SIGNUP NAVIGATION
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Don't have an account? "),
              GestureDetector(
                onTap: () {
                  provider.navigateTo(context, RouteNames.signUpScreen);
                },
                child: const Text(
                  "Sign Up",
                  style: TextStyle(
                    color: Color(0xFF1DBF73),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  // ---------------- GOOGLE BUTTON ----------------

  Widget _buildGoogleButton() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 40),
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10),
        ],
      ),
      alignment: Alignment.center,
      child: const Text(
        "Sign in with Google",
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
    );
  }

  // ---------------- TERMS ----------------

  Widget _buildTerms() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 40),
      child: Text(
        "By continuing, you agree to our Terms and Privacy Policy",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 12, color: Colors.black),
      ),
    );
  }
}
