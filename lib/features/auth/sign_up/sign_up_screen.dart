import 'package:app_grownidhi/features/auth/sign_up/sign_up_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/app_images.dart';
import '../../../../widget/custom_textfield.dart';
import '../../../../widget/help_widget.dart';
import '../../../../widget/page_entry_animation.dart';
import '../../../../widget/ui_design.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                  child: _buildCard(context),
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
  }

  // ---------------- HEADER ----------------

  Widget _buildHeader() {
    return Column(
      children: [
        Container(
          height: 150,
          width: 150,
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
          "Create Account",
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0B1E2D),
          ),
        ),
        spaceHeight(10),
        const Text(
          "Start your financial journey today",
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  // ---------------- FEATURES ----------------

  Widget _buildFeatures() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _featureItem(Icons.lock_outline, "Secure"),
        _featureItem(Icons.speed, "Fast"),
        _featureItem(Icons.auto_awesome, "Smart"),
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
        Text(text, style: const TextStyle(fontSize: 12)),
      ],
    );
  }

  Widget _buildCard(BuildContext context) {
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
      child: Consumer<SignUpProvider>(
        builder: (context, provider, child) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Sign Up",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            spaceHeight(20),

            customTextField(
              hintText: "Full Name",
              controller: provider.nameController,
              prefixIcon: Icons.person,
            ),

            spaceHeight(15),

            customTextField(
              hintText: "Email",
              controller: provider.emailController,
              prefixIcon: Icons.email,
              keyboardType: TextInputType.emailAddress,
            ),

            spaceHeight(15),

            customTextField(
              hintText: "Mobile Number",
              controller: provider.numberController,
              prefixIcon: Icons.phone,
              keyboardType: TextInputType.number,
              maxLength: 10,
            ),

            spaceHeight(15),

            customTextField(
              hintText: "Password",
              controller: provider.passwordController,
              prefixIcon: Icons.lock,
              obscureText: !provider.isPasswordVisible,
              suffixIcon: InkWell(
                onTap: provider.togglePassword,
                child: Icon(
                  provider.isPasswordVisible
                      ? Icons.visibility
                      : Icons.visibility_off,
                ),
              ),
            ),

            spaceHeight(15),

            customTextField(
              hintText: "Confirm Password",
              controller: provider.confirmPasswordController,
              prefixIcon: Icons.lock_outline,
              obscureText: !provider.isConfirmPasswordVisible,
              suffixIcon: InkWell(
                onTap: provider.toggleConfirmPassword,
                child: Icon(
                  provider.isConfirmPasswordVisible
                      ? Icons.visibility
                      : Icons.visibility_off,
                ),
              ),
            ),
            spaceHeight(8),

            if (provider.confirmPasswordController.text.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  provider.isPasswordMatching()
                      ? "Passwords match"
                      : "Passwords do not match",
                  style: TextStyle(
                    color: provider.isPasswordMatching()
                        ? Colors.green
                        : Colors.red,
                    fontSize: 12,
                  ),
                ),
              ),
            spaceHeight(8),
            Row(
              children: [
                Expanded(
                  child: RadioListTile<String>(
                    value: "individual",
                    groupValue: provider.selectedType,
                    onChanged: (value) {
                      provider.setUserType(value!);
                    },
                    title: const Text("Individual"),
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                  ),
                ),
                Expanded(
                  child: RadioListTile<String>(
                    value: "agent",
                    groupValue: provider.selectedType,
                    onChanged: (value) {
                      provider.setUserType(value!);
                    },
                    title: const Text("Agent"),
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                  ),
                ),
              ],
            ),
            spaceHeight(25),

            InkWell(
              onTap: provider.isLoaded
                  ? null
                  : () {
                provider.submitRegister(context);
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
                  height: 24,
                  width: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
                    : const Text(
                  "Create Account",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
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
        "Sign up with Google",
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
    );
  }

  // ---------------- TERMS ----------------

  Widget _buildTerms() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 40),
      child: Text(
        "By creating an account, you agree to our Terms and Privacy Policy",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 12),
      ),
    );
  }
}