import 'dart:io';

import 'package:app_grownidhi/widget/custom_textfield.dart';
import 'package:base_module/image_file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../widget/custom_appbat.dart';
import '../../../../widget/custom_button.dart';
import '../../../../widget/help_widget.dart';
import '../../../../widget/ui_design.dart';
import 'kyc_update_provider.dart';

class KycUpdateScreen extends StatefulWidget {
  const KycUpdateScreen({super.key});

  @override
  State<KycUpdateScreen> createState() => _KycUpdateScreenState();
}

class _KycUpdateScreenState extends State<KycUpdateScreen> {

  @override
  void initState() {
    // TODO: implement initState
    Future.microtask(()=>  context.read<KycUpdateProvider>().fetchKYCData());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AppGradientBackground(),

          Consumer<KycUpdateProvider>(
            builder: (context, provider, child) {
              return CustomScrollView(
                slivers: [
                  CustomSliverAppBar(title: 'Kyc Update'),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          profileImagePicker(
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
                            controller: provider.accountHolderController,
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
                            controller: provider.accountNumberController,
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

                          spaceHeight(20),
                          Row(
                            children: [
                              Expanded(
                                child: documentUploadWidget(
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
                              ),
                              spaceWidth(20),
                              Expanded(
                                child: documentUploadWidget(
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
                              ),
                            ],
                          ),

                          spaceHeight(20),

                          Row(
                            children: [
                              Expanded(
                                child: documentUploadWidget(
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
                              ),
                              spaceWidth(20),

                              Expanded(
                                child: documentUploadWidget(
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
                              ),
                            ],
                          ),
                          spaceHeight(24),
                          provider.individualKYCData.kycStatus != 'approved'
                          ? CustomLoadingButton(
                            isLoading: provider.isSubmitLoad,
                            text: "Submit KYC",
                            loadingText: "Submitting...",
                            onTap: () => provider.submitKycUpdate(context),
                          )
                          : SizedBox.shrink(),
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
