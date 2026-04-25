import 'package:app_grownidhi/features/screens/product_details/product_details_provider.dart';
import 'package:app_grownidhi/widget/ui_design.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../widget/help_widget.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen>
    with SingleTickerProviderStateMixin {
  late ProductDetailProvider provider;

  @override
  void initState() {
    super.initState();

    provider = context.read<ProductDetailProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _buildBottomButton(),
      body: Stack(
        children: [
          AppGradientBackground(),
          SingleChildScrollView(
            child: Column(
              children: [
                _buildAnimatedHeader(context, provider),

                spaceHeight(18),

                _buildAnimatedSection(
                  delay: 0,
                  title: "Key Information",
                  child: _buildInfoCard(),
                ),

                spaceHeight(18),

                _buildAnimatedSection(
                  delay: 200,
                  title: "Documents",
                  child: _buildDocsCard(),
                ),

                spaceHeight(100),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedHeader(
    BuildContext context,
    ProductDetailProvider provider,
  ) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(32)),
        gradient: LinearGradient(
          colors: [Color(0xff0f2027), Color(0xff2c5364)],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                backgroundColor: Colors.white24,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              const CircleAvatar(
                backgroundColor: Colors.white24,
                child: Icon(Icons.share, color: Colors.white),
              ),
            ],
          ),

          spaceHeight(24),

          Row(
            children: [
              const Expanded(
                child: Text(
                  "HDFC Life Insurance ✨",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              /// Animated badge
              AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: Colors.green.shade100,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  "Active",
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          spaceHeight(8),

          const Text(
            "HDFC Life",
            style: TextStyle(color: Colors.white70),
          ),

          spaceHeight(6),

          const Text(
            "Policy #POL/2023/123456",
            style: TextStyle(color: Colors.white70),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedSection({
    required int delay,
    required String title,
    required Widget child,
  }) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: Duration(milliseconds: 500 + delay),
      curve: Curves.easeOutBack,
      builder: (context, value, widget) {
        return Transform.translate(
          offset: Offset(0, 40 * (1 - value)),
          child: Opacity(
            opacity: value.clamp(0.0, 1.0).toDouble(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  spaceHeight(10),
                  child,
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildInfoCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration(),
      child: Column(
        children: [
          _infoRow("Premium Amount", "₹12,500", "Sum Assured", "₹50,00,000"),
          _infoRow("Start Date", "15 Mar 2023", "Renewal Date", "15 Mar 2026"),
          _infoRow("Frequency", "Quarterly", "Nominee", "Rajesh Kumar"),
        ],
      ),
    );
  }

  Widget _buildDocsCard() {
    return Container(
      decoration: _cardDecoration(),
      child: const Column(
        children: [
          ListTile(
            leading: Icon(Icons.description, color: Colors.green),
            title: Text("Policy Document"),
            subtitle: Text("2.4 MB • 15 Mar 2023"),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.receipt_long, color: Colors.blue),
            title: Text("Premium Receipt"),
            subtitle: Text("156 KB • 15 Dec 2025"),
          ),
        ],
      ),
    );
  }

  Widget _infoRow(String t1, String v1, String t2, String v2) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        children: [
          Expanded(child: _columnText(t1, v1)),
          Expanded(child: _columnText(t2, v2)),
        ],
      ),
    );
  }

  Widget _columnText(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(color: Colors.grey)),
        spaceHeight(4),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 12),
      ],
    );
  }

  Widget _buildBottomButton() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: ElevatedButton.icon(
        onPressed: () {},
        icon: const Icon(Icons.edit, color: Colors.white),
        label: const Text(
          "Edit Details",
          style: TextStyle(color: Colors.white),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    );
  }
}
