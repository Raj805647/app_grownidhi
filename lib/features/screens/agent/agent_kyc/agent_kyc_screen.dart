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

                    /// PAN Card Upload
                    GestureDetector(
                      onTap: () {
                        provider.pickExperienceDocument(
                            context);
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey.shade400,
                          ),
                          borderRadius:
                          BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            const Icon(
                              Icons.upload_file,
                              size: 40,
                              color: Colors.blue,
                            ),
                            const SizedBox(height: 8),

                            Text(
                              provider.panCardImage != null
                                  ? "PAN Card Selected"
                                  : "Upload PAN Card",
                            ),
                          ],
                        ),
                      ),
                    ),

                    spaceHeight(24),

                    CustomLoadingButton(
                      isLoading: provider.isLoading,
                      text: "Submit KYC",
                      loadingText: "Submitting...",
                      onTap: () {
                        provider.submitKyc();
                      },
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
}
