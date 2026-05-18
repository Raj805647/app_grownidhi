import 'dart:io';

import 'package:app_grownidhi/features/screens/agent/agent_my_profile_edit/agent_my_profile_edit_provider.dart';
import 'package:app_grownidhi/widget/custom_appbat.dart';
import 'package:app_grownidhi/widget/custom_textfield.dart';
import 'package:app_grownidhi/widget/ui_design.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../widget/help_widget.dart';

class AgentMyProfileEditScreen extends StatefulWidget {
  const AgentMyProfileEditScreen({super.key});

  @override
  State<AgentMyProfileEditScreen> createState() =>
      _AgentMyProfileEditScreenState();
}

class _AgentMyProfileEditScreenState extends State<AgentMyProfileEditScreen> {
  @override
  void initState() {
    // TODO: implement initState
    Future.microtask(() {
      context.read<AgentMyProfileEditProvider>().fetchCompanyList();
    });
    super.initState();
  }

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
          SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                /// Full Name
                customTextField(
                  hintText: 'Full Name',
                  controller: provider.fullNameController,
                  prefixIcon: Icons.person,
                ),

                spaceHeight(12),

                /// Father Name
                customTextField(
                  hintText: 'Father Name',
                  controller: provider.fatherNameController,
                  prefixIcon: Icons.person_outline,
                ),

                spaceHeight(12),

                Row(
                  children: [
                    Expanded(
                      child: customTextField(
                        hintText: 'Mobile Number',
                        controller: provider.mobileNumberController,
                        keyboardType: TextInputType.phone,
                        prefixIcon: Icons.call,
                      ),
                    ),
                    spaceWidth(12),
                    Expanded(
                      child: customTextField(
                        hintText: 'Alternate Mobile Number',
                        controller: provider.alternateMobileNumberController,
                        keyboardType: TextInputType.phone,
                        prefixIcon: Icons.phone_android,
                      ),
                    ),
                  ],
                ),

                spaceHeight(12),

                customTextField(
                  hintText: 'Email',
                  controller: provider.emailController,
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: Icons.email,
                ),

                spaceHeight(12),

                /// DOB
                customTextField(
                  hintText: 'Date Of Birth',
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

                Row(
                  children: [
                    Expanded(
                      child: customDropdown(
                        value: provider.genderController.text,
                        label: 'Gender',
                        items: const ['Male', 'Female', 'Other'],
                        onChanged: (value) {
                          provider.changeGender(value);
                        },
                      ),
                    ),

                    spaceWidth(12),

                    Expanded(
                      child: customDropdown(
                        value: provider.maritalStatusController.text,
                        label: 'Marital Status',
                        items: const ['Single', 'Married', 'Divorced'],
                        onChanged: (value) {
                          provider.changeMaritalStatus(value);
                        },
                      ),
                    ),
                  ],
                ),

                spaceHeight(12),

                /// Address Line 1
                customTextField(
                  hintText: 'Address Line 1',
                  controller: provider.addressLine1Controller,
                  prefixIcon: Icons.home,
                ),

                spaceHeight(12),

                /// Address Line 2
                customTextField(
                  hintText: 'Address Line 2',
                  controller: provider.addressLine2Controller,
                  prefixIcon: Icons.location_on,
                ),

                spaceHeight(12),

                Row(
                  children: [
                    Expanded(
                      child: customTextField(
                        hintText: 'City',
                        controller: provider.cityController,
                        prefixIcon: Icons.location_city,
                      ),
                    ),

                    spaceWidth(12),

                    /// State
                    Expanded(
                      child: customTextField(
                        hintText: 'State',
                        controller: provider.stateController,
                        prefixIcon: Icons.map,
                      ),
                    ),
                  ],
                ),
                spaceHeight(12),

                /// Pincode
                Row(
                  children: [
                    Expanded(
                      child: customTextField(
                        hintText: 'Pincode',
                        controller: provider.pincodeController,
                        keyboardType: TextInputType.number,
                        prefixIcon: Icons.pin_drop,
                      ),
                    ),

                    spaceWidth(12),

                    /// Country
                    Expanded(
                      child: customTextField(
                        hintText: 'Country',
                        controller: provider.countryController,
                        prefixIcon: Icons.public,
                      ),
                    ),
                  ],
                ),
                spaceHeight(12),

                /// Occupation
                customTextField(
                  hintText: 'Occupation',
                  controller: provider.occupationController,
                  prefixIcon: Icons.work,
                ),

                spaceHeight(12),

                /// Designation
                customTextField(
                  hintText: 'Designation',
                  controller: provider.designationController,
                  prefixIcon: Icons.badge,
                ),
                spaceHeight(12),

                customMultiSelectDropdown(
                  title: 'Company List',
                  selectedItems: provider.selectedCompanies,
                  prefixIcon: Icons.work,
                  onConfirm: (value)async {
                    provider.selectedCompanyIds = provider.companyListData
                        .where((company) => value.contains(company.companyName))
                        .map((e) => e.id ?? '')
                        .toList();
                    print('adbfakjbdsf');
                    print(provider.selectedCompanies);
                    print(provider.selectedCompanyIds);
                    provider.notifyListeners();
                   await provider.fetchProductList();
                  },
                  items: provider.companyListData
                      .map((e) => e.companyName ?? '')
                      .toList(),
                ),
                spaceHeight(12),
                customMultiSelectDropdown(
                  title: 'Products List',
                  selectedItems: provider.selectedProducts,
                  prefixIcon: Icons.work,
                  onConfirm: (value) {
                    provider.selectedProductIds = provider.productListData
                        .where((product) => value.contains(product.name))
                        .map((e) => e.id ?? '')
                        .toList();
                  },
                  items: provider.productListData
                      .map((e) => e.name ?? '')
                      .toList(),
                ),
                spaceHeight(12),

                /// Experience
                customTextField(
                  hintText: 'Experience',
                  controller: provider.experienceController,
                  prefixIcon: Icons.timeline,
                ),

                spaceHeight(12),

                /// Education
                customTextField(
                  hintText: 'Education',
                  controller: provider.educationController,
                  prefixIcon: Icons.school,
                ),

                spaceHeight(12),

                /// Annual Income
                customTextField(
                  hintText: 'Annual Income',
                  controller: provider.annualIncomeController,
                  keyboardType: TextInputType.number,
                  prefixIcon: Icons.currency_rupee,
                ),

                spaceHeight(12),

                /// Monthly Income
                customTextField(
                  hintText: 'Monthly Income',
                  controller: provider.monthlyIncomeController,
                  keyboardType: TextInputType.number,
                  prefixIcon: Icons.account_balance_wallet,
                ),

                spaceHeight(20),

                /// Experience Upload
                uploadCard(
                  title: 'Upload Experience Document',
                  file: provider.experienceDocument,
                  onTap: () {
                    provider.pickExperienceDocument(context);
                  },
                ),

                spaceHeight(16),

                /// Education Upload
                uploadCard(
                  title: 'Upload Education Document',
                  file: provider.educationDocument,
                  onTap: () {
                    provider.pickEducationDocument(context);
                  },
                ),

                spaceHeight(30),

                /// Submit Button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: provider.isLoading ? null : () =>
                      provider.updateCreateProfile(context),
                    child: provider.isLoading
                        ? const CircularProgressIndicator()
                        : const Text('Update Profile'),
                  ),
                ),

                spaceHeight(30),
              ],
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

                  spaceHeight(4),

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
