import 'package:app_grownidhi/features/screens/individual/profile/profile_provider.dart';
import 'package:app_grownidhi/routes/route_names.dart';
import 'package:app_grownidhi/widget/ui_design.dart';
import 'package:base_module/core/app_dialog.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../widget/help_widget.dart';

import 'package:flutter/material.dart';

enum SlideDirection { top, bottom, left, right }

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff5f7fb),
      body: Stack(
        children: [
          AppGradientBackground(),

          SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                pageEntryAnimation(
                  direction: SlideDirection.top,
                  child: _buildHeader(),
                ),

                spaceHeight(20),

                pageEntryAnimation(
                  direction: SlideDirection.left,
                  child: _buildStatsSection(),
                ),

                spaceHeight(20),

                pageEntryAnimation(
                  direction: SlideDirection.right,
                  child: _buildExpandableSection(context),
                ),

                spaceHeight(20),

                pageEntryAnimation(
                  direction: SlideDirection.bottom,
                  child: _buildQuickLinks(),
                ),

                spaceHeight(20),

                pageEntryAnimation(
                  direction: SlideDirection.bottom,
                  child: _buildLogoutButton(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// ---------------- ANIMATION ----------------
  Widget pageEntryAnimation({
    required Widget child,
    required SlideDirection direction,
    Duration duration = const Duration(milliseconds: 700),
  }) {
    Offset beginOffset;

    switch (direction) {
      case SlideDirection.top:
        beginOffset = const Offset(0, -0.3);
        break;
      case SlideDirection.bottom:
        beginOffset = const Offset(0, 0.3);
        break;
      case SlideDirection.left:
        beginOffset = const Offset(-0.3, 0);
        break;
      case SlideDirection.right:
        beginOffset = const Offset(0.3, 0);
        break;
    }

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: duration,
      curve: Curves.easeOutCubic,
      builder: (context, value, _) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(
              beginOffset.dx * (1 - value) * 100,
              beginOffset.dy * (1 - value) * 100,
            ),
            child: Transform.scale(scale: 0.95 + (value * 0.05), child: child),
          ),
        );
      },
      child: child,
    );
  }

  /// ---------------- HEADER ----------------
  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        gradient: const LinearGradient(
          colors: [Color(0xff0f2027), Color(0xff2c5364)],
        ),
      ),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              const CircleAvatar(
                radius: 35,
                backgroundColor: Colors.green,
                child: Icon(Icons.person, color: Colors.white, size: 30),
              ),
              Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: Colors.orange,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.workspace_premium,
                  size: 14,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          spaceHeight(10),
          const Text(
            "Rimjhim Kumar",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          const Text(
            "rimjhim@example.com",
            style: TextStyle(color: Colors.white70),
          ),
          spaceHeight(10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              "Premium Member",
              style: TextStyle(color: Colors.blue),
            ),
          ),
        ],
      ),
    );
  }

  /// ---------------- STATS ----------------
  Widget _buildStatsSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _statCard("12", "Products"),
        _statCard("₹15.4L", "Net Worth"),
        _statCard("3", "Alerts"),
      ],
    );
  }

  Widget _statCard(String value, String label) {
    return Container(
      width: 100,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
        ],
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          spaceHeight(4),
          Text(label, style: const TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }

  /// ---------------- EXPANDABLE ----------------
  Widget _buildExpandableSection(BuildContext context) {
    return Column(
      children: [
        _expandTile(context, Icons.person, "Account Settings", Colors.blue),
        _expandTile(
          context,
          Icons.notifications,
          "Notifications",
          Colors.purple,
        ),
        _expandTile(context, Icons.lock, "Security & Privacy", Colors.green),
      ],
    );
  }

  Widget _expandTile(
    BuildContext context,
    IconData icon,
    String title,
    Color color,
  ) {
    return Theme(
      data: Theme.of(context).copyWith(
        dividerColor: Colors.transparent,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: Consumer<ProfileProvider>(
        builder: (context, provider, child) =>  Container(
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
          ),
          child: ExpansionTile(
            tilePadding: const EdgeInsets.symmetric(horizontal: 16),
            collapsedShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
              side: BorderSide.none,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
              side: BorderSide.none,
            ),
            leading: CircleAvatar(
              backgroundColor: color,
              child: Icon(icon, color: Colors.white),
            ),
            title: Text(title),
            children: [
              _buildTile(Icons.person, "My Profile", () {}),
              _divider(),
              _buildTile(Icons.verified_user, "KYC Documents", ()=> provider.navigateTo(context, RouteNames.kycScreen)),
              _divider(),
              _buildTile(Icons.lock, "Change Password", () {}),
              _divider(),
              _buildTile(Icons.privacy_tip, "Privacy Settings", () {}),
            ],
          ),
        ),
      ),
    );
  }

  /// ---------------- QUICK LINKS ----------------
  Widget _buildQuickLinks() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Quick Links",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        spaceHeight(10),
        _linkTile("Help & Support"),
        _linkTile("Terms & Conditions"),
        _linkTile("Share App"),
        _linkTile("App Settings"),
      ],
    );
  }

  Widget _linkTile(String title) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: ListTile(
        leading: const Icon(Icons.circle_outlined),
        title: Text(title),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      ),
    );
  }

  Widget _buildTile(IconData icon, String title, VoidCallback onTap) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Color(0xFF1DBF73).withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: Color(0xFF1DBF73)),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 16),
          ],
        ),
      ),
    );
  }

  Widget _divider() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Divider(height: 1),
    );
  }

  /// ---------------- LOGOUT ----------------
  Widget _buildLogoutButton(BuildContext context) {
    return InkWell(
      onTap: () =>
          AppDialogs.showLogoutDialog(context, RouteNames.signInScreen),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Colors.red, Colors.redAccent],
          ),
          borderRadius: BorderRadius.circular(25),
        ),
        child: const Center(
          child: Text(
            "Logout",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
