import 'dart:io';

import 'package:app_grownidhi/widget/custom_textfield.dart';
import 'package:base_module/image_file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../widget/help_widget.dart';
import 'kyc_update_provider.dart';

class KycUpdateScreen extends StatelessWidget {
  const KycUpdateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: Consumer<KycUpdateProvider>(
        builder: (context, provider, child) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Banner
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF1DBF73), Color(0xFF0E9F6E)],
                    ),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(24),
                      bottomRight: Radius.circular(24),
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.white24,
                        child: IconButton(
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            "Complete Your KYC",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          spaceHeight(8),
                          Text(
                            "Please verify your identity to unlock all features",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white.withOpacity(0.9),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// 🔹 PERSONAL DETAILS
                      _sectionCard(
                        title: "Personal Details",
                        icon: Icons.person_outline,
                        children: [
                          customTextField(
                            hintText: "Date of Birth (YYYY-MM-DD)",
                            controller: provider.dobController,
                            prefixIcon: Icons.calendar_today,
                            isRead: true,
                            onTap: () => pickDateTime(
                              context,
                              provider.dobController,
                              includeTime: false,
                            ),
                          ),
                          spaceHeight(12),
                          customDropdown(
                            label: "Gender",
                            value: provider.gender,
                            items: ["male", "female"],
                            onChanged: provider.setGender,
                          ),
                          spaceHeight(12),
                          customTextField(
                            hintText: "PAN Number",
                            controller: provider.panController,
                            prefixIcon: Icons.credit_card,
                            maxLength: 10,
                          ),
                          spaceHeight(12),
                          customTextField(
                            hintText: "Aadhaar Number",
                            controller: provider.aadhaarController,
                            prefixIcon: Icons.fingerprint,
                            maxLength: 12,
                            keyboardType: TextInputType.number,
                          ),
                          spaceHeight(12),
                          customTextField(
                            hintText: "Father's Name",
                            controller: provider.fatherController,
                            prefixIcon: Icons.family_restroom,
                          ),
                        ],
                      ),

                      spaceHeight(20),

                      /// 🔹 ADDRESS
                      _sectionCard(
                        title: "Address Details",
                        icon: Icons.location_city_outlined,
                        children: [
                          customTextField(
                            hintText: "Address Line 1",
                            controller: provider.address1Controller,
                            prefixIcon: Icons.home,
                          ),
                          spaceHeight(12),
                          customTextField(
                            hintText: "Address Line 2",
                            controller: provider.address2Controller,
                            prefixIcon: Icons.home_work,
                          ),
                          spaceHeight(12),
                          Row(
                            children: [
                              Expanded(
                                child: customTextField(
                                  hintText: "City",
                                  controller: provider.cityController,
                                  prefixIcon: Icons.location_city,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: customTextField(
                                  hintText: "State",
                                  controller: provider.stateController,
                                  prefixIcon: Icons.map,
                                ),
                              ),
                            ],
                          ),
                          spaceHeight(12),
                          Row(
                            children: [
                              Expanded(
                                child: customTextField(
                                  hintText: "Pincode",
                                  controller: provider.pincodeController,
                                  prefixIcon: Icons.pin_drop,
                                  maxLength: 6,
                                  keyboardType: TextInputType.number,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: customTextField(
                                  hintText: "Country",
                                  controller: provider.countryController,
                                  prefixIcon: Icons.public,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      spaceHeight(20),

                      /// 🔹 BANK DETAILS
                      _sectionCard(
                        title: "Bank Details",
                        icon: Icons.account_balance_outlined,
                        children: [
                          customTextField(
                            hintText: "Account Holder Name",
                            controller: provider.accountNameController,
                            prefixIcon: Icons.person,
                          ),
                          spaceHeight(12),
                          customTextField(
                            hintText: "Bank Name",
                            controller: provider.bankController,
                            prefixIcon: Icons.account_balance,
                          ),
                          spaceHeight(12),
                          customTextField(
                            hintText: "Account Number",
                            controller: provider.accountNumberController,
                            prefixIcon: Icons.numbers,
                            keyboardType: TextInputType.number,
                            maxLength: 13,
                          ),
                          spaceHeight(12),
                          Row(
                            children: [
                              Expanded(
                                child: customTextField(
                                  hintText: "IFSC Code",
                                  controller: provider.ifscController,
                                  prefixIcon: Icons.code,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: customTextField(
                                  hintText: "Branch Name",
                                  controller: provider.branchController,
                                  prefixIcon: Icons.business,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      spaceHeight(20),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.04),
                              blurRadius: 20,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // PAN Card Section
                            _buildSectionHeader(
                              icon: Icons.credit_card,
                              title: "PAN Card",
                              subtitle: "Upload front and back side of your PAN card",
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                Expanded(child: _buildModernImageUpload(
                                  context: context,
                                  label: "Front Side",
                                  type: "pan_front",
                                )),
                                const SizedBox(width: 16),
                                Expanded(child: _buildModernImageUpload(
                                  context: context,
                                  label: "Back Side",
                                  type: "pan_back",
                                )),
                              ],
                            ),

                            const SizedBox(height: 32),

                            // Aadhaar Card Section
                            _buildSectionHeader(
                              icon: Icons.assignment_ind,
                              title: "Aadhaar Card",
                              subtitle: "Upload front and back side of your Aadhaar card",
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                Expanded(child: _buildModernImageUpload(
                                  context: context,
                                  label: "Front Side",
                                  type: "aadhaar_front",
                                )),
                                const SizedBox(width: 16),
                                Expanded(child: _buildModernImageUpload(
                                  context: context,
                                  label: "Back Side",
                                  type: "aadhaar_back",
                                )),
                              ],
                            ),

                            const SizedBox(height: 32),

                            // Selfie Section
                            _buildSectionHeader(
                              icon: Icons.camera_alt,
                              title: "Selfie Verification",
                              subtitle: "Take a clear selfie holding your ID proof",
                            ),
                            const SizedBox(height: 16),
                            Center(
                              child: SizedBox(
                                width: 180,
                                child: _buildModernImageUpload(
                                  context: context,
                                  label: "Take Your Selfie",
                                  type: "selfie",
                                  isSelfie: true,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),


                      spaceHeight(30),

                      InkWell(
                        onTap: provider.submitKyc,
                        child: Container(
                          height: 55,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            gradient: const LinearGradient(
                              colors: [Color(0xFF1DBF73), Color(0xFF0E9F6E)],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF1DBF73).withOpacity(0.3),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          alignment: Alignment.center,
                          child: provider.isLoaded
                              ? const SizedBox(
                                  height: 24,
                                  width: 24,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Text(
                                  "Submit KYC",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                      ),

                      spaceHeight(20),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _sectionCard({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1DBF73).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: const Color(0xFF1DBF73), size: 20),
                ),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: children,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                const Color(0xFF1DBF73).withOpacity(0.15),
                const Color(0xFF1DBF73).withOpacity(0.05),
              ],
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: const Color(0xFF1DBF73), size: 24),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildModernImageUpload({
    required BuildContext context,
    required String label,
    required String type,
    bool isSelfie = false,
  }) {
    return Consumer<KycUpdateProvider>(
      builder: (context, provider, child) {
        final imagePath = provider.getImagePath(type);
        return Column(
          children: [
            // Upload Container
            GestureDetector(
              onTap: () async {},
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Main Container
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    height: isSelfie ? 180 : 140,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: imagePath != null
                            ? const Color(0xFF1DBF73).withOpacity(0.5)
                            : Colors.grey.shade200,
                        width: imagePath != null ? 2 : 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.02),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: imagePath != null
                          ? Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.file(
                            File(imagePath),
                            fit: isSelfie ? BoxFit.cover : BoxFit.contain,
                          ),
                          // Overlay gradient
                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.black.withOpacity(0.3),
                                  Colors.transparent,
                                  Colors.black.withOpacity(0.2),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                          : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: const Color(0xFF1DBF73).withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              isSelfie ? Icons.camera_alt : Icons.cloud_upload,
                              size: 32,
                              color: const Color(0xFF1DBF73),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            isSelfie ? "Tap to capture" : "Tap to upload",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Loading Overlay
                    Container(
                      height: isSelfie ? 180 : 140,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Center(
                        child: CircularProgressIndicator(
                          color: Color(0xFF1DBF73),
                        ),
                      ),
                    ),

                  // Badge for uploaded status
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1DBF73),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Icon(
                          Icons.check,
                          size: 12,
                          color: Colors.white,
                        ),
                      ),
                    ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // Label Row with Remove Option
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.image_outlined,
                      size: 14,
                      color: Colors.grey.shade600,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      label,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ],
                ),

                if (imagePath != null)
                  GestureDetector(
                    onTap: () {
                      _showDeleteConfirmation(context, () {
                        provider.removeImage(type);
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.delete_outline,
                            size: 12,
                            color: Colors.red.shade400,
                          ),
                          const SizedBox(width: 2),
                          Text(
                            "Remove",
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.red.shade400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ],
        );
      },
    );
  }
  void _showDeleteConfirmation(BuildContext context, VoidCallback onDelete) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: const Text("Remove Image"),
        content: const Text("Are you sure you want to remove this image?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              "Cancel",
              style: TextStyle(color: Colors.grey.shade600),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              onDelete();
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.red,
            ),
            child: const Text("Remove"),
          ),
        ],
      ),
    );
  }
}
