import 'package:app_grownidhi/widget/ui_design.dart';
import 'package:flutter/material.dart';

import '../../../../widget/custom_appbat.dart';
import '../../../../widget/custom_button.dart';
import '../../../../widget/custom_textfield.dart';
import '../../../../widget/help_widget.dart';
import 'package:provider/provider.dart';

import 'individivual_add_member_provider.dart';


class IndividualAddMemberScreen extends StatelessWidget {
  const IndividualAddMemberScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AppGradientBackground(),
          Consumer<IndividualAddMemberProvider>(
            builder: (context, provider, child) {
              return CustomScrollView(
                slivers: [
                  CustomSliverAppBar(
                    title: 'Members',
                  ),

                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [

                          /// Name
                          customTextField(
                            controller: provider.nameController,
                            hintText: "Full Name",
                          ),

                          spaceHeight(12),

                          /// Relationship
                          customDropdown(

                                items:  [
                                  "Father",
                                  "Mother",
                                  "Brother",
                                  "Sister",
                                  "Son",
                                  "Daughter",
                                  "Husband",
                                  "Wife",
                                  "Grandfather",
                                  "Grandmother",
                                  "Uncle",
                                  "Aunt",
                                  "Cousin",
                                  "Nephew",
                                  "Niece",
                                  "Guardian",
                                  "Other",
                                ],
                            value:
                            provider.relationshipController.text,
                            hintText: "Relationship",
                            label: "Relationship",
                            onChanged: (value){
                              provider.relationshipController.text = value ?? '';
                              provider.notifyListeners();
                            }
                          ),

                          spaceHeight(12),

                          /// DOB
                          customTextField(
                            controller: provider.dobController,
                            hintText: "Date of Birth",
                            isRead: true,
                            onTap: () {
                              pickDateTime(
                                context,
                                provider.dobController,
                                includeTime: false,
                              );
                            },
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

                          /// Is Dependent
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius.circular(12),
                              border: Border.all(
                                color: Colors.white24,
                              ),
                            ),
                            child: Row(
                              children: [
                                const Expanded(
                                  child: Text(
                                    "Is Dependent",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),

                                Switch(
                                  value: provider.isDependent,
                                  onChanged: (value) {
                                    provider.isDependent = value;
                                    provider.notifyListeners();
                                  },
                                ),
                              ],
                            ),
                          ),

                          spaceHeight(12),

                          /// Annual Income
                          customTextField(
                            controller:
                            provider.annualIncomeController,
                            hintText: "Annual Income",
                            keyboardType:
                            TextInputType.number,
                          ),

                          spaceHeight(12),

                          /// Occupation
                          customTextField(
                            controller:
                            provider.occupationController,
                            hintText: "Occupation",
                          ),

                          spaceHeight(12),

                          /// PAN
                          customTextField(
                            controller: provider.panController,
                            hintText: "PAN Number",
                          ),

                          spaceHeight(12),

                          /// Aadhaar
                          customTextField(
                            controller:
                            provider.aadharController,
                            hintText: "Aadhaar Number",
                            keyboardType:
                            TextInputType.number,
                          ),

                          spaceHeight(12),

                          /// Contact Number
                          customTextField(
                            controller:
                            provider.contactNumberController,
                            hintText: "Contact Number",
                            keyboardType:
                            TextInputType.phone,
                          ),

                          spaceHeight(12),

                          /// Email
                          customTextField(
                            controller: provider.emailController,
                            hintText: "Email",
                            keyboardType:
                            TextInputType.emailAddress,
                          ),

                          spaceHeight(12),

                          /// Notes
                          customTextField(
                            controller: provider.notesController,
                            hintText: "Notes",
                            maxLines: 4,
                          ),

                          spaceHeight(20),

                          /// Document Upload
                          documentUploadWidget(
                            label: "Upload Document",
                            imageFile: provider.documentImage,
                            onPick: () {
                              provider.pickImage(
                                context: context,
                              );
                            },
                            onRemove: () {
                              provider.removeImage();
                            },
                          ),

                          spaceHeight(30),

                          /// Submit Button
                          CustomLoadingButton(
                            isLoading: provider.isLoad,
                            text: "Submit",
                            loadingText: "Submitting...",
                            onTap: () {
                              provider.addUpdateMembers();
                            },
                          ),

                          spaceHeight(30),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}