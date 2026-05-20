import 'package:app_grownidhi/widget/custom_appbat.dart';
import 'package:app_grownidhi/widget/custom_textfield.dart';
import 'package:app_grownidhi/widget/ui_design.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'agent_client_member_update_create_provider.dart';

class AgentClientMemberUpdateCreateScreen extends StatelessWidget {
  final int clientUserId;
  const AgentClientMemberUpdateCreateScreen({super.key, required this.clientUserId});

  @override
  Widget build(BuildContext context) {
    return Consumer<AgentClientMemberUpdateCreateProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          appBar: CustomAppBar(title: 'Add / Update Client Member'),

          body: Stack(
            children: [
              /// BACKGROUND
              AppGradientBackground(),

              SingleChildScrollView(
                padding: const EdgeInsets.all(16),

                child: Column(
                  children: [
                    /// IMAGE PICKER
                    GestureDetector(
                      onTap: () async {
                        await provider.pickImage(context);
                      },

                      child: Container(
                        height: 120,
                        width: 120,

                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.12),

                          shape: BoxShape.circle,

                          border: Border.all(color: Colors.white, width: 2),
                        ),

                        child: provider.imageFile != null
                            ? ClipOval(
                                child: Image.file(
                                  provider.imageFile!,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : const Icon(
                                Icons.add_a_photo,
                                color: Colors.white,
                                size: 40,
                              ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    /// FORM CARD
                    Container(
                      padding: const EdgeInsets.all(18),

                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(28),
                      ),

                      child: Column(
                        children: [
                          customTextField(
                            controller: provider.nameController,
                            hintText: "Name",
                          ),

                          const SizedBox(height: 16),

                          customDropdown(
                            label: "Relationship",
                            value: provider.relationship,
                            items: const [
                              "Father",
                              "Mother",
                              "Brother",
                              "Sister",
                              "Spouse",
                              "Child",
                            ],

                            onChanged: (value) {
                              provider.relationship = value;

                              provider.notifyListeners();
                            },
                          ),

                          const SizedBox(height: 16),

                          customTextField(
                            controller: provider.dobController,
                            hintText: "Date of Birth",
                            isRead: true,
                            onTap: ()=> pickDateTime(context,provider.dobController, includeTime: false)
                          ),

                          const SizedBox(height: 16),

                          customDropdown(
                            label: "Gender",
                            value: provider.gender,
                            items: const ["Male", "Female", "Other"],

                            onChanged: (value) {
                              provider.gender = value;

                              provider.notifyListeners();
                            },
                          ),

                          const SizedBox(height: 16),

                          customDropdown(
                            label: "Dependent",
                            value: provider.isDependent == null
                                ? null
                                : provider.isDependent == true
                                ? "Yes"
                                : "No",

                            items: const ["Yes", "No"],

                            onChanged: (value) {
                              provider.isDependent = value == "Yes";

                              provider.notifyListeners();
                            },
                          ),

                          const SizedBox(height: 16),

                          customTextField(
                            controller: provider.annualIncomeController,
                            hintText: "Annual Income",
                            keyboardType: TextInputType.number,
                          ),

                          const SizedBox(height: 16),

                          customTextField(
                            controller: provider.occupationController,
                            hintText: "Occupation",
                          ),

                          const SizedBox(height: 16),

                          customTextField(
                            controller: provider.panController,
                            hintText: "PAN Number",
                          ),

                          const SizedBox(height: 16),

                          customTextField(
                            controller: provider.aadharController,
                            hintText: "Aadhar Number",
                            keyboardType: TextInputType.number,
                          ),

                          const SizedBox(height: 16),

                          customTextField(
                            controller: provider.contactController,
                            hintText: "Contact Number",
                            keyboardType: TextInputType.phone,
                          ),

                          const SizedBox(height: 16),

                          customTextField(
                            controller: provider.emailController,
                            hintText: "Email",
                          ),

                          const SizedBox(height: 16),

                          customTextField(
                            controller: provider.notesController,
                            hintText: "Notes",
                            maxLines: 4,
                          ),

                          const SizedBox(height: 24),

                          /// SAVE BUTTON
                          InkWell(
                            onTap: () {
                              provider.submitData(context, clientUserId);
                            },

                            borderRadius: BorderRadius.circular(18),

                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(vertical: 16),

                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xff4A00E0),
                                    Color(0xff8E2DE2),
                                  ],
                                ),

                                borderRadius: BorderRadius.circular(18),
                              ),

                              child: const Center(
                                child: Text(
                                  "Save Member",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
