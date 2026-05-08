import 'package:app_grownidhi/widget/help_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../widget/ui_design.dart';
import '../../../../widget/custom_textfield.dart';
import '../../../../widget/ui_design.dart';
import 'add_product_details_provider.dart';

class AddProductDetailsScreen extends StatefulWidget {
  const AddProductDetailsScreen({super.key});

  @override
  State<AddProductDetailsScreen> createState() =>
      _AddProductDetailsScreenState();
}

class _AddProductDetailsScreenState extends State<AddProductDetailsScreen> {
  late AddProductDetailsProvider provider;
  @override
  void initState() {
    super.initState();
    provider = context.read<AddProductDetailsProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AppGradientBackground(),
          SingleChildScrollView(
            padding: EdgeInsets.all(15),
            child: Column(
              children: [
                _buildHeader(context),
                spaceHeight(10),
                _buildSectionCard(
                  title: "Basic Information",
                  color: Colors.green,
                  children: [
                    customTextField(hintText: "Product Name"),
                    spaceHeight(8),
                    customTextField(hintText: "Company/Provider"),
                    spaceHeight(8),
                    customTextField(hintText: "Policy/Account Number"),
                  ],
                ),

                spaceHeight(16),

                _buildSectionCard(
                  title: "Financial Information",
                  color: Colors.blue,
                  children: [customTextField(hintText: "Premium/EMI Amount")],
                ),

                spaceHeight(16),

                _buildSectionCard(
                  title: "Important Dates",
                  color: Colors.purple,
                  children: [
                    customTextField(hintText: "Start Date"),
                    spaceHeight(8),
                    customTextField(hintText: "End Date"),
                    spaceHeight(8),
                    customTextField(hintText: "Next Payment Date"),
                    spaceHeight(8),
                  ],
                ),

                spaceHeight(80),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
            backgroundColor: Colors.green,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(17),
            ),
          ),
          child: const Text("Save Product", style: TextStyle(fontSize: 16,color: Colors.white)),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios_new),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "Add Product Details",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          spaceHeight(6),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: const Text(
              "Fill in the details below",
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionCard({
    required String title,
    required Color color,
    required List<Widget> children,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 18,
                width: 4,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),

          spaceHeight(12),

          ...children,
        ],
      ),
    );
  }
}
