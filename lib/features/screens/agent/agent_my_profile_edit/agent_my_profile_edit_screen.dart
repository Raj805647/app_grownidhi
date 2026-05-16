import 'dart:io';

import 'package:app_grownidhi/features/screens/agent/agent_my_profile_edit/agent_my_profile_edit_provider.dart';
import 'package:app_grownidhi/widget/custom_appbat.dart';
import 'package:app_grownidhi/widget/custom_textfield.dart';
import 'package:app_grownidhi/widget/ui_design.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AgentMyProfileEditScreen extends StatelessWidget {
  const AgentMyProfileEditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AgentMyProfileEditProvider>(context);

    return Scaffold(
      appBar: CustomAppBar(title: 'Update Profile Details'),
      body: Stack(
        children: [
          /// Background
          AppGradientBackground(),

          /// Form
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  /// Full Name
                  customTextField(
                    hintText: 'Full Name',
                    controller: provider.fullNameController,
                  ),

                  const SizedBox(height: 12),

                  /// Father Name
                  customTextField(
                    hintText: 'Father Name',
                    controller: provider.fatherNameController,
                  ),

                  const SizedBox(height: 12),

                  /// Mobile Number
                  customTextField(
                    hintText: 'Mobile Number',
                    controller: provider.mobileNumberController,
                    keyboardType: TextInputType.phone,
                  ),

                  const SizedBox(height: 12),

                  /// Alternate Mobile Number
                  customTextField(
                    hintText: 'Alternate Mobile Number',
                    controller: provider.alternateMobileNumberController,
                    keyboardType: TextInputType.phone,
                  ),

                  const SizedBox(height: 12),

                  /// Email
                  customTextField(
                    hintText: 'Email',
                    controller: provider.emailController,
                    keyboardType: TextInputType.emailAddress,
                  ),

                  const SizedBox(height: 12),

                  /// DOB
                  customTextField(
                    hintText: 'Date Of Birth',
                    controller: provider.dobController,
                  ),

                  const SizedBox(height: 12),

                  /// Gender Dropdown
                  customDropdown(
                    value: provider.genderController.text,
                    label: 'Gender',
                    items: const ['Male', 'Female', 'Other'],
                    onChanged: (value) {
                      // provider.changeGender(value);
                    },
                  ),

                  const SizedBox(height: 12),

                  /// Marital Status Dropdown
                  customDropdown(
                    value: provider.maritalStatusController.text,
                    label: 'Marital Status',
                    items: const ['Single', 'Married', 'Divorced'],
                    onChanged: (value) {
                      // provider.changeMaritalStatus(value);
                    },
                  ),

                  const SizedBox(height: 12),

                  /// Address Line 1
                  customTextField(
                    hintText: 'Address Line 1',
                    controller: provider.addressLine1Controller,
                  ),

                  const SizedBox(height: 12),

                  /// Address Line 2
                  customTextField(
                    hintText: 'Address Line 2',
                    controller: provider.addressLine2Controller,
                  ),

                  const SizedBox(height: 12),

                  /// City
                  customTextField(
                    hintText: 'City',
                    controller: provider.cityController,
                  ),

                  const SizedBox(height: 12),

                  /// State
                  customTextField(
                    hintText: 'State',
                    controller: provider.stateController,
                  ),

                  const SizedBox(height: 12),

                  /// Pincode
                  customTextField(
                    hintText: 'Pincode',
                    controller: provider.pincodeController,
                    keyboardType: TextInputType.number,
                  ),

                  const SizedBox(height: 12),

                  /// Country
                  customTextField(
                    hintText: 'Country',
                    controller: provider.countryController,
                  ),

                  const SizedBox(height: 12),

                  /// Occupation
                  customTextField(
                    hintText: 'Occupation',
                    controller: provider.occupationController,
                  ),

                  const SizedBox(height: 12),

                  /// Designation
                  customTextField(
                    hintText: 'Designation',
                    controller: provider.designationController,
                  ),

                  const SizedBox(height: 12),

                  /// Experience
                  customTextField(
                    hintText: 'Experience',
                    controller: provider.experienceController,
                  ),

                  const SizedBox(height: 12),

                  /// Education
                  customTextField(
                    hintText: 'Education',
                    controller: provider.educationController,
                  ),

                  const SizedBox(height: 12),

                  /// Annual Income
                  customTextField(
                    hintText: 'Annual Income',
                    controller: provider.annualIncomeController,
                    keyboardType: TextInputType.number,
                  ),

                  const SizedBox(height: 12),

                  /// Monthly Income
                  customTextField(
                    hintText: 'Monthly Income',
                    controller: provider.monthlyIncomeController,
                    keyboardType: TextInputType.number,
                  ),

                  const SizedBox(height: 20),

                  /// Experience Upload
                  uploadCard(
                    title: 'Upload Experience Document',
                    file: provider.experienceDocument,
                    onTap: () {
                      provider.pickExperienceDocument(context);
                    },
                  ),

                  const SizedBox(height: 16),

                  /// Education Upload
                  uploadCard(
                    title: 'Upload Education Document',
                    file: provider.educationDocument,
                    onTap: () {
                      provider.pickEducationDocument(context);
                    },
                  ),

                  const SizedBox(height: 30),

                  /// Submit Button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        provider.updateCreateProfile();
                      },
                      child: provider.isLoading
                          ? const CircularProgressIndicator()
                          : const Text('Update Profile'),
                    ),
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget uploadCard({
    required String title,
    required File? file,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          children: [
            /// Upload Icon
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.upload_file, size: 24),
            ),

            const SizedBox(width: 12),

            /// File Name / Title
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    file != null
                        ? file.path.split('/').last
                        : 'Tap to upload file',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 10),

            /// Arrow Icon
            const Icon(Icons.arrow_forward_ios, size: 16),
          ],
        ),
      ),
    );
  }
}
