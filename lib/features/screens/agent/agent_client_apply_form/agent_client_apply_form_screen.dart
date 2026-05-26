import 'dart:io';
import 'dart:math';

import 'package:app_grownidhi/features/screens/agent/agent_client_apply_form/agent_client_apply_form_provider.dart';
import 'package:app_grownidhi/widget/custom_button.dart';
import 'package:app_grownidhi/widget/custom_textfield.dart';
import 'package:app_grownidhi/widget/help_widget.dart';
import 'package:app_grownidhi/widget/ui_design.dart';
import 'package:base_module/core/models/product_apply_form_response.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AgentClientApplyFormScreen extends StatefulWidget {
  final int productId;
  const AgentClientApplyFormScreen({super.key, required this.productId});

  @override
  State<AgentClientApplyFormScreen> createState() =>
      _AgentClientApplyFormScreenState();
}

class _AgentClientApplyFormScreenState
    extends State<AgentClientApplyFormScreen> {
  @override
  void initState() {
    // TODO: implement initState
    Future.microtask(() {
      context.read<AgentClientApplyFormProvider>().fetchApplyForm(
        widget.productId,
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AppGradientBackground(),
          Consumer<AgentClientApplyFormProvider>(
            builder: (context, provider, child) {
              if (provider.isLoading) {
                return Center(child: CircularProgressIndicator());
              }
              if (provider.productApplyForm.formFields == null ||
                  provider.productApplyForm.formFields!.isEmpty) {
                return buildEmptyState(
                  title: "No Members Found",
                  subTitle: "Looks like there are no family members added yet.",
                  icon: Icons.group_off_rounded,
                );
              }
              return SingleChildScrollView(
                child: Column(
                  children: [
                    buildProductHeader(provider.productApplyForm.product),
                    spaceHeight(20),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          /// ================= CLIENT =================
                          Expanded(
                            child: customMultiSelectDropdown(
                              title: 'Client Data',
                              items: provider.clientData.agentClientData
                                  .map((e) => e.name ?? '')
                                  .toList(),
                              selectedItems: provider.selectedClientNames,
                              onConfirm: (values) {
                                provider.selectedClientNames = values;

                                provider.selectedClientIds = provider
                                    .clientData
                                    .agentClientData
                                    .where((e) => values.contains(e.name))
                                    .map((e) => e.id ?? 0)
                                    .toList();

                                provider.notifyListeners();
                              },
                            ),
                          ),

                          spaceWidth(20),

                          /// ================= COMPANY =================
                          Expanded(
                            child: customMultiSelectDropdown(
                              title: 'Company Data',

                              items: provider.companyData
                                  .map((e) => e.companyName ?? '')
                                  .toList(),

                              selectedItems: provider.selectedCompanyNames,

                              onConfirm: (values) {
                                provider.selectedCompanyNames = values;

                                provider.selectedCompanyIds = provider
                                    .companyData
                                    .where(
                                      (e) => values.contains(e.companyName),
                                    )
                                    .map((e) => e.id ?? 0)
                                    .toList();

                                provider.notifyListeners();
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    spaceHeight(10),
                    ListView.builder(
                      padding: EdgeInsets.all(11),
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: provider.productApplyForm.formFields?.length,
                      itemBuilder: (context, index) => buildTextField(
                        provider.productApplyForm.formFields![index],
                        provider,
                      ),
                    ),
                    spaceHeight(20),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: CustomLoadingButton(
                        isLoading: provider.isSubmitLoading,
                        onTap: () => provider.productFormApply(
                          context,
                          provider.productApplyForm.product,
                        ),
                        text: 'Apply Form',
                      ),
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

  Widget buildProductHeader(Product? product) {
    return Stack(
      children: [
        Container(
          height: 80,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withOpacity(0.3),
                  Colors.black.withOpacity(0.7),
                ],
              ),
            ),
          ),
        ),

        // Back Button
        Positioned(
          top: 10,
          left: 20,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Icon(Icons.arrow_back_ios_new, size: 20),
                ),
              ),
              spaceWidth(20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Category & Subcategory
                  Row(
                    children: [
                      _buildTag(product?.categoryName ?? 'Category'),
                      const SizedBox(width: 10),
                      if (product?.subcategoryName != null)
                        _buildTag(
                          product!.subcategoryName!,
                          color: Colors.white.withOpacity(0.3),
                        ),
                    ],
                  ),
                  // Product Name
                  Text(
                    product?.productName ?? 'Product Name',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          blurRadius: 10,
                          color: Colors.black26,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTag(String text, {Color? color}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color ?? Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.3), width: 1),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget buildTextField(
    FormFields formField,
    AgentClientApplyFormProvider provider,
  ) {
    if (formField.fieldType == 'text') {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: customTextField(
          hintText: formField.label ?? 'Not Defined',
          controller: provider.controller.putIfAbsent(
            formField.fieldName ?? '',
            () => TextEditingController(),
          ),
        ),
      );
    }
    if (formField.fieldType == 'number') {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: customTextField(
          hintText: formField.label ?? 'Not Defined',
          keyboardType: TextInputType.number,
          controller: provider.controller[formField.label],
        ),
      );
    }
    if (formField.fieldType == 'date') {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: customTextField(
          hintText: formField.label ?? 'Not Defined',
          isRead: true,
          controller: provider.controller[formField.label],
          onTap: () => pickDateTime(
            context,
            provider.controller.putIfAbsent(
              formField.fieldName ?? '',
              () => TextEditingController(),
            ),
          ),
        ),
      );
    }
    if (formField.fieldType == 'textarea') {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: customTextField(
          hintText: formField.label ?? 'Not Defined',
          maxLines: 3,
          controller: provider.controller[formField.label],
        ),
      );
    }
    if (formField.fieldType == 'select') {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: customDropdown(
          hintText: formField.label ?? 'Not Defined',
          label: formField.fieldName ?? 'Not Defined',
          items: (formField.options ?? [])
              .map((value) => value.toString())
              .toList(),
          onChanged: (value) {
            provider.setDropdownValue(formField.fieldName ?? '', value ?? '');
          },
          value: provider.selectedDropdown[formField.fieldName],
        ),
      );
    }
    if (formField.fieldType == 'radio') {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: customRadioGroup(
          title: formField.label ?? '',
          options: (formField.options ?? [])
              .map((value) => value.toString())
              .toList(),
          groupValue: provider.selectedRadio[formField.fieldName] ?? '',
          onChanged: (value) {
            provider.setRadioValue(formField.fieldName ?? '', value);
          },
        ),
      );
    }
    if (formField.fieldType == 'checkbox') {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: customCheckboxGroup(
          title: formField.label ?? '',
          options: (formField.options ?? [])
              .map((value) => value.toString())
              .toList(),
          isChecked: (value) {
            return provider.isChecked(formField.fieldName ?? '', value);
          },
          onTap: (value) {
            provider.toggleCheckbox(formField.fieldName ?? '', value);
          },
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: buildImagePickUp(
          context: context,
          provider: provider,
          title: formField.label ?? '',
          imageFile: provider.selectedImages[formField.fieldName],
          onImagePicked: (file) {
            provider.selectedImages[formField.fieldName ?? ''] = file;
            provider.notifyListeners();
          },
        ),
      );
    }
  }

  Widget buildImagePickUp({
    required BuildContext context,
    required AgentClientApplyFormProvider provider,
    required String title,
    required File? imageFile,
    required Function(File?) onImagePicked,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 12),

        GestureDetector(
          onTap: () async {
            await provider.imagePicker.showImageSourceDialog(
              context: context,
              onImagePicked: (xFile) {
                if (xFile != null) {
                  onImagePicked(File(xFile.path));
                }
              },
            );
          },

          child: Container(
            width: double.infinity,
            height: 180,

            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.08),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: Colors.white.withOpacity(0.2)),
            ),

            child: imageFile != null
                ? Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: Image.file(
                          imageFile,
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),

                      Positioned(
                        top: 10,
                        right: 10,
                        child: GestureDetector(
                          onTap: () {
                            onImagePicked(null);
                          },

                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.6),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.12),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.cloud_upload_outlined,
                          color: Colors.white,
                          size: 35,
                        ),
                      ),

                      const SizedBox(height: 14),

                      const Text(
                        "Tap to upload image",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      const SizedBox(height: 6),

                      Text(
                        "PNG, JPG, JPEG",
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ],
    );
  }
}
