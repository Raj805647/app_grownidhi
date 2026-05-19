import 'dart:io';

import 'package:app_grownidhi/widget/custom_appbat.dart';
import 'package:app_grownidhi/widget/custom_textfield.dart';
import 'package:app_grownidhi/widget/ui_design.dart';
import 'package:flutter/material.dart';

import '../../../../widget/custom_button.dart';
import '../../../../widget/help_widget.dart';
import 'agent_kyc_provider.dart';
import 'package:provider/provider.dart';

class AgentKycScreen extends StatelessWidget {
  const AgentKycScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Agent KYC Update'),
      body: Stack(
        children: [
          AppGradientBackground(),

          Consumer<AgentKycProvider>(
            builder: (context, provider, child) {
              return SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [

                    /// DOB
                    customTextField(
                      controller: provider.dobController,
                      hintText: "Date of Birth",
                      isRead: true,
                      onTap: () => pickDateTime(
                        context,
                        provider.dobController,
                        includeTime: false,
                      ),
                    ),

                    spaceHeight(12),

                    /// Gender
                    customDropdown(
                      value: provider.gender,
                      label: "Gender",
                      items: const [
                        "Male",
                        "Female",
                        "Other",
                      ],
                      onChanged: (value) {
                        provider.gender = value!;
                        provider.notifyListeners();
                      },
                    ),

                    spaceHeight(12),

                    /// PAN
                    customTextField(
                      controller: provider.panController,
                      hintText: "PAN Number",
                    ),

                    spaceHeight(12),

                    /// Aadhar
                    customTextField(
                      controller: provider.aadharController,
                      hintText: "Aadhar Number",
                    ),

                    spaceHeight(12),

                    /// Father Name
                    customTextField(
                      controller: provider.fatherNameController,
                      hintText: "Father Name",
                    ),

                    spaceHeight(12),

                    /// Address 1
                    customTextField(
                      controller: provider.address1Controller,
                      hintText: "Address Line 1",
                    ),

                    spaceHeight(12),

                    /// Address 2
                    customTextField(
                      controller: provider.address2Controller,
                      hintText: "Address Line 2",
                    ),

                    spaceHeight(12),

                    /// City
                    customTextField(
                      controller: provider.cityController,
                      hintText: "City",
                    ),

                    spaceHeight(12),

                    /// State
                    customTextField(
                      controller: provider.stateController,
                      hintText: "State",
                    ),

                    spaceHeight(12),

                    /// Pincode
                    customTextField(
                      controller: provider.pincodeController,
                      hintText: "Pincode",
                    ),

                    spaceHeight(12),

                    /// Country
                    customTextField(
                      controller: provider.countryController,
                      hintText: "Country",
                    ),

                    spaceHeight(12),

                    /// Account Holder
                    customTextField(
                      controller:
                      provider.accountHolderController,
                      hintText: "Account Holder Name",
                    ),

                    spaceHeight(12),

                    /// Bank Name
                    customTextField(
                      controller: provider.bankNameController,
                      hintText: "Bank Name",
                    ),

                    spaceHeight(12),

                    /// Account Number
                    customTextField(
                      controller:
                      provider.accountNumberController,
                      hintText: "Account Number",
                    ),

                    spaceHeight(12),

                    /// IFSC
                    customTextField(
                      controller: provider.ifscController,
                      hintText: "IFSC Code",
                    ),

                    spaceHeight(12),

                    /// Branch
                    customTextField(
                      controller: provider.branchController,
                      hintText: "Branch Name",
                    ),

                    spaceHeight(20),


                    documentUploadWidget(
                      label: "PAN Card Front",
                      imageFile: provider.getImage("panFront"),
                      onPick: () {
                        provider.pickImage(
                          context: context,
                          keyName: "panFront",
                        );
                      },
                      onRemove: () {
                        provider.removeImage("panFront");
                      },
                    ),

                    spaceHeight( 20),

                    documentUploadWidget(
                      label: "PAN Card Back",
                      imageFile: provider.getImage("panBack"),
                      onPick: () {
                        provider.pickImage(
                          context: context,
                          keyName: "panBack",
                        );
                      },
                      onRemove: () {
                        provider.removeImage("panBack");
                      },
                    ),

                    spaceHeight(20),

                    documentUploadWidget(
                      label: "Profile Photo",
                      imageFile: provider.getImage("profile"),
                      onPick: () {
                        provider.pickImage(
                          context: context,
                          keyName: "profile",
                        );
                      },
                      onRemove: () {
                        provider.removeImage("profile");
                      },
                    ),
                    spaceHeight(20),

                    documentUploadWidget(
                      label: "Aadhaar Front",
                      imageFile: provider.getImage("aadharFront"),
                      onPick: () {
                        provider.pickImage(
                          context: context,
                          keyName: "aadharFront",
                        );
                      },
                      onRemove: () {
                        provider.removeImage("aadharFront");
                      },
                    ),
                    spaceHeight(20),

                    documentUploadWidget(
                      label: "Aadhaar Back",
                      imageFile: provider.getImage("aadharBack"),
                      onPick: () {
                        provider.pickImage(
                          context: context,
                          keyName: "aadharBack",
                        );
                      },
                      onRemove: () {
                        provider.removeImage("aadharBack");
                      },
                    ),
                    spaceHeight(24),

                    CustomLoadingButton(
                      isLoading: provider.isLoading,
                      text: "Submit KYC",
                      loadingText: "Submitting...",
                      onTap: () => provider.submitKycUpdate(context),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget documentUploadWidget({
    required String label,
    required File? imageFile,
    required VoidCallback onPick,
    required VoidCallback onRemove,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        /// Label
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),

        const SizedBox(height: 10),

        GestureDetector(
          onTap: onPick,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey.shade400,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: imageFile != null
                ? Stack(
              alignment: Alignment.topRight,
              children: [

                /// Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.file(
                    imageFile,
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),

                /// Remove Button
                GestureDetector(
                  onTap: onRemove,
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ],
            )
                : Column(
              children: [
                const Icon(
                  Icons.upload_file,
                  size: 40,
                  color: Colors.blue,
                ),
                const SizedBox(height: 8),
                Text("Upload $label"),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
