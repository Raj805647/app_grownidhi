import 'package:app_grownidhi/widget/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'kyc_update_provider.dart';

class KycUpdateScreen extends StatelessWidget {
  const KycUpdateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text(
          "KYC Update",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black87,
        centerTitle: false,
      ),
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Complete Your KYC",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Please verify your identity to unlock all features",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white.withOpacity(0.9),
                        ),
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
                          CustomTextField(
                            hintText: "Date of Birth (YYYY-MM-DD)",
                            controller: provider.dobController,
                            prefixIcon: Icons.calendar_today,
                          ),
                          const SizedBox(height: 12),
                          customDropdown(
                            label: "Gender",
                            value: provider.gender,
                            items: ["male", "female"],
                            onChanged: provider.setGender,
                          ),
                          const SizedBox(height: 12),
                          CustomTextField(
                            hintText: "PAN Number",
                            controller: provider.panController,
                            prefixIcon: Icons.credit_card,
                          ),
                          const SizedBox(height: 12),
                          CustomTextField(
                            hintText: "Aadhaar Number",
                            controller: provider.aadhaarController,
                            prefixIcon: Icons.fingerprint,
                          ),
                          const SizedBox(height: 12),
                          CustomTextField(
                            hintText: "Father's Name",
                            controller: provider.fatherController,
                            prefixIcon: Icons.family_restroom,
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      /// 🔹 ADDRESS
                      _sectionCard(
                        title: "Address Details",
                        icon: Icons.location_city_outlined,
                        children: [
                          CustomTextField(
                            hintText: "Address Line 1",
                            controller: provider.address1Controller,
                            prefixIcon: Icons.home,
                          ),
                          const SizedBox(height: 12),
                          CustomTextField(
                            hintText: "Address Line 2",
                            controller: provider.address2Controller,
                            prefixIcon: Icons.home_work,
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Expanded(
                                child: CustomTextField(
                                  hintText: "City",
                                  controller: provider.cityController,
                                  prefixIcon: Icons.location_city,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: CustomTextField(
                                  hintText: "State",
                                  controller: provider.stateController,
                                  prefixIcon: Icons.map,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Expanded(
                                child: CustomTextField(
                                  hintText: "Pincode",
                                  controller: provider.pincodeController,
                                  prefixIcon: Icons.pin_drop,
                                  keyboardType: TextInputType.number,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: CustomTextField(
                                  hintText: "Country",
                                  controller: provider.countryController,
                                  prefixIcon: Icons.public,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      /// 🔹 BANK DETAILS
                      _sectionCard(
                        title: "Bank Details",
                        icon: Icons.account_balance_outlined,
                        children: [
                          CustomTextField(
                            hintText: "Account Holder Name",
                            controller: provider.accountNameController,
                            prefixIcon: Icons.person,
                          ),
                          const SizedBox(height: 12),
                          CustomTextField(
                            hintText: "Bank Name",
                            controller: provider.bankController,
                            prefixIcon: Icons.account_balance,
                          ),
                          const SizedBox(height: 12),
                          CustomTextField(
                            hintText: "Account Number",
                            controller: provider.accountNumberController,
                            prefixIcon: Icons.numbers,
                            keyboardType: TextInputType.number,
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Expanded(
                                child: CustomTextField(
                                  hintText: "IFSC Code",
                                  controller: provider.ifscController,
                                  prefixIcon: Icons.code,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: CustomTextField(
                                  hintText: "Branch Name",
                                  controller: provider.branchController,
                                  prefixIcon: Icons.business,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      /// 🔹 DOCUMENT UPLOAD SECTION (MOVED TO BOTTOM)
                      Container(
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
                                      color: Color(0xFF1DBF73).withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Icon(
                                      Icons.upload_file,
                                      color: Color(0xFF1DBF73),
                                      size: 20,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  const Text(
                                    "Upload Documents",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Divider(height: 1),

                            // Document upload items
                            _buildDocumentTile(
                              title: "PAN Card (Front)",
                              fileName: provider.panFront,
                              onTap: () => provider.pickFile("pan_front"),
                              required: true,
                            ),
                            _buildDocumentTile(
                              title: "PAN Card (Back)",
                              fileName: provider.panBack,
                              onTap: () => provider.pickFile("pan_back"),
                              required: true,
                            ),
                            _buildDocumentTile(
                              title: "Aadhaar Card (Front)",
                              fileName: provider.aadhaarFront,
                              onTap: () => provider.pickFile("aadhaar_front"),
                              required: true,
                            ),
                            _buildDocumentTile(
                              title: "Aadhaar Card (Back)",
                              fileName: provider.aadhaarBack,
                              onTap: () => provider.pickFile("aadhaar_back"),
                              required: true,
                            ),
                            _buildDocumentTile(
                              title: "Selfie with ID Proof",
                              fileName: provider.selfie,
                              onTap: () => provider.pickFile("selfie"),
                              required: true,
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 30),

                      /// 🔹 SUBMIT BUTTON
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
                          child: provider.isLoading
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

                      const SizedBox(height: 20),
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

  /// 🔹 Section Card Widget
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

  /// 🔹 Document Tile with Better UI
  Widget _buildDocumentTile({
    required String title,
    required String? fileName,
    required VoidCallback onTap,
    required bool required,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.grey.shade100),
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: fileName != null
                    ? const Color(0xFF1DBF73).withOpacity(0.1)
                    : Colors.grey.shade100,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                fileName != null ? Icons.check_circle : Icons.cloud_upload,
                color: fileName != null
                    ? const Color(0xFF1DBF73)
                    : Colors.grey.shade600,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey.shade800,
                        ),
                      ),
                      if (required) ...[
                        const SizedBox(width: 4),
                        Text(
                          "*",
                          style: TextStyle(color: Colors.red.shade500),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    fileName ?? "No file selected",
                    style: TextStyle(
                      fontSize: 12,
                      color: fileName != null
                          ? const Color(0xFF1DBF73)
                          : Colors.grey.shade500,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 14,
              color: Colors.grey.shade400,
            ),
          ],
        ),
      ),
    );
  }
}